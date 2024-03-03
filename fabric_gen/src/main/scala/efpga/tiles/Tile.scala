package efpga.tiles

import chisel3._
import cmu.util.TristateIO
import efpga.config.{ConfIO, ConfigBlock}
import efpga.logicblks.LogicBlockImpl
import vtrutils._

//TODO: Find a good location & enable a way to add new control signals
class efpgaCtrlSignals extends Bundle {
  val gndBlkOuts = Input(Bool())
  //val loopBreak = Input(Bool())
  val pathBreak = Input(Bool())

  // Non-functional clocks
  val confClock = Input(Clock())
}

case class TileIO(inLen: Int, outLen: Int) extends Bundle {
  val i = Input(UInt(inLen.W))
  val o = Output(UInt(outLen.W))
}

// TODO @enhancement : assumes only one LB per tile. Create HyperTiles with multiple LBs
abstract class Tile extends Module {

  // Pointer to the RRTile for information about tile
  val rrTileInfo: RRtile

  // A Tile must contain the following standardized items (for RTL generation)

  /** *** Modules **** */
  // 1. logicBlock for that tile
  val logicBlock: Option[LogicBlockImpl]
  // 2. Config Block
  val configBlock: Option[ConfigBlock]

  /***** IO Bundles *****/
  // 3. ins (CHANS/OPINS in other tiles)
  val ioIns: Map[Int, Bool]
  // 4. outs (CHAN/OPINS in this tile)
  val ioOuts: Map[Int, Bool]
  // 5. configuration IO for that tile
  val ioConf: ConfIO
  // 6. efpga external IO if Tile has IO
  val ioPad: Option[TileIO]
  // 7. Control signals
  val ctrlSignals: efpgaCtrlSignals



}


