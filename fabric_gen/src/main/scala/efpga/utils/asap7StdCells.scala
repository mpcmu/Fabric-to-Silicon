// See README.md for license details.
// LUT class

package main.scala.efpga.utils

import chisel3._
import chisel3.RawModule
import chisel3.util.{Cat, HasBlackBoxResource}

import scala.collection.mutable.ListBuffer

abstract class asap7Stdcell(val id: String, val size: String = "2", val vt: String = "L") extends BlackBox {
  val allowedVTs = Seq("SRAM", "R", "L", "SL", "BB")
  require(allowedVTs.contains(vt))
  override def desiredName = s"${id}x${size}_ASAP7_75t_${vt}"
}

class asap7Buf(size: String = "2", vt: String = "L") extends asap7Stdcell("BUF", size, vt) {
  val io = IO(new Bundle {
    val A = Input(Bool())
    val Y = Output(Bool())
  })
}
