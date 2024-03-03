package vtrutils


import scala.collection.immutable.SortedMap

// Define RRXML elements (nodes, edges, logic blocks)
case class Edge(src_node: Int, sink_node: Int, switch_id: Int)
case class Loc(xlow: Short, ylow: Short, xhigh: Short, yhigh: Short, side: String, ptc: Short)
case class Segment(id: Int, name:String)
case class SegmentID(segment_id: String)
case class Node(id: Int, ntype: String, dir: Option[String], loc: Loc, segmentId: Option[SegmentID])
case class Grid(x: Int, y: Int, block_type_id: Int)
case class BlkTypes(id: Int, name: String, width: Int, height: Int)
case class RRgraph(grid: List[Grid], blkTypes: List[BlkTypes], nodes: List[Node], edges: List[Edge], segments: List[Segment]) extends RRutils {

  // Mux Nodes (IPIN, OPIN, & CHANs) with fan-ins and fan-outs
  println("Generating Mux Nodes sub graph for Verilog generation")
  val muxNodes: Map[Int, Node] = nodes.filter(n => n.ntype!="SOURCE" && n.ntype!="SINK").map(n => (n.id, n)).toMap
  //TODO: OPT - Can you free muxEdges after using it for computation?
  val muxEdges: Seq[Edge] = edges.filter(e => muxNodes.contains(e.src_node) && muxNodes.contains(e.sink_node))

  val nodeFanIns: Map[Int, Seq[Int]] = muxEdges.groupBy(e => e.sink_node).transform((k,v) => v.map(_.src_node))
  val nodeFanOuts: Map[Int, Seq[Int]] = muxEdges.groupBy(e => e.src_node).transform((k,v) => v.map(_.sink_node))

  // Extract tile details for Verilog generation
  println("Generating Tile information for Verilog generation")
  lazy val tiles: Map[(Int,Int), RRtile] = grid.zipWithIndex.map{
    case (g, cnt) =>
      if (cnt%100==0) println(s"Processing tiles: ${cnt} of ${grid.length} -- ${cnt*100/grid.length} %")
      println(s"Tile Loc: ${g.x}, ${g.y}, ${g.block_type_id}")
      ((g.x, g.y), new RRtile(this, g))
  }.toMap

}

// Helper functions can be added to
// 1) RRgraph case class
// 2) companion object
// 3) Traits (eg. RRutils trait)

object RRgraph {
}

trait RRutils {
  //Restrict RRUtils trait to RRgraph type classes & access values in that class
  this: RRgraph =>

  // tile location of a Node
  def tileLocOfNode(node: Node): (Int, Int) = {
    node match {
      case n@Node(_,"IPIN",_,_,_) => (n.loc.xlow, n.loc.ylow)
      case n@Node(_,"OPIN",_,_,_) => (n.loc.xlow, n.loc.ylow)
      case n@Node(_,"CHANX",Some("INC_DIR"),_,_) => (n.loc.xlow-1, n.loc.ylow)
      case n@Node(_,"CHANX",Some("DEC_DIR"),_,_) => (n.loc.xhigh, n.loc.ylow)
      case n@Node(_,"CHANY",Some("INC_DIR"),_,_) => (n.loc.xlow, n.loc.ylow-1)
      case n@Node(_,"CHANY",Some("DEC_DIR"),_,_) => (n.loc.xlow, n.loc.yhigh)
      case n@Node(_,"SOURCE",_,_,_) => (n.loc.xlow, n.loc.ylow)
      case n@Node(_,"SINK",_,_,_) => (n.loc.xlow, n.loc.ylow)
      case _ => throw new Exception(s"Node ${node} seems to be INVALID")
    }
  }
  def tileLocOfNode(node: Int): (Int, Int) = {
    // Note: This is Seq so this will be very slow
    tileLocOfNode(nodes(node))
  }

  def getSegmentName(nodeId: Int): String = {
    // Note: This is Seq so this will be very slow
    val node = nodes(nodeId)
    //println(s"${nodes(nodeId)} --> ${node.segmentId.getOrElse("NONE")}")
    segments.find( segment => segment.id == node.segmentId.get.segment_id.toInt).get.name
  }

  def nodesInTile(loc: (Int,Int)): List[Node] = {
    val (x,y) = (loc._1, loc._2)
    //println(s"checking nodes in tile ${x},${y}")
    val nodesInTile = nodes.filter(node =>
      node match {
        case n@Node(_,"IPIN",_,_,_) if (n.loc.xlow==x && n.loc.ylow==y) => true
        case n@Node(_,"OPIN",_,_,_) if (n.loc.xlow==x && n.loc.ylow==y) => true
        case n@Node(_,"CHANX",Some("INC_DIR"),_,_) if (n.loc.xlow-1==x && n.loc.ylow==y) => true
        case n@Node(_,"CHANX",Some("DEC_DIR"),_,_) if (n.loc.xhigh==x && n.loc.ylow==y) => true
        case n@Node(_,"CHANY",Some("INC_DIR"),_,_) if (n.loc.xlow==x && n.loc.ylow-1==y) => true
        case n@Node(_,"CHANY",Some("DEC_DIR"),_,_) if (n.loc.xlow==x && n.loc.yhigh==y) => true
        case _ => false // Ignore SOURCE/SINK nodes here
    })
    //println(nodesInTile.length)
    nodesInTile
  }

  def filterTilesByCol(colId: Int): SortedMap[Int, RRtile] = {
    SortedMap.empty[Int, RRtile] ++ tiles.filter{
      case((col,row),rrtile) =>
        col == colId }.map{ case ((col,row),rrTile) => (row, rrTile) }
  }

  def print_scan_chain_info() = {
    // Non-empty Tiles 
    val usedtiles = tiles.filter{ case (grid, rrTile) => rrTile.tileNodesSet.nonEmpty}
    val (width, height) = (grid.map(g => g.x).max, grid.map(g => g.y).max)
    val confbits = (0 until width+1).map{
      col => filterTilesByCol(col).map{
      case (i, tile) => (tile.props.confInfo.totalConfBits/8.0).ceil.toInt}
    }
    print(confbits)
    confbits
  }

}
