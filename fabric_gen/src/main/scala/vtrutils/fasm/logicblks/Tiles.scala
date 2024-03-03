package vtrutils.fasm.logicblks

import vtrutils.{RRgraph, RRtile}
import vtrutils.fasm._

import scala.collection.mutable
import scala.collection.mutable.{Seq, _}


case class TileConfig(rrGrf: RRgraph, rrTile: RRtile) extends ConfigBlock {
  //fragments MSB - LSB --> CHANS (n,n-1,...0), IPINs (n,n-1,...0), LB)

  val tileInfo = s"@  ${rrTile.props.gridLoc} ${rrTile.props.name}"
  // Routuing
  val routingConfig = RoutingConfig()


  // Logic block
  val logicBlkConfig = rrTile.props.name match {
    //case t if t.contains("io") => Some(Module(new IOBlock))
    case "clbalutile" => Some(ClbAluConfig())
    case "iotile" => Some(IOBlockConfig())
    case "custmultile" => Some(CustMulBlockConfig())
    case "EMPTY" => None
    case _ =>
      assert(false, s"Unsupported tile type ${rrTile.props.name}")
      None
  }
  addConfig(routingConfig)
  if (!logicBlkConfig.isEmpty) {
    addConfigBlock(logicBlkConfig.get)
  }


  assert (this.confLength == rrTile.props.confInfo.totalConfBits ,
    s" ${rrTile.props.gridLoc} ${rrTile.props.name} config should have " +
      s"${rrTile.props.confInfo.totalConfBits} bits. =/= ${this.confLength}")


  println(s"   CONFLEN: ${this.confLength} vs ${rrTile.props.confInfo.totalConfBits} @ $tileInfo")
  // Parse routing and pass on Logic block
  override def parseFASM(fasm: String): Unit = {
    println(s"   Parsing fasm -> $fasm  ${tileInfo}")
    fasm match {
      case x if x.contains("sink_") => routingConfig.parseFASM(fasm)
      case x if x.contains("LB") => logicBlkConfig.get.parseFASM(fasm)
      case _ => assert(false, s"Unexpected FASM for Tile $fasm")
    }
  }

  case class RoutingConfig(val prefix: String = "") extends Config {

    // Configs are added from MSB to LSB (CHAN, SBox LogicBlk)
    val fragNodes: mutable.ArrayBuffer[Int] = mutable.ArrayBuffer.empty[Int]
    // CHAN
    val sbNodes = rrTile.confNodes.filter(n => n.ntype.contains("CHAN"))
    sbNodes.reverse.foreach { node =>
      val len = rrTile.props.confInfo.nodeConfBits(node.id)
      // select opin by default (MSB 1)
      addFragment(ConfFragment(s"${node.id}", Seq.fill(len-1)('0') :+ '1'))
      fragNodes += node.id
    }

    // IPIN
    val cbNodes = rrTile.confNodes.filter(n => n.ntype == "IPIN").sortBy(_.id)
    cbNodes.reverse.foreach { node =>
      val len = rrTile.props.confInfo.nodeConfBits(node.id)
      // Connect to 0 defualt (all 1 select)
      addFragment(ConfFragment(s"${node.id}", Seq.fill(len)('1')))
      fragNodes += node.id
    }

    val nodesInTile = sbNodes.map(_.id) ++ cbNodes.map(_.id)
    //println(s" SBOX NODES: ${sbNodes.length} CB : ${cbNodes.length}")

    // Add from MSB t0 LSB
    assert(confLength == rrTile.props.confInfo.routingConfBits,
      s"Routing config $confLength, ${rrTile.props.confInfo.routingConfBits} $tileInfo")

    def setConf(sink: Int, src: Int): Unit = {
      val sinkNode = rrGrf.nodes(sink)
      val srcNode = rrGrf.nodes(src)
      val fanIns =  rrGrf.nodeFanIns(sinkNode.id)
      val numConfBits = rrTile.props.confInfo.nodeConfBits(sinkNode.id)
      val confFragIndex = fragNodes.indexWhere(_ == sinkNode.id)

      assert (fanIns.indexWhere(_ == srcNode.id) >= 0,
        s"$src not fanIn ${fanIns.indexWhere(_ == srcNode.id)} of $sink @ $tileInfo| $fanIns")

      def zeroPad(len: Int, inStr: Array[Char]) = Array.fill(len - inStr.length)('0') ++ inStr

      val config: Seq[Char] = if (sinkNode.ntype == "IPIN") {
        zeroPad(numConfBits, fanIns.indexWhere(_ == srcNode.id).toBinaryString.toCharArray)
      } else {
        // Opin MSB=1 & CHAN MSB=-0
        val msb = if (srcNode.ntype == "OPIN") Seq('1') else Seq('0')
        val sbFanins = fanIns.map(rrGrf.muxNodes(_)).sortBy(_.id)
        val muxSel = if (srcNode.ntype == "OPIN") {
          msb ++ zeroPad(numConfBits-1, sbFanins.filter(_.ntype=="OPIN").
            indexWhere(_.id == srcNode.id).toBinaryString.toCharArray)
        }  else {
          msb ++ zeroPad(numConfBits-1,sbFanins.filter(_.ntype.contains("CHAN")).
            indexWhere(_.id == srcNode.id).toBinaryString.toCharArray)
        }

        println(s"       DEBUG: SB ${sinkNode} <- $srcNode : Fan_ins ${sbFanins.map(_.id)} => $muxSel")
        println(s"       DEBUG: SB ${sinkNode} <- $srcNode : Frag_idx = $confFragIndex ")
        muxSel
      }

      println(s"    mux config @ $confFragIndex = ${config.toList} | ${numConfBits}")

      assert(fragments(confFragIndex).length == config.length, s"($sinkNode) config len mismatch @ $tileInfo, " +
        s"${fragments(confFragIndex).length} != ${config.length}")
      println(s"    Setting fragment($confFragIndex) from ${fragments(confFragIndex).bits.toList} to ${config.toList}")
      fragments(confFragIndex).bits = config.reverse


    }

    // DEBUG
    def debugFrags(): Unit = {
      fragments.zipWithIndex.foreach { case (farg, i) => println(s" Frag_idx = $i | Config: ${farg.bitStream}") }
    }

    override def parseFASM(fasm: String): Unit = {
      println(s"   Parsing Routing fasm -> $fasm  ${tileInfo}")
      fasm match {
        case x if x.contains("sink_") =>
          val (sink, src) = (fasm.split("_")(1).toInt, fasm.split("_")(3).toInt)
          if (nodesInTile.contains(sink)) setConf(sink, src) else assert(false, s"$sink not in Tile  ${rrTile.props.gridLoc}")
        case _ => assert(false, s"Unexpected FASM for Routing $fasm @ ${rrTile.props.gridLoc} ${rrTile.props.name}")
      }
    }
  }

}


object TileConfigDriver extends App {

  val xmlFile = "src/resources/rr.xml"
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()

  println(s" CONF LEN: ${rrGraph.tiles(7,1).props.confInfo.totalConfBits}")
//  FpgaConfig(rrGraph)

  val testFASM: List[String] = List("clbmemtileio_10_4.CLBRAM")
//    "sink_5490_src_28608",
//    "CLBBLE5.LUT.INIT[15:0]=16'b0000000000000111",
//    "CLBBLE7.mux_top_1",
//    "CLBBLE7.LUT.INIT[15:0]=16'b0000000000000111",
//    "CLBBLE7.mux_right_0"
//  )
//  //stage.emitSystemVerilog(new EccMemTest(8), Array("-td", "verilog/eccmemtest", "--repl-seq-mem", s"-c:EccMemTest:-o:EccMemTest.mems.conf"))
  val tconf = TileConfig(rrGrf = rrGraph, rrTile = rrGraph.tiles(10,4))
  testFASM.foreach { fasm => tconf.parseFASM(fasm) }
  tconf.routingConfig.debugFrags()
//  println("Bitstream" + tconf.bitStream)

//  val testFasm = "clbmemtileio_10_2.CLBBLE7.LUT.INIT[15:0]=16'b0101010101010101"
//  println( "^([a-z]+)_([0-9]+)_([0-9]+)".r.findAllIn(testFasm).subgroups.toArray.toList)

  //println("CLBBLE7.LUT.INIT[15:0]=16'b0000000000000111".split("CLBBLE[0-9].")(1))
  //  println((6).toBinaryString)
//  (List('0') ++ (6).toBinaryString.toCharArray).foreach( println(_) )

  //  val tileConfigs = rrGraph.tiles.filter{ case (grid, rrTile) =>
//    rrTile.tileNodesSet.nonEmpty}.transform {
//    case (grid, rrTile) => (rrTile, TileConfig(rrGraph, rrTile))
//  }
//
//  tileConfigs.foreach { case (grid, tile) =>
//    println(s"$grid , ${tile._1.props.name}, ${tile._2.confLength }, ${tile._2.bitStream}")
//    //println("Bitstream" + tconf.bitStream)
//  }

}
