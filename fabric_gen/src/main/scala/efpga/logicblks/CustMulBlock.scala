package efpga.logicblks

import chisel3._
import chisel3.util.{Cat, HasBlackBoxPath, HasBlackBoxResource, MuxLookup, RegEnable}
import efpga.tiles.TileIO
import efpga.utils._

import scala.collection.immutable.SortedMap

class CustMulBlock() extends LogicBlockImpl {

  // Provide information about LB
  override val info: LogicBlockInfo = LogicBlockInfo(name="custmultile", numConfBits = 32)
  val (numIPINs, numOPINs) = (32, 16)

  // Populate required LB IO PINS
  // 0-31 IPINs | 32-47 OPINs

  override val IPINs: SortedMap[Int, Bool] = SortedMap( (0 until numIPINs).map(i =>
    ( i, IO(Input(Bool())).suggestName(s"IPIN_${i}") )): _*)

  override val OPINs: SortedMap[Int, Bool] = SortedMap ( (numIPINs until numIPINs+numOPINs).map(i =>
    ( i, IO(Output(Bool())).suggestName(s"OPIN_${i}") ) ): _*)

  override val clock: Clock = IO(Input(Clock()))
  override val reset: Bool  = IO(Input(Bool()))
  override val ioPad: Option[TileIO] = None
  override val configBits: UInt = IO(Input(UInt(info.numConfBits.W)))
  //override val loopBreak: Bool = IO(Input(Bool()))
  override val pathBreak: Bool = IO(Input(Bool()))
  override val gndLBouts: Bool = IO(Input(Bool()))

  // IPIN wires
  val LBIns = IPINs.values.toList.zipWithIndex.map {
    case (iPin, i) =>
      withClockAndReset(clock, reset) {
        PathBreakFF(iPin, configBits(31) | pathBreak, s"pb_IPIN_FF_$i")
      }
  }
  val I: Seq[UInt] = LBIns.toList.grouped(16).toList.map(ipinVec => VecInit(ipinVec).asUInt)

  // OPIN wires
  val custMul = Module(new fqmul())
  custMul.io.a_in_mul := I(0).asSInt
  custMul.io.b_in_mul := I(1).asSInt

  // OPIN wires
  OPINs.values.zipWithIndex.foreach { case (pin, i) =>
    pin := withClockAndReset(clock, reset) {
      PathBreakFF(custMul.io.c_out_mul(i), configBits(31) | pathBreak, s"pb_OPIN_FF_$i")
    }
  }

}

class fqmul extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle {
    val a_in_mul = Input(SInt(16.W))
    val b_in_mul = Input(SInt(16.W))
    val c_out_mul = Output(SInt(16.W))
  })
  //addPath("src/main/resources/custMul.v")
}


object CustMulDriver extends App {
  args.foreach(println(_))
  val stage = circt.stage.ChiselStage
  //stage.emitSystemVerilog(new EccMemTest(8), Array("-td", "verilog/eccmemtest", "--repl-seq-mem", s"-c:EccMemTest:-o:EccMemTest.mems.conf"))
  stage.emitSystemVerilogFile(new CustMulBlock, Array("-td", "verilog/logicBlocks"))
}