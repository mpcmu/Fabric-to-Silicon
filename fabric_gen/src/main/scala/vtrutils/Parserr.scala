package vtrutils

import cats.syntax.apply._
import io.dylemma.spac.xml._
import io.dylemma.spac._
import logger.LazyLogging

import java.io.File
import javax.xml.stream._

class ParseRRXML(xmlFile: String) extends LazyLogging {

  implicit val EdgeParser: XmlParser[Edge] = (
    XmlParser.attr("src_node").map(_.toInt),
    XmlParser.attr("sink_node").map(_.toInt),
    XmlParser.attr("switch_id").map(_.toInt)
    ).mapN((i,j,k) => Edge(i, j, k))

  implicit val SegmentParser: XmlParser[Segment] = (
    XmlParser.attr("id").map(_.toInt),
    XmlParser.attr("name"),
  ).mapN((i, j) => Segment(i, j))

  implicit val SegmentIdParser: XmlParser[SegmentID] = (
    XmlParser.attr("segment_id"),
  ).map((i) => SegmentID(i))

  implicit val locParser: XmlParser[Loc] = (
    XmlParser.attr("xlow"),
    XmlParser.attr("ylow"),
    XmlParser.attr("xhigh"),
    XmlParser.attr("yhigh"),
    XmlParser.attrOpt("side"),
    XmlParser.attr("ptc")
    ).mapN((xl, yl, xh, yh, side, ptc) => Loc(xl.toShort, yl.toShort, xh.toShort, yh.toShort,
    side.getOrElse("NONE"), ptc.toShort))

  implicit val nodeParser: XmlParser[Node] = (
    XmlParser.attr("id").map(_.toInt),
    XmlParser.attr("type"),
    XmlParser.attrOpt("direction"),
    Splitter.xml(* \ "loc").as[Loc].parseFirst,
    Splitter.xml(* \ "segment").as[SegmentID].parseFirstOpt
    ).mapN(Node.apply)

  implicit val gridParser: XmlParser[Grid] = (
    XmlParser.attr("x").map(_.toInt),
    XmlParser.attr("y").map(_.toInt),
    XmlParser.attr("block_type_id").map(_.toInt)
    ).mapN(Grid.apply)

  implicit val blkParser: XmlParser[BlkTypes] = (
    XmlParser.attr("id").map(_.toInt),
    XmlParser.attr("name"),
    XmlParser.attr("width").map(_.toInt),
    XmlParser.attr("height").map(_.toInt)
    ).mapN(BlkTypes.apply)

  implicit val rrxmlParser: XmlParser[RRgraph] = (
    Splitter.xml(* \ "grid" \ "grid_loc").as[Grid].parseToList,
    Splitter.xml(* \ "block_types" \ "block_type").as[BlkTypes].parseToList,
    Splitter.xml(* \ "rr_nodes" \ "node").as[Node].parseToList,
    Splitter.xml(* \ "rr_edges" \ "edge").as[Edge].parseToList,
    Splitter.xml(* \ "segments" \ "segment").as[Segment].parseToList
  ).mapN(RRgraph.apply)


  val xmlSource = JavaxSource.fromFile(new File(xmlFile))
  def getRRGraph(): RRgraph = {
    rrxmlParser.parse(xmlSource)
  }
}

object Main extends App {
  val xmlFile = "src/resources/rr_simple.xml"
  //val xmlFile = "/afs/ece.cmu.edu/usr/pmohan/projects/chisel/vtr_plugins/vtrplugins/src/resources/rr_60x60.xml"
  val startTimeMillis = System.currentTimeMillis()

  val rrParser = new ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()
//  val nId = 273
//  println(s"LENNODES: ${rrGraph.muxNodes.size}")
//  println(s"NODE: ${rrGraph.muxNodes(nId)}")
//  println(rrGraph.tileLocOfNode(nId))
    rrGraph.segments.foreach{ i =>
    println(s"SEGMENT ${i.name} --> ${i.id}")

  }
  //println(s" SEG FOUND ${rrGraph.segments.find( segment => segment.id == 1).get.name}")
  println(s"${rrGraph.getSegmentName(2283)}")
  //println(rrGraph.nodeFanIns(nId), rrGraph.nodeFanOuts(nId))
  //println(s" NODE IN 7,3 : ${rrGraph.tiles(7,4).tileNodesSet.contains(nId)}")
  //println(s" NODE IN 7,1 : ${rrGraph.tiles(7,1).tileNodesSet.contains(nId)}")
  //testNodesInTile
  val tId = (2,2)
  //println(s" TILE IS VALID: ${rrGraph.tiles(tId).tileNodesSet.nonEmpty}")
  //println(s"OPINS: ${rrGraph.tiles(tId).outputNodes.count(_.ntype == "OPIN")}")
  //println(s"CHANs: ${rrGraph.tiles(tId).outputNodes.filter(_.ntype!="OPIN").length}")
  //rrGraph.tiles((0,0)).outputNodes.filter(_.ntype=="OPIN").sortBy(_.id)foreach(println)
  //rrGraph.tiles((0,0)).outputNodes.filter(_.ntype!="OPIN").sortBy(_.id)foreach(println)
  //rrGraph.tiles(tId).printRRtileInfo()

  /* your code goes here */

  val endTimeMillis = System.currentTimeMillis()
  val durationSeconds = (endTimeMillis - startTimeMillis) / 1000.0
  println(s"Wall clock exec time: $durationSeconds seconds")

  def testNodesInTile: Unit = {
    val nodes = rrGraph.nodesInTile((12,2))
    nodes.sortBy(_.id).foreach(n => println(s"${n.ntype} ${n.dir} - ${n.id} @ ${n.loc}"))
  }
}