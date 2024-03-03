package vtrutils.other

import scala.collection.mutable
object AppPinMap1 {
  def main(args: Array[String]) {
    val numIOTiles = 4
    val tileIOs: Map[Int, TileIO] = (0 until numIOTiles).map(i => i -> TileIO(4, i + 1)).toMap
    //println(tileIOmap)

    tileIOs(0).addIns("IN", 32, 0)
    tileIOs(1).addIns("IN", 32, 0, 32)
    tileIOs(2).addIns("IN", 32, 0, 32 * 2)
    tileIOs(3).addIns("IN", 32, 0, 32 * 3)

    tileIOs(0).addOuts("OUT", 32, 0)
    tileIOs(1).addOuts("OUT", 32, 0, 32)
    tileIOs(2).addOuts("OUT", 32, 0, 32 * 2)
    tileIOs(3).addOuts("OUT", 32, 0, 32 * 3)

    import java.io._
    val pinMapFile = new PrintWriter(new File("vpr_pin_place"))
    (0 until numIOTiles).foreach { i =>
      tileIOs(i).getPinLocs.foreach(io => pinMapFile.println(io))
    }
    pinMapFile.close()
  }

}


case class TileIO(x: Int, y: Int) {
  var ins = mutable.Seq.fill(32)("NULL")
  val outs = mutable.Seq.fill(32)("NULL")

  def addIns(name: String, len: Int, offset: Int, bus_id_offset: Int = 0) = {
    (0 until len).foreach { i =>
      ins(i + offset) = s"${editName(name)}[${i+bus_id_offset}] \t\t\t $x \t $y \t ${i + offset+ 32}"
    }
  }

  def addIns(name: String, offset: Int) = {
    ins(offset) = s"${editName(name)} \t\t\t $x \t $y \t ${offset + 32}"
  }

  def addOuts(name: String, len: Int, offset: Int, bus_id_offset: Int = 0) = {
    (0 until len).foreach { i =>
      outs(i + offset) = s"out:${editName(name)}[${i+bus_id_offset}] \t\t\t $x \t $y \t ${i + offset}"
    }
  }

  def addOuts(name: String, offset: Int) = {
    outs(offset) = s"out:${editName(name)} \t\t\t $x \t $y \t ${offset}"
  }

  def editName(name: String) = name.replaceAll("\\.", "_")
  def getPinLocs: mutable.Seq[String] = (ins.filter(!_.contains("NULL")) ++ outs.filter(!_.contains("NULL")))
}
