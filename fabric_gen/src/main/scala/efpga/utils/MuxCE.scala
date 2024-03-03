package efpga.utils

import chisel3._
import chisel3.experimental.ExtModule
import chisel3.util.RegEnable
import main.scala.efpga.utils.asap7Buf


abstract class MuxCE extends ExtModule {
  val in : UInt
  val sel : UInt
  val o: UInt
}

class Mux2CE extends MuxCE {
    override val in = IO(Input(UInt(2.W)))
    override val sel = IO(Input(UInt(1.W)))
    override val o = IO(Output(UInt(1.W)))

  override def desiredName: String = "Mux2C"
}

class Mux4CE extends MuxCE {
    override val in = IO(Input(UInt(4.W)))
    override val sel = IO(Input(UInt(2.W)))
    override val o = IO(Output(UInt(1.W)))

  override def desiredName: String = "Mux4C"
}

class Mux8CE extends MuxCE {
    override val in = IO(Input(UInt(8.W)))
    override val sel = IO(Input(UInt(3.W)))
    override val o = IO(Output(UInt(1.W)))
  override def desiredName: String = "Mux8C"
}

class Mux16CE extends MuxCE {
    override val in = IO(Input(UInt(16.W)))
    override val sel = IO(Input(UInt(4.W)))
    override val o = IO(Output(UInt(1.W)))
  override def desiredName: String = "Mux16C"
}


class Mux32CE extends MuxCE {
    override val in = IO(Input(UInt(32.W)))
    override val sel = IO(Input(UInt(5.W)))
    override val o = IO(Output(UInt(1.W)))
  override def desiredName: String = "Mux32C"
}

object PathBreakFF {
  def apply(in: Bool, en: Bool, name: String = "pbFF"): Bool = {
    val pbFF = RegEnable(in, en).suggestName(s"$name")
    Mux(en, pbFF, in)
  }
}

object LoopBreakBuf {
  def apply(in: Bool, size: Int = 2, vt: String = "L", instName: String = "lbBuf"): Bool = {
    val buf = Module(new asap7Buf(s"$size", vt).suggestName(s"$instName"))
    buf.io.A := in
    buf.io.Y
  }
}
