package efpga.top

import chisel3._
import circt.stage.ChiselStage
import chisel3.experimental.ExtModule
import chisel3.util.MuxLookup
import cmu.util.{ScanBundle, TristateIO}
import efpga.config
import efpga.config.{ConfScanIO}
import efpga.tiles.{Tile, TileFull, efpgaCtrlSignals}
import vtrutils.RRgraph
import efpga.tiles._
import chisel3.experimental.doNotDedup
import chisel3.util.log2Up

import scala.collection.immutable.SortedMap

case class ConfigScanBundle(scanWidth: Int = 16, sizeY: Int = 11) extends Bundle {
  val scanIn = Input(UInt(scanWidth.W))
  val tileSelect = Input(UInt(log2Up(sizeY).W))
  val scanEn = Input(Bool())
  val scanOut = Output(UInt(scanWidth.W))
}

class flatFabric(rrGrf: RRgraph, configType: String, name: String) extends Module {

  override def desiredName: String = name

  val (width, height) = (rrGrf.grid.map(g => g.x).max, rrGrf.grid.map(g => g.y).max)
  println(s" Generatin efpga fabric size: ${width+1} x ${height+1}")

  // FPGA demo example contains one column of IO tiles with 32 IOs each
  val numIOTiles = height-1

  /***** Define FabricIO *******/
  val io = IO(new Bundle() {
    val IO = TileIO(32*numIOTiles,32*numIOTiles)
    val ctrlSignals = new efpgaCtrlSignals()
    val confPorts = Vec(width, ConfigScanBundle(16, height))
  })

  val tileIO = Wire(Vec(height-1, TileIO(32,32)))
  io.IO.o  := chisel3.util.Cat(tileIO.map( io => io.o).reverse)
  tileIO.zipWithIndex.foreach{ case (tile, i) =>
    tile.i := io.IO.i((i+1)*32-1, i*32)
  }

  /***** 1. Generate Tiles *****/
  val tiles: Map[(Int,Int), Tile] = rrGrf.tiles.filter{ case (grid, rrTile) =>
    rrTile.tileNodesSet.nonEmpty}.transform {
    case (grid, rrTile) =>
      val (x, y, blkName) = (rrTile.props.x, rrTile.props.y, rrTile.props.name)
      Module(new TileFull(rrGrf, rrTile, configType)).suggestName(s"Tile_${x}_${y}_$blkName")

  }

  //tiles.values.toList.foreach{ m => doNotDedup(m)}

  println(" DONE GNERATING TILES...")

  /***** 2. Connect Tile nodes & control signals *****/
  tiles.foreach{ case (grid, tile) =>
    // Connect nodes (Connect all ioIns of tiles)
    println(s"    > Connecting nodes in tile $grid")
    tile.ioIns.foreach{ case (nId, tileInPin) =>
      // Get the node driver & connect ot pin
      tileInPin := tiles(rrGrf.tileLocOfNode(nId)).ioOuts(nId)
    }
    // connect ctrl signals & flags
    tile.ctrlSignals <> io.ctrlSignals
    tile.clock := clock
    tile.reset := reset
  }

  println(" DONE CONNECTING TILES...")


  /***** 3. Connect IO pads to tiles *****/
  println(" CONNECTING IOs...")
  // GPIO
  filterTilesByCol(width-1).filter{case(_,tile) => tile.rrTileInfo.props.isIOtile}.foreach{
    case(row, tile) =>
      println(s"Connectin IO ${tile.rrTileInfo.props.gridLoc} -> tileIO[${row-1}]")
      tile.ioPad.get <> tileIO(row-1)
  }


  /***** 4. Connect configuration signals *****/
  println(" CONNECTING CONFIGURATION ...")
  connectConfIO(configType)


  /***** 5. HEPLER FUNCTIONS *****/
  def filterTilesByRow(rowId: Int): SortedMap[Int, Tile] = {
    SortedMap.empty[Int, Tile] ++ tiles.filter{
      case((col,row),rrtile) =>
        row == rowId }.map{ case ((col,row),rrTile) => (col, rrTile) }
  }

  def filterTilesByCol(colId: Int): SortedMap[Int, Tile] = {
    SortedMap.empty[Int, Tile] ++ tiles.filter{
      case((col,row),rrtile) =>
        col == colId }.map{ case ((col,row),rrTile) => (row, rrTile) }
  }


  def connectConfIO(confType: String): Unit = {

    confType match {
      case "SCAN" => connectConfScanIO()
      case _ => sys.error(s"Unsupported scan type $confType")
    }

    def connectConfScanIO(): Unit = {
      val numChains = width //0-11 = 12 (13-1) last col is empty
      println(s"    - connecting $numChains scan chains")

      // Generate scan enable signals
//      val scanEns = (0 until numChains).map(i => io.confScanChainSel === i.U && io.confScanPort.en)
//      // Generate scanOuts & connect
//      val scanOuts = Wire(Vec(numChains, UInt(8.W)))
//      io.confScanPort.out := scanOuts(io.confScanChainSel)

      // Connect chains of column tiles
      (0 until numChains).foreach { col =>
        val tilesInCol: SortedMap[Int,Tile] = filterTilesByCol(col)
        val scanOutWires = Wire(Vec(math.pow(2, log2Up(tilesInCol.size)).toInt, UInt(16.W)))
        println(s"Scan conn Col: ${col} -> ${tilesInCol.size} tiles in column")
        // Initialize wires to zero and replace with tile outputs later
        scanOutWires.foreach(i => i := 0.U)

        tilesInCol.foreach{ case(row, tile) =>
          val confPorts = tile.ioConf
          tile.ioConf.confPort.in := io.confPorts(col).scanIn
          tile.ioConf.confPort.en := (io.confPorts(col).tileSelect === row.asUInt) && io.confPorts(col).scanEn
          scanOutWires(row) := tile.ioConf.confPort.out
          println(s"    ->  $row :  ${tile.rrTileInfo.props.x}, ${tile.rrTileInfo.props.y}, ${tile.rrTileInfo.props.name}")
        }

        io.confPorts(col).scanOut := scanOutWires(io.confPorts(col).tileSelect)
     }
    }
  }
}


object FabricGen extends App {

  val startTimeMillis: Long = System.currentTimeMillis()
  val stage = new ChiselStage
  //val xmlFile = "src/resources/rr_cust_mul.xml"
  //val xmlFile = "src/resources/rr_simple_large.xml"
  val xmlFile = args(0)
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()

  args.foreach(println)
  //val genMod = new flatFabric(rrGraph, "SCAN", "flatFabric")
  println(" ========= DONE GENERATING TOP MODULE ===========")
  printTime

  println(" ========= EMIT VERILOG OF TOP MODULE ===========")
  ChiselStage.emitSystemVerilogFile(new flatFabric(rrGraph, "SCAN", "flatFabric"),
    //Array("-td", "verilog/fabrics/", "-ll", "info", "--dump-fir"),
    Array("-td", "verilog/fabrics/", "-ll", "info"),
    Array("--strip-debug-info", "-g", "--disable-all-randomization", "-mlir-pass-statistics", "-mlir-timing"))

//  ChiselStage.emitFIRRTLDialect(new flatFabric(rrGraph, "SCAN", "flatFabric"),
//    Array("--dump-fir"))
  printTime

  def printTime: Unit = {
    val endTimeMillis = System.currentTimeMillis()
    val durationSeconds = (endTimeMillis - startTimeMillis) / 1000.0
    println(s"Wall clock exec time: $durationSeconds seconds")
  }
}
