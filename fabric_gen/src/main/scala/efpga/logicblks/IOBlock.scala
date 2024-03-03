package efpga.logicblks


import chisel3._
import chisel3.util.RegEnable
import efpga.utils._
import efpga.tiles.TileIO

import scala.collection.immutable.SortedMap

class IOBlock(numIOs: Int = 32) extends LogicBlockImpl {

  // Provide information about LB
  override val info: LogicBlockInfo = LogicBlockInfo("iotile", numConfBits = 16, hasIO = true, 32, 32)
  val (numIPINs, numOPINs) = (numIOs, numIOs)

  // Populate required IPINs and OPINs based on VPR arch / rr.xml files
  // 0-31 IPINs | 32-63- OPIN

  override val IPINs: SortedMap[Int, Bool] = SortedMap( (0 until numIPINs).map(i =>
    ( i, IO(Input(Bool())).suggestName(s"IPIN_${i}") )): _*)

  override val OPINs: SortedMap[Int, Bool] = SortedMap ( (numIPINs until numIPINs+numOPINs).map(i =>
    ( i, IO(Output(Bool())).suggestName(s"OPIN_${i}") ) ): _*)

  override val clock: Clock = IO(Input(Clock()))
  override val reset: Bool  = IO(Input(Bool()))
  override val ioPad: Option[TileIO] = Some(IO(TileIO(numIOs, numIOs)))
  override val configBits: UInt = IO(Input(UInt(info.numConfBits.W)))
  //override val loopBreak: Bool = IO(Input(Bool()))
  override val gndLBouts: Bool = IO(Input(Bool()))
  override val pathBreak: Bool = IO(Input(Bool()))


  // IPIN wires
  withClockAndReset(clock, reset) {
    // IPIN to pad out
    val LBIns = IPINs.values.toList.zipWithIndex.map {
      case (iPin, i) =>
        withClockAndReset(clock, reset) {
          PathBreakFF(iPin, configBits(15) | pathBreak, s"pb_IPIN_FF_$i")
        }
    }
    //val padOutReg = RegEnable(VecInit(IPINs.values.toList).asUInt, 0.U(numIOs.W), configBits(15)).suggestName("padOutReg")
    //val padOut = Mux(configBits(15) | loopBreak, padOutReg, VecInit(IPINs.values.toList).asUInt)
    ioPad.get.o := VecInit(LBIns).asUInt

    // OPIN wires
    OPINs.values.zipWithIndex.foreach { case (pin, i) =>
      pin := withClockAndReset(clock, reset) {
        PathBreakFF(ioPad.get.i(i), configBits(15) | pathBreak, s"pb_OPIN_FF_$i")
      }
    }

    //val padInReg = RegEnable(ioPad.get.i, 0.U, configBits(15))
    //val padIn =  Mux(configBits(15) | loopBreak, padInReg, ioPad.get.i)
    //val padIngnd = Mux(gndLBouts, 0.U, padIn)
    //OPINs.values.zipWithIndex.foreach{ case(opin, id) => opin := padInReg.asBools(id) }
    //connOPINs(OPINs.values.toSeq, padIngnd)

  }

  def connOPINs(boolSink: Seq[Bool], intSrc: UInt): Unit = {
    boolSink.zipWithIndex.foreach{ case(sinkPin, id) => sinkPin := intSrc(id) }
  }
}

object IoBlockDriver extends App {
  val stage = circt.stage.ChiselStage
  stage.emitSystemVerilogFile(new IOBlock(32), Array("-td", "verilog/logicBlocks"))
}