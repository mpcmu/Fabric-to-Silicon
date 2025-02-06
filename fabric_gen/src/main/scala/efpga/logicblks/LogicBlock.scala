package efpga.logicblks

import chisel3._
// import cmu.util.TristateIO
import efpga.tiles.TileIO

import scala.collection.immutable.SortedMap

// All logic blocks available for instantiation


case class LogicBlockInfo(
  name: String,
  numConfBits: Int,
  hasIO: Boolean = false,
  numIOIns: Int = 0,
  numIOOuts: Int = 0)

// Format for logic block implementation
abstract class LogicBlockImpl extends RawModule {

  val IPINs: SortedMap[Int, Bool]
  val OPINs: SortedMap[Int, Bool]
  val clock: Clock
  val reset: Bool
  val ioPad: Option[TileIO]

  //Control signals
  //val loopBreak: Bool
  val gndLBouts: Bool
  val pathBreak: Bool

  // Configuration Bits
  val configBits: UInt

  // LB Information
  val info: LogicBlockInfo

}

//TODO: automate addition ot LB to this Map
object LogicBlockDB {
  // Add new LBs here
  val blocks = Map(
    "iotile" -> LogicBlockInfo("iotile", 16, hasIO = true, 32, 32),
    "clbalutile" -> LogicBlockInfo("clbalutile", 8 * 20 + 32 + 2),
    "custmultile" -> LogicBlockInfo("custmultile", 32),
    "EMPTY" -> LogicBlockInfo("EMPTY", 0)
  )
}