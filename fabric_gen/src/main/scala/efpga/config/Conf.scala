package efpga.config

import chisel3._
import efpga.tiles.{Tile}

abstract class ConfIO extends Bundle {
  val confOut: UInt
  val confPort: ScanBundle
}

abstract class ConfigBlock extends Module {
  val ioBundle: ConfIO
}

