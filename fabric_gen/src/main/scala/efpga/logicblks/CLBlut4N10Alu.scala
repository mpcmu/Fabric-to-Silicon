package efpga.logicblks

import chisel3._
import chisel3.util.{MuxLookup, Cat}
import chisel3.util.RegEnable
import efpga.tiles.TileIO
import efpga.utils._

import scala.collection.immutable.SortedMap

class CLBlut4N10Alu() extends LogicBlockImpl {

  // Provide information about LB
  override val info: LogicBlockInfo = LogicBlockInfo(name="clbalutile", numConfBits = 8*20 + 32 + 2, hasIO = false)
  val (lutCnt, numIPINs, numOPINs) = (8, 42, 17)

  // Populate required IPINs and OPINs based on VPR arch / rr.xml files
  // 0-39 IPINs | 40 - CIN | 41 Rst | 42-57 OPINs | 58 COUT

  override val IPINs: SortedMap[Int, Bool] = SortedMap( (0 until numIPINs).map(i =>
    ( i, IO(Input(Bool())).suggestName(s"IPIN_${i}") )): _*)

  override val OPINs: SortedMap[Int, Bool] = SortedMap ( (numIPINs until numIPINs+numOPINs).map(i =>
    ( i, IO(Output(Bool())).suggestName(s"OPIN_${i}") ) ): _*)

  override val clock: Clock = IO(Input(Clock()))
  override val reset: Bool  = IO(Input(Bool()))
  override val ioPad: Option[TileIO] = None
  override val configBits: UInt = IO(Input(UInt(info.numConfBits.W)))
  //override val loopBreak: Bool = IO(Input(Bool()))
  override val gndLBouts: Bool = IO(Input(Bool()))
  override val pathBreak: Bool = IO(Input(Bool()))


  // IPIN wires
  val LBIns = IPINs.values.toList.zipWithIndex.map {
    case (iPin, i) => withClockAndReset(clock, reset) { PathBreakFF(iPin, pathBreak, s"pb_IPIN_FF_$i")}
  }
  val I: Seq[UInt] = LBIns.grouped(8).toList.map(ipinVec => VecInit(ipinVec).asUInt)
  val IPINsasUint = VecInit(LBIns).asUInt

  // OPIN wires
  val OAlu = Wire(Vec(numOPINs,Bool()))
  val OClb = Wire(Vec(numOPINs,Bool()))
  OPINs.values.zipWithIndex.foreach{ case(pin,i) =>
    val aluClbMux = Mux(configBits(info.numConfBits-2), OAlu(i) , OClb(i)) & !gndLBouts
    pin := withClockAndReset(clock, reset) { PathBreakFF(aluClbMux, pathBreak, s"pb_OPIN_FF_$i") }
  }

  // ALU (ADD16)
  val alu = withClockAndReset(clock, reset) { Module(new AluAdd16()) }
  alu.io.i0 := IPINsasUint(15,0)
  alu.io.i1 := IPINsasUint(31,16)
  alu.io.ctrl := IPINsasUint(39,32)
  alu.io.cin := IPINsasUint(40)
  (0 until 16).foreach { i => OAlu(i) := alu.io.q(i) }
  OAlu(16) := alu.io.cout
  alu.io.clkEnb := configBits(info.numConfBits-1)
  alu.io.config := configBits(info.numConfBits-2-1,info.numConfBits-32-2)

  // CLB
  withClockAndReset(clock, reset) {
    // Bles
    val bles = (0 until lutCnt).map(i => Module(new Ble4).suggestName(s"BLE_$i"))
    for (i <- (0 until lutCnt)) {
      val idx = 20*i
      //bles(i).io.config := configBits(20*(i+1)-1, 20*i)
      bles(i).io.config := configBits(idx+20-1, idx)
      (0 until 4).foreach(pin => bles(i).io.in(pin) := MuxLookup(Cat(configBits(idx+19), configBits(idx+18)), 0.U.asBool)(
        Array(3.U -> I(pin)((i + 3) % lutCnt), 2.U -> I(pin)((i + 2) % lutCnt), 1.U -> I(pin)((i + 1) % lutCnt), 0.U -> I(pin)(i))))
      OClb(i) := bles(i).io.outR
      OClb(i+8) := bles(i).io.outT
      bles(i).io.gndOuts := gndLBouts
      bles(i).io.clkEnb := configBits(info.numConfBits-1)
      //bles(i).io.loopBreak := loopBreak
    }
  }
  (16 until numOPINs).foreach{ i => OClb(i) := 0.U}

  def connInttoBools(boolSink: Seq[Bool], intSrc: UInt): Unit = {
    val intAsBool = intSrc.asBools
    boolSink.zipWithIndex.foreach{ case(sinkPin, id) => sinkPin := intAsBool(id) }
  }
}

class Ble4 extends Module {
  val io = IO(new Bundle() {
    val config = Input(UInt(20.W))
    val in = Input(Vec(4,Bool()))
    val outR = Output(Bool())
    val outT = Output(Bool())
    val gndOuts = Input(Bool())
    val clkEnb = Input(Bool())
    //val loopBreak = Input(Bool())
  })

  private val lut = Module(new Mux16CE)
  lut.in := io.config(15,0)
  lut.sel := io.in.asUInt

  private val bleFF = RegEnable(lut.o, 0.U, !io.clkEnb)

  // Out muxes
  //io.outR := Mux(io.config(16) & !io.loopBreak, lut.o, bleFF)
  //io.outT := Mux(io.config(17) & !io.loopBreak, lut.o, bleFF)
  io.outR := Mux(io.config(16) , lut.o, bleFF)
  io.outT := Mux(io.config(17) , lut.o, bleFF)

}

class AluAdd16 extends Module {
  val io = IO(new Bundle() {
    val i0 = Input(UInt(16.W))
    val i1 = Input(UInt(16.W))
    val cin = Input(UInt(1.W))
    val ctrl = Input(UInt(8.W))
    val q = Output(UInt(16.W))
    val cout = Output(UInt(1.W))

    val config = Input(UInt(32.W))
    val clkEnb = Input(Bool())
  })

  // Config: bit0 = 1 => sub | bit1 = 1 => use carry chain carry-in
  // CTRL(0) - ext_carry_in
  val op0 = io.i0
  val op1 = Mux(io.config(0), ~io.i1, io.i1).asUInt
  val carryIn = Mux(io.config(1), io.cin, io.ctrl(0)).asUInt
  val sum = op0 +& op1 + carryIn + io.config(0).asUInt
  io.q := sum
  io.cout := sum(16)

}

object ClbriverAlu extends App {
  val stage = circt.stage.ChiselStage
  //stage.emitSystemVerilog(new EccMemTest(8), Array("-td", "verilog/eccmemtest", "--repl-seq-mem", s"-c:EccMemTest:-o:EccMemTest.mems.conf"))
  stage.emitSystemVerilogFile(new CLBlut4N10Alu, Array("-td", "verilog/logicBlocks"))
}