package efpga.config

import chisel3._
import chisel3.util.RegEnable
import vtrutils.{RRtile, RRgraph}

class ScanBundle(width: Int) extends Bundle {
  val in: UInt = Input(UInt(width.W))
  val en: Bool = Input(Bool())
  val out: UInt = Output(UInt(width.W))
}

class ConfScanIO(confLen: Int, scanWidth: Int = 16) extends ConfIO {
  override val confOut: UInt = Output(UInt(confLen.W))
  override val confPort = new ScanBundle(scanWidth)
}

class ScanConf(rrTile: RRtile, scanWidth: Int = 16) extends ConfigBlock {

  val (x, y, blkName) = (rrTile.props.x, rrTile.props.y, rrTile.props.name)
  override val desiredName = s"ScanConf_Tile_${x}_${y}_$blkName"

  // Make conf bits multiple of 8
  val numConfBits: Int = (math.ceil(rrTile.props.confInfo.totalConfBits*1.0/scanWidth)*scanWidth).toInt
  val scanDepth: Int = numConfBits/scanWidth
  override val ioBundle: ConfIO = IO(new ConfScanIO(numConfBits, scanWidth))
  //val io = ioBundle.asTypeOf(new ConfScanIO(numConfBits))
  val io = Wire(new ConfScanIO(numConfBits, scanWidth))

  println(s"    CONF: ${rrTile.props.confInfo.totalConfBits} -(round-to $scanWidth)-> ${numConfBits}")
  // Conf FFs
  val confReg = Reg(Vec(numConfBits, Bool()))

  // Connect in scan chain
  val scanWords: Seq[IndexedSeq[Bool]] = confReg.grouped(scanWidth).toSeq

  // In to MSB word
  when(io.confPort.en) {
    (0 until scanWidth).foreach { bit => scanWords(scanDepth - 1)(bit) := io.confPort.in(bit) }
    (0 until scanDepth - 1).foreach { rowAddr =>
      (0 until scanWidth).foreach { bitIdx =>
        scanWords(rowAddr)(bitIdx) := scanWords(rowAddr + 1)(bitIdx)
      }
    }
  }
  // LSB word to out
  io.confPort.out := VecInit(scanWords(0).toList).asUInt
  // Drive output conf
  io.confOut := confReg.asUInt

  ioBundle <> io
}

object ScanConfDriver extends App {

  val stage = circt.stage.ChiselStage
  val xmlFile = "/home/kmgroup/projects/vexriscv/hardware/efpga/efpga_xplore_s8/example_designs/gpio_test/vpr_pnr/rr.xml"
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()
  println(s" LB Name: ${rrGraph.tiles(7,1).props.confInfo.routingConfBits} , ${rrGraph.tiles(7,1).props.confInfo.logicBlockConfBits}")
  //stage.emitSystemVerilog(new EccMemTest(8), Array("-td", "verilog/eccmemtest", "--repl-seq-mem", s"-c:EccMemTest:-o:EccMemTest.mems.conf"))
  stage.emitSystemVerilogFile(new ScanConf(rrGraph.tiles(7,1)), Array("-td", "verilog/tiles"))
}
