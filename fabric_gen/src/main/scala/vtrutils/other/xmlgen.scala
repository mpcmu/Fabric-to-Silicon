package vtrutils.other

object ScalaXmlGen extends App {
  import scalatags.Text.all._
  import java.io._
  args.foreach(println(_))
  val fp = new BufferedWriter(new FileWriter("layout.xml"))

  var tiles = scala.collection.SortedMap(
    1 -> "clbalutile",
    2 -> "clbalutile",
    3 -> "clbalutile",
    4 -> "clbalutile",
    5 -> "clbalutile",
    6 -> "clbalutile",
    7 -> "clbalutile",
    8 -> "clbalutile",
    9 -> "clbalutile",
    10 -> "clbalutile"
  ).toList
  def single(x: Int, y: Int, priority: Int = 12, blkType: String) = tag("single")(attr("priority") := "12", attr("type") := s"$blkType", attr("x") := s"$x", attr("y") := s"$y")
  def tilemeta(fasmPrefix: String) = tag("metadata")(tag("meta")(attr("name") := "fasm_prefix")(fasmPrefix))
  def size(width: Int, height: Int) = tag("fixed_layout")(attr("name") := "fixedly", attr("width") := s"$width", attr("height") := s"$height")
  def perimeter(priority: Int = 101) = tag("perimeter")(attr("type") := "EMPTY", attr("priority") := s"$priority")
  def colfill(tileName: String, startx: Int, starty: Int, priority: Int) = tag("col")(attr("type") := s"$tileName", attr("startx") := s"$startx", attr("starty") := s"$starty", attr("priority") := s"$priority")

  //val cols = (1 until 10)
  val y = 1
  val fragment = {
    tag("layout")(
      size(12,12)(
        perimeter(101),
        colfill("iotile", 10, 1, 14),
        for((x, name) <- tiles) yield for(y <- (1 until 11)) yield {
          //val priority = if(name == "clbalutile") 10 else 12
          single(x,y,10, name)(
            tilemeta(s"${name}_${x}_$y")
          )
        }
      )
    )
  }

  val str = scala.xml.XML.loadString(fragment.toString())
  val fmtStr = new scala.xml.PrettyPrinter(80, 2).format(str)
  print(fmtStr)
  fp.write(fmtStr)
  fp.close()

}


