// See README.md for license details.
// XML Parser

package efpga.utils


import chisel3._
import chisel3.util.{Cat, MuxLookup, log2Up}
import chisel3.withClock
import vtrutils.RRgraph
import vtrutils._

import scala.collection.mutable
import scala.math.pow
import java.io._

class MuxNInputSCAOptCB(nodes: Seq[Int]) extends RawModule {

  override def desiredName: String = s"MuxNInput_${nodes.length}_SCAOptCB"

  val numPins = nodes.length
  val muxIns = numPins + 1 // add a 0.U at MSB for unused CB
  val muxConfigSize = log2Up(muxIns)

  val io = IO(new Bundle {
    val in = Input(UInt(numPins.W))
    //val config = Input(Vec(muxConfigSize, Bool()))
    val config = Input(UInt(muxConfigSize.W))
    val out = Output(Bool())
    //val loopBreak = Input(Bool())
    val ioGndBle = Input(Bool())
    val cnstClk = Input(Clock())
    val pathBreak = Input(Bool())
  })

    //val muxSelect = Vec((0 until configSize - 1).map(io.config(_))).asUInt()
    // Create OPIN & Chan Mux
    val oPinMux: Some[MuxCE] = muxConfigSize match {
      case 1 => Some(Module(new Mux2CE()).suggestName("OPinMux"))
      case 2 => Some(Module(new Mux4CE()).suggestName("OPinMux"))
      case 3 => Some(Module(new Mux8CE()).suggestName("OPinMux"))
      case 4 => Some(Module(new Mux16CE()).suggestName("OPinMux"))
      case 5 => Some(Module(new Mux32CE()).suggestName("OPinMux"))
      case _ => {
        throw new Exception(s"Mux size (${muxIns}) is bigger than 32.. NOT SUPPOERTED")
        Some(Module(new Mux32CE()).suggestName("OPinMux"))
      }
    }
    oPinMux.get.suggestName("OPinMux")

    oPinMux.get.sel := io.config
    oPinMux.get.in := io.in // MSBs will automaticaly connect to 0
    val oPinMuxOut = dontTouch(oPinMux.get.o)

    io.out := oPinMuxOut




}

// TODO: opt for bits later
class MuxNInputSCAOptSB(nodes: Seq[Node], isEmpty: Boolean = false) extends RawModule {

  val opins = nodes.filter(_.ntype=="OPIN").sortBy(_.id)
  val chans = nodes.filter(_.ntype.contains("CHAN")).sortBy(_.id)
  val numOpins = opins.length
  val numChans = chans.length

  override def desiredName: String = s"MuxNInput_O${opins.length}_C${chans.length}_SCAOptSB"

  val numIns = if (nodes.length==0) 1 else numOpins+numChans
  val muxInSize = math.pow(log2Up(math.max(numChans, numOpins)), 2).toInt
  val firstMuxConfigSize = log2Up(math.max(numChans, numOpins))
  val configSize = firstMuxConfigSize+1

  val io = IO(new Bundle {
    val in = Input(UInt(numIns.W))
    val config = Input(UInt(configSize.W))
    val out = Output(Bool())
    //val loopBreak = Input(Bool())
    val ioGndBle = Input(Bool())
    val cnstClk = Input(Clock())
    val pathBreak = Input(Bool())
  })

  //val muxSelect = Vec((0 until configSize - 1).map(io.config(_))).asUInt()
  // Create OPIN & Chan Mux
  //assert(firstMuxConfigSize > 0, "NumIns==0")
  //assert(numIns > 0, "NumIns==0")

  val oPinMux: Option[MuxCE] = firstMuxConfigSize match {
    case 1 => Some(Module(new Mux2CE()))
    case 2 => Some(Module(new Mux4CE()))
    case 3 => Some(Module(new Mux8CE()))
    case 4 => Some(Module(new Mux16CE()))
    case 5 => Some(Module(new Mux32CE()))
    case _ => {
      throw new Exception("Mux size is bigger than 32.. NOT SUPPOERTED")
      Some(Module(new Mux32CE()))
    }
  }

  if(oPinMux.nonEmpty) {
    oPinMux.get.suggestName("OPinMux")
    oPinMux.get.sel := io.config(configSize-2,0)
    if(numOpins>0)
      oPinMux.get.in := io.in(numOpins-1,0)
    else
      oPinMux.get.in := 0.U // MSBs will automatically connect
  }

  val chanMux: Option[MuxCE] = firstMuxConfigSize match {
    case 1 => Some(Module(new Mux2CE()))
    case 2 => Some(Module(new Mux4CE()))
    case 3 => Some(Module(new Mux8CE()))
    case 4 => Some(Module(new Mux16CE()))
    case 5 => Some(Module(new Mux32CE()))
    case _ => {
      throw new Exception("Mux size is bigger than 32.. NOT SUPPOERTED")
      Some(Module(new Mux32CE()))
    }
  }

  //assert(numChans > 0, "SB with numChans==0")
  if(chanMux.nonEmpty) {
    chanMux.get.suggestName("chanMux")
    chanMux.get.sel := io.config(configSize-2,0)
    if (numChans > 0)
      chanMux.get.in := io.in(numIns-1,numOpins)
    else
      chanMux.get.in := 0.U // MSBs will automaticaly connect
  }

  //val outMux = Mux(io.config(configSize-1) || io.loopBreak,

  val outMux = Mux(io.config(configSize-1),
    oPinMux.get.o,
    //LoopBreakBuf(chanMux.get.o.asBool)
    chanMux.get.o.asBool
  )
  io.out := withClock(io.cnstClk) {
    PathBreakFF(LoopBreakBuf(outMux.asBool), io.pathBreak, "pb_SB_FF") & !io.ioGndBle // for sim & timing
  }

}


object MuxNCDriver extends App {
  val stage = circt.stage.ChiselStage
  //stage.emitSystemVerilog(new EccMemTest(8), Array("-td", "verilog/eccmemtest", "--repl-seq-mem", s"-c:EccMemTest:-o:EccMemTest.mems.conf"))
  stage.emitSystemVerilogFile(new MuxNInputSCAOptCB(Seq.fill(9)(1)), Array("-td", "verilog/logicBlocks"))
}
