package vtrutils

// Creates a tile for every block in grid
// TODO: Assumes tile height & width == 1. Extend for any width/height
// FIXME: Remove configType
class RRtile(rrGraph: RRgraph, gridLoc: Grid, configType: String = "INVALID") {

  // TODO: convert set of Int to set of Nodes to simplify code?
  // 1 - ALL NODES IN TILE
  val tileNodesSet: Set[Int] = rrGraph.nodesInTile((gridLoc.x,gridLoc.y)).filter(n =>
    n match {
      // Filter global clocks & non-clock-global IPIN nodes (with 0 fain-ins) as they are connected sepa
      case n if n.ntype=="IPIN" => rrGraph.nodeFanIns.contains(n.id)
      // filter OPIN nodes with zero fan-outs (chain connections of DSP/CLB tiles at edges)
      case n if n.ntype=="OPIN" => rrGraph.nodeFanOuts.contains(n.id)
      case n if n.ntype=="CHANX" => rrGraph.nodeFanOuts.contains(n.id)
      case n if n.ntype=="CHANY" => rrGraph.nodeFanOuts.contains(n.id)
      case _ => false
    }).map(_.id).toSet

  // 2 - IN NODEs: Tile input nodes (all fan-in nodes of IPINs and CHANs outside (not in) tile)
  private val fanInNodesSet: Set[Int] = tileNodesSet.filter(n =>
    rrGraph.muxNodes(n).ntype!="OPIN").flatMap(n => rrGraph.nodeFanIns.getOrElse(n, Seq[Int]()))
  val inputNodes: Seq[Node] = (fanInNodesSet &~ tileNodesSet).map(n => rrGraph.muxNodes(n)).toSeq.sortBy(_.id)

  // 3 - OUT NODEs: Tile output nodes (OPIN/CHAN nodes with fan-out outside tile)
  val outputNodes: Seq[Node] = tileNodesSet.filter(n =>
    rrGraph.muxNodes(n).ntype!="IPIN").filter{n =>
    //println(s" ${n}")
    (rrGraph.nodeFanOuts(n).toSet &~ tileNodesSet).nonEmpty}.map(n => rrGraph.muxNodes(n)).toSeq

  // 4 - Configuration bitstream info
  val confNodes: Seq[Node] = tileNodesSet.toSeq.map(rrGraph.muxNodes(_)).filter(_.ntype!="OPIN").sortBy(_.id)

  // 5 - Tile properties
  val props: Props = Props(gridLoc, configType, confNodes)


  // =========== HELPER CLASSES & FUNCTIONS ========================
  case class ConfInfo(nodes: Seq[Node], lBlkName: String) {

    val nodeConfBits: Map[Int, Int] = nodes.map(n => (n.id, getNumConfBits(n))).toMap
    val routingConfBits: Int = nodeConfBits.values.sum
    val logicBlockConfBits: Int = efpga.logicblks.LogicBlockDB.blocks(lBlkName).numConfBits
    val totalConfBits = routingConfBits + logicBlockConfBits

    def getNumConfBits(node: Node): Int = {

      def sboxNumConfBits(node: Node): Int = {
        val fanInNodes = rrGraph.nodeFanIns.getOrElse(node.id, Seq[Int]()).map(rrGraph.muxNodes(_))
        val opins = fanInNodes.filter(_.ntype=="OPIN")
        val chans = fanInNodes.filter(n => n.ntype=="CHANX"||n.ntype=="CHANY")
          //TODO: Optimize bits later
        //if (opins.length==0 || chans.length==0) {
        //  math.ceil(log2(math.max(opins.length, chans.length))).toInt
        //} else {
          chisel3.util.log2Up(math.max(opins.length, chans.length)) + 1
      }

      def log2(n: Double): Double = math.log10(n)/math.log10(2)

      val numBits = node match {
        case n@Node(_, "IPIN", _, _, _) => math.ceil(log2(rrGraph.nodeFanIns.getOrElse(n.id, Seq[Int]()).length + 1)).toInt
        case n@Node(_, "CHANY", _, _, _) => sboxNumConfBits(n)

        case n@Node(_, "CHANX", _, _, _) => sboxNumConfBits(n)
      }
      numBits
    }
  }

  // Properties class
  //TODO: Organize better
  case class Props(gridLoc: Grid, confType: String, confNode: Seq[Node]) {
    val x: Int = gridLoc.x
    val y: Int = gridLoc.y
    private val blk = rrGraph.blkTypes.find(b => b.id==gridLoc.block_type_id).get
    val height: Int = blk.height
    val name: String = blk.name
    val isIOtile: Boolean = name.contains("io")
    val confInfo: ConfInfo = ConfInfo(confNodes, name)
  }

  def printRRtileInfo(): Unit = {
    println(props.name)
    tileNodesSet.map(rrGraph.muxNodes(_)).toSeq.sortBy(_.id).foreach(println)
    //props.confInfo.nodeConfBits.toSeq.sortBy(_._1).map(println(_))
    println(s"TOTAL CONF BITS: ${props.confInfo.routingConfBits}")
  }
}
