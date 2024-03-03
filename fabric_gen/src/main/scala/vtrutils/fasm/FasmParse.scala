package vtrutils.fasm

import vtrutils.RRgraph
import vtrutils.fasm.logicblks.TileConfig

case class FpgaConfig(rrGrf: RRgraph, fasm: Iterator[String], forcePrefix: String = "") {

  val tileConfigs = rrGrf.tiles.filter { case (grid, rrTile) =>
    rrTile.tileNodesSet.nonEmpty
  }.transform {
    case (grid, rrTile) => (rrTile, TileConfig(rrGrf, rrTile))
    //case (grid, rrTile) => TileConfig(rrGrf, rrTile)
  }

  fasm.zipWithIndex.foreach { case(fasm,i) =>
    println(s"$i -> $fasm PARSE")
    fasm match {
      case x if x.contains("sink_") =>
        val (sink, src) = (fasm.split("_")(1).toInt, fasm.split("_")(3).toInt)
        if (rrGrf.muxNodes.contains(sink)) {
          val (x, y) = rrGrf.tileLocOfNode(sink)
          tileConfigs(x, y)._2.parseFASM(fasm)
        } else {
          println(s"   WARNING: Skipping $sink. Not CHAN or IPIN. type = ${rrGrf.nodes(sink).ntype}")
        }
      case x if x.contains("LB") =>
        val tileIds = "^[a-z]+_([0-9]+)_([0-9]+)".r.findAllIn(fasm).subgroups.toArray
        println(s"   TILE ${tileIds(0)}, ${tileIds(1)}")
        tileConfigs(tileIds(0).toInt,tileIds(1).toInt)._2.parseFASM(fasm)

      case _ => assert(false, s"Unexpected FASM for Tile $fasm")
    }
  }

  def formatBitstream(stream: List[String]): List[(Int,String)] = {
    var len = stream.mkString.length-1
    stream.map { i =>
      val res = (len, i)
      len -= i.length
      res
    }
  }

  import java.io._
    val writeCocotb = new PrintWriter(new File("bitstream/bitstream_force"))
    val writeInfo = new PrintWriter(new File("bitstream/bitstream_info"))

  tileConfigs.foreach { case (grid, tile) =>
    var bitstreamLen = tile._2.bitStream.mkString.length
    val extraRoundTo16 = (math.ceil(bitstreamLen * 1.0 / 16) * 16).toInt - bitstreamLen
    val bitstream = List(Seq.fill(extraRoundTo16)('0').mkString) ++ tile._2.bitStream

    // println(s"$grid , ${tile._1.props.name}, ${bitstreamLen+extraRoundTo16} <- ${tile._2.confLength}, ${formatBitstream(bitstream)}")
    writeInfo.println(s"$grid , ${tile._1.props.name}, ${bitstreamLen+extraRoundTo16} <- ${tile._2.confLength}, ${formatBitstream(bitstream)}")

    val tileName = s"Tile_${grid._1}_${grid._2}_${tile._1.props.name}"
    writeCocotb.println(forcePrefix + s"$tileName.configBlock.ioBundle_confOut ${bitstream.mkString}")
  }
  println(s"Generated config for ${tileConfigs.toList.length}")

  writeInfo.close()
  writeCocotb.close()
}



object BitstreamGen extends App {

  val fasmFile = args(1)
  val xmlFile = args(0)

  val fp = scala.io.Source.fromFile(fasmFile)
  val fasm = fp.getLines
  val rrParser = new vtrutils.ParseRRXML(xmlFile)
  val rrGraph: RRgraph = rrParser.getRRGraph()

  // Create bitstream DB
  val bitStream = FpgaConfig(rrGraph, fasm)

}