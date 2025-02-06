package efpga.tiles

import chisel3._
// import cmu.util.TristateIO
import efpga.config._
import efpga.logicblks._
import efpga.utils._
import vtrutils.Main.rrGraph
import vtrutils._
import chisel3.experimental.doNotDedup

import scala.reflect.internal.util.TriState

class TileFull(rrGrf: RRgraph, rrTile: RRtile, configType: String = "SCAN") extends Tile {

  override val rrTileInfo: RRtile = rrTile
  val (x, y, blkName) = (rrTile.props.x, rrTile.props.y, rrTile.props.name)
  override val desiredName = s"Tile_${x}_${y}_$blkName"
  println(s" >> Generating Tile: Tile_${x}_${y}_$blkName")

  // 1. Logic Block
  override val logicBlock: Option[LogicBlockImpl] = rrTile.props.name match {
    case "iotile" => Some(Module(new IOBlock(32)))
    case "clbalutile" => Some(Module(new CLBlut4N10Alu))
    case "custmultile" => Some(Module(new CustMulBlock))
    case _ => None
  }

  if (logicBlock.isDefined) {
    assert(logicBlock.get.info.numConfBits == rrTile.props.confInfo.logicBlockConfBits,
      s"LogicBlockDB is not in sync with LogicBlock definition for S{logicBlock.get.info}")
  }

  // 2. Config Block
  override val configBlock: Option[ConfigBlock] = configType match {
    case "SCAN" => Some(Module(new ScanConf(rrTile)))
    case _ => sys.error(s"INVALID CONFIG TYPE ${rrTile.props.confType}")
  }

  // 3. Ins
  override val ioIns: Map[Int, Bool] = rrTile.inputNodes.map { n =>
    val pinName: String = s"IN_${n.ntype}_N${n.id}_${n.loc.ptc}"
    (n.id, IO(Input(Bool())).suggestName(s"${pinName}"))
  }.toMap

  // 4. Outs
  override val ioOuts: Map[Int, Bool] = rrTile.outputNodes.map { n =>
    val pinName: String = s"OUT_${n.ntype}_N${n.id}_${n.loc.ptc}"
    (n.id, IO(Output(Bool())).suggestName(s"${pinName}"))
  }.toMap

  // 5. Config: Check conf type and insert accordingly
  override val ioConf: ConfIO = configType match {
    case "SCAN" => IO(new ConfScanIO(rrTile.props.confInfo.totalConfBits))
    case _ => sys.error(s"INVALID CONFIG TYPE ${rrTile.props.confType}")
  }

  // 6. PAD IO
  override val ioPad: Option[TileIO] = if (logicBlock.nonEmpty && (logicBlock.get.info.numIOIns + logicBlock.get.info.numIOOuts) > 0) {
    Some(IO(TileIO(logicBlock.get.info.numIOIns, logicBlock.get.info.numIOOuts)))
  } else {
    None
  }

  // 7. control signals
  override val ctrlSignals: efpgaCtrlSignals = IO(new efpgaCtrlSignals)

  // ==> Dummy Connections

  // Config connections
  if (configBlock.nonEmpty) {
    ioConf <> configBlock.get.ioBundle
    configBlock.get.clock := ctrlSignals.confClock
  }

  // RRGraph connections ( 4 steps )

  // Start assigning confing for CB and SB from here (order SB, CB, LB)
  var configId = rrTile.props.confInfo.logicBlockConfBits

  //FIXME: Speial case for DSP tile without any IPIN fanin for carryin in the top tile
  if (blkName=="clbalutile" || blkName=="clbmultile") {
    logicBlock.get.IPINs.values.toList.foreach(ipin => ipin := false.B)
  }

  /****** Connect CBs (CHANs --> CB --> IPINs) *****/
  val cbNodes = rrTile.confNodes.filter(n => n.ntype == "IPIN").sortBy(_.id)
  if (cbNodes.length>0) assert(logicBlock.nonEmpty, s"ERR: $cbNodes Found IPINs wihtout LogicBlk")

    //val cbMuxes: Option[Seq[MuxNInputSCAOptCBLatch]] = if (logicBlock.nonEmpty)  {
    val cbMuxes: Option[Seq[MuxNInputSCAOptCB]] = if (logicBlock.nonEmpty)  {
      Some(cbNodes.map { node =>

        val fanIns: Seq[Int] = rrGrf.nodeFanIns(node.id)
        assert(fanIns.length > 0, s"CB $node with 0 fanin")
        assert(fanIns.length <= 31, s"CB $node with >= 31 fanin")
        //println(s"     Connecting CB node $node")

        //val muxInst = Module(new MuxNInputSCAOptCBLatch(fanIns)).suggestName(s"CBMux_IPIN${node.loc.ptc}_N${node.id}")
        val muxInst = Module(new MuxNInputSCAOptCB(fanIns)).suggestName(s"CBMux_IPIN${node.loc.ptc}_N${node.id}")

        // Connect output IPIN
        //println(s"logicBlock.get.IPINs(${node.loc.ptc}) := muxInst.io.out")
        logicBlock.get.IPINs(node.loc.ptc) := muxInst.io.out

        // Connect config
        assert(muxInst.muxConfigSize == rrTile.props.confInfo.nodeConfBits(node.id), s"CB ${node} config size mismatch ")
        muxInst.io.config := configBlock.get.ioBundle.confOut(configId + muxInst.muxConfigSize - 1, configId)
        configId = configId + muxInst.muxConfigSize
        // control signals
        //muxInst.io.loopBreak := ctrlSignals.loopBreak
        muxInst.io.cnstClk := clock
        muxInst.io.pathBreak := ctrlSignals.pathBreak
        muxInst.io.ioGndBle := ctrlSignals.gndBlkOuts

        muxInst
    })
  } else None


  // SB input connections (OPINs/CHANs inside/outside tile)
  /****** Connect SBs (CHANs/OPINs --> SB --> TileOuts) *****/
  // CB input connections (driven by CHAN / OPINs)
  val sbNodes = rrTile.confNodes.filter(n => n.ntype.contains("CHAN"))
  if(sbNodes.length <0) println( "Tile has NO Channels but is trying to get generated")
  //val sbMuxes: Option[Seq[MuxNInputSCAOptSBLatch]] = if(sbNodes.length>0) {
  val sbMuxes: Option[Seq[MuxNInputSCAOptSB]] = if(sbNodes.length>0) {
    Some(sbNodes.map { node =>
      val sbfanIns: Seq[Int] = rrGrf.nodeFanIns.getOrElse(node.id, Seq[Int]())
      val fanIns: Seq[Node] = if(sbfanIns.length>0) rrGrf.nodeFanIns(node.id).map(rrGrf.muxNodes(_)).sortBy(_.id) else Seq[Node]()
      val opins = fanIns.filter(_.ntype == "OPIN")
      val chans = fanIns.filter(_.ntype.contains("CHAN"))
      //assert(fanIns.length > 0 && chans.length > 0, s"ERR:SB $node opins=${opins.length} chans=${chans.length}")
      //assert(fanIns.length > 0, s"ERR:SB $node opins=${opins.length} chans=${chans.length}")
      assert(fanIns.length <= 31, s"SB $node with >= 31 fanin")
      //if (opins.length>0) assert(logicBlock.nonEmpty, s"ERR:SB $node Found OPIN wihtout LogicBlk")
      //println(s"     Connecting SB node $node")

      //val muxInst = Module(new MuxNInputSCAOptSBLatch(fanIns))
      val muxInst = Module(new MuxNInputSCAOptSB(fanIns))
      val segmentId = node.segmentId.get.segment_id.toInt
      val segmentName = rrGrf.getSegmentName(node.id)
      muxInst.suggestName(s"SBMux_${segmentName}_C${node.loc.ptc}_N${node.id}_O_${opins.length}_C_${chans.length}")

      // Connect output to Tile output
      if (ioOuts.contains(node.id))
        ioOuts(node.id) := muxInst.io.out

      // Connect config
      assert(muxInst.configSize == rrTile.props.confInfo.nodeConfBits(node.id),
        s"SB ${node} config size mismatch [ ${muxInst.configSize} vs ${rrTile.props.confInfo.nodeConfBits(node.id)}] @ ${rrTile.props.gridLoc}")
      muxInst.io.config := configBlock.get.ioBundle.confOut(configId + muxInst.configSize - 1, configId)
      configId = configId + muxInst.configSize

      // control isgnals
      //muxInst.io.loopBreak := ctrlSignals.loopBreak
      muxInst.io.cnstClk := clock
      muxInst.io.pathBreak := ctrlSignals.pathBreak
      muxInst.io.ioGndBle := ctrlSignals.gndBlkOuts

      muxInst
    })
  } else None

  // CB fan in connections (CHANS - outside or inside tile)
  cbNodes.zipWithIndex.foreach { case(cbnode, id) =>
    val fanIns: Seq[Int] = rrGrf.nodeFanIns(cbnode.id)
    //println(s"     Connecting CB node $cbnode FanIns")
    // make sure all fan-ins are channels
    //assert(fanIns.map(rrGraph.muxNodes(_).ntype.contains("CHAN")).reduce(_ & _), s"CB $cbnode has non CHAN fanin")
    cbMuxes.get(id).io.in := VecInit(fanIns.map(fanInNode =>
      if (rrTile.tileNodesSet.contains(fanInNode))
        sbMuxes.get(sbNodes.indexWhere(_.id==fanInNode)).io.out
      else
        ioIns(fanInNode)
    )).asUInt
  }

  // SB Connect input fanIn nodes (OPINS / CHANS (inside or outside tile))
  sbNodes.zipWithIndex.foreach { case (sbnode, id) =>

    val sbfanIns: Seq[Int] = rrGrf.nodeFanIns.getOrElse(sbnode.id, Seq[Int]())
    val fanIns: Seq[Node] = if (sbfanIns.length > 0) rrGrf.nodeFanIns(sbnode.id).map(rrGrf.muxNodes(_)).sortBy(_.id) else Seq[Node]()
    //val fanIns: Seq[Node] = rrGrf.nodeFanIns(sbnode.id).map(rrGrf.muxNodes(_)).sortBy(_.id)
    //println(s"     Connecting SB node $sbnode FanIns ${fanIns.map(_.id)}")
    //fanIns.foreach(n => println(s"         $n"))
    if (fanIns.length > 0) {
      sbMuxes.get(id).io.in := VecInit(fanIns.map(n =>
        n match {
          case node if node.ntype == "OPIN" && rrTile.tileNodesSet.contains(node.id) =>
            //println(s"    OPIN FanIN $n | OPIN(${n.loc.ptc})")
            logicBlock.get.OPINs(n.loc.ptc)
          case node if node.ntype == "OPIN" =>
            //println(s"    OPIN FanIN $n | ioIns(${n.id})")
            ioIns(n.id)
          case node if node.ntype.contains("CHAN") && rrTile.tileNodesSet.contains(node.id) =>
            //println(s"     FanIN $n | sbNOdes(${sbNodes.indexWhere(_.id == n.id)})")
            sbMuxes.get(sbNodes.indexWhere(_.id == n.id)).io.out
          case node if node.ntype.contains("CHAN") =>
            //println(s"     FanIN $n | sb IoIns(${sbNodes.indexWhere(_.id == n.id)})")
            ioIns(n.id)
          case _ => sys.error(s" Fanin Node $n of SB $sbnode is not in tile ot tile inputs")
        })).asUInt
    }
    else {
      sbMuxes.get(id).io.in := 0.U
    }
  }


  // LB connections (OPINS --> IoOuts)
  if (logicBlock.nonEmpty) {
    logicBlock.get.gndLBouts := ctrlSignals.gndBlkOuts
    //logicBlock.get.loopBreak := ctrlSignals.loopBreak
    logicBlock.get.pathBreak := ctrlSignals.pathBreak
    logicBlock.get.configBits := configBlock.get.ioBundle.confOut
    logicBlock.get.clock := clock
    logicBlock.get.reset := reset
    // OPIS -> IoOuts of tile
    ioOuts.filterKeys(rrGrf.muxNodes(_).ntype=="OPIN").foreach {case (nId, opin) =>
      opin := logicBlock.get.OPINs(rrGrf.muxNodes(nId).loc.ptc)
    }
  }

  // IO PAD connections
  if (LogicBlockDB.blocks(rrTile.props.name).hasIO) {
    logicBlock.get.ioPad.get.i := ioPad.get.i
    ioPad.get.o := logicBlock.get.ioPad.get.o
  }

}


object TileFullSingleDriver extends App {

  val startTimeMillis: Long = System.currentTimeMillis()
  val stage = circt.stage.ChiselStage
  val xmlFile = "src/resources/rr.xml"
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()
  println(s" LB Name: ${rrGraph.tiles(0,5).props.name}")

  val rrTilesToGen: Seq[RRtile] = rrGraph.tiles.filter { case (grid, rrTile) =>
    rrTile.tileNodesSet.nonEmpty
  }.transform {
    case (grid, rrTile) => rrTile
  }.values.toList
  rrTilesToGen.foreach { tile =>
    println(s" ${tile.props.gridLoc} -> ${tile.props.name}")
  }

  //stage.emitSystemVerilog(new TileFull(rrGraph, rrGraph.tiles(3,3)), Array("-td", "verilog/tiles"))
  //stage.emitSystemVerilog(new TileFull(rrGraph, rrGraph.tiles(11,3)), Array("-td", "verilog/tiles"))
  //stage.emitSystemVerilog(new TileFull(rrGraph, rrGraph.tiles(11,9)), Array("--no-dce","-td", "verilog/tiles"))
  stage.emitSystemVerilogFile(new TileFull(rrGraph, rrGraph.tiles(7,1)), Array("-td", "verilog/tiles"))

  //  val nId = 8793
  //  println(s"NODE: ${rrGraph.muxNodes(nId)}")
  //  println(rrGraph.nodeFanIns(nId), rrGraph.nodeFanOuts(nId))
  //  println(rrGraph.tileLocOfNode(nId))
  //rrGraph.tiles(2,0).inputNodes.foreach(println)
  //
//
//  rrTilesToGen.par.map { rrTile =>
//    stage.emitVerilog(new TileFull(rrGraph, rrTile), Array("-td", "fabrics/base/tiles/", "-e", "verilog"))
//    printTime
//  }
//  println(s" Generated ${rrTilesToGen.length} tiles")

  //  println(s"${rrGraph.tiles(7,2).props.confInfo.routingConfBits}")
  //  println(s"${rrGraph.tiles(7,2).props.confInfo.logicBlockConfBits}")
  //  println(s"${rrGraph.tiles(7,2).props.confInfo.totalConfBits}")
  //  rrGraph.tiles(10,4).tileNodesSet.toSeq.sorted.foreach(println)
  //  stage.emitSystemVerilog(new TileFull(rrGraph, rrGraph.tiles(10,4)), Array("-td", "verilog/base/tiles/"))
  //  printTime

  def printTime: Unit = {
    val endTimeMillis = System.currentTimeMillis()
    val durationSeconds = (endTimeMillis - startTimeMillis) / 1000.0
    println(s"Wall clock exec time: $durationSeconds seconds")
  }
}

object TileFullDriver extends App {

  val startTimeMillis: Long = System.currentTimeMillis()
  val stage = circt.stage.ChiselStage
  val xmlFile = "src/resources/rr.xml"
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()
  //println(s" LB Name: ${rrGraph.tiles(0,5).props.name}")

  //  stage.emitSystemVerilog(new TilePart(rrGraph, rrGraph.tiles(7,1)), Array("-td", "verilog/tiles"))
  //  printTime

//  val nId = 8793
//  println(s"NODE: ${rrGraph.muxNodes(nId)}")
//  println(rrGraph.nodeFanIns(nId), rrGraph.nodeFanOuts(nId))
//  println(rrGraph.tileLocOfNode(nId))
  //rrGraph.tiles(2,0).inputNodes.foreach(println)
  //
//  val rrTilesToGen: Seq[RRtile] = rrGraph.tiles.filter { case (grid, rrTile) =>
//    rrTile.tileNodesSet.nonEmpty
//  }.transform {
//    case (grid, rrTile) => rrTile
//  }.values.toList
//
//  rrTilesToGen.par.map { rrTile =>
//  stage.emitVerilog(new TileFull(rrGraph, rrTile), Array("-td", "fabrics/base/tiles/", "-e", "verilog"))
//  printTime
//}
//  println(s" Generated ${rrTilesToGen.length} tiles")

//  println(s"${rrGraph.tiles(7,2).props.confInfo.routingConfBits}")
//  println(s"${rrGraph.tiles(7,2).props.confInfo.logicBlockConfBits}")
//  println(s"${rrGraph.tiles(7,2).props.confInfo.totalConfBits}")
//  rrGraph.tiles(10,4).tileNodesSet.toSeq.sorted.foreach(println)
  stage.emitSystemVerilogFile(new TileFull(rrGraph, rrGraph.tiles(11,0)), Array("--no-dce","-td", "verilog/base/tiles"))
  //stage.emitSystemVerilog(new TileFull(rrGraph, rrGraph.tiles(11,0)), Array("-td", "verilog/base/tiles/"))
  printTime

  def printTime: Unit = {
    val endTimeMillis = System.currentTimeMillis()
    val durationSeconds = (endTimeMillis - startTimeMillis) / 1000.0
    println(s"Wall clock exec time: $durationSeconds seconds")
  }
}

