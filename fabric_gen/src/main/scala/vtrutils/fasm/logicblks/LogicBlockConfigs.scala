package vtrutils.fasm.logicblks

import vtrutils.fasm._

import scala.collection.mutable
import scala.collection.mutable._


case class BleConf(val prefix: String = "") extends Config {
  //override val fragments =  mutable.SortedMap.empty

  // Add from MSB t0 LSB
  addFragment(ConfFragment("Xbar", Seq.fill(2)('0')))
  addFragment(ConfFragment("mux_top", Seq('0')))
  addFragment(ConfFragment("mux_right", Seq('0')))
  addFragment(ConfFragment("LUT.INIT", '1' +: Seq.fill(15)('0')))
  assert(confLength == 20, s"CLB conf issue 20 != $confLength | $fragments")

  override def parseFASM(fasm: String): Unit = {
    println(s"    BLE($prefix) parsing -> $fasm  ")
    fasm match {
      case x if x.contains("Xbar") => ???
      case x if x.contains("VPR") => println("  SKIPPING - NOT YET IMPLEMENTED")
      case x if x.contains("mux_top") => fragments.find(_.id == "mux_top").get.bits(0) = x.split("mux_top_")(1).charAt(0)
      case x if x.contains("mux_right") => fragments.find(_.id == "mux_right").get.bits(0) = x.split("mux_right_")(1).charAt(0)
      case x if x.contains("LUT.INIT") =>
        val lutfrag = fragments.find(_.id == "LUT.INIT").get
        //x.split("16'b")(1).toCharArray.zipWithIndex.foreach { case (bit, idx) => lutfrag.bits(idx) = bit }
        lutfrag.bits = x.split("16'b")(1).toCharArray.reverse
        println(s"     Setting LUT to ${lutfrag.bitStream}")
      case _ => assert(false, s"Unexpected FASM for BLE($prefix) $fasm")
    }
  }
}

case class ClbConf(prefix: String = "", numBle: Int = 8) extends ConfigBlock {
  //override val fragments =  mutable.SortedMap.empty
  // BLE from MSB to LSB
  Range(0,numBle).reverse.foreach{ ble =>
    addConfig(BleConf(s"BLE$ble"))
  }

  override def parseFASM(fasm: String): Unit = {
    val bleId = "BLE([0-9]+)".r.findAllIn(fasm).subgroups(0)
    println(s"    CLBBLE parsing $fasm -> forward to CLBBLE ${bleId}")
    configs(numBle-1 - bleId.toInt).parseFASM(fasm.split("CLBBLE[0-9]+.")(1))
  }
}


case class AluConf(val prefix: String = "") extends Config {
  //override val fragments =  mutable.SortedMap.empty

  // Add from MSB t0 LSB
  addFragment(ConfFragment("clkEnb", Seq('0')))
  addFragment(ConfFragment("CLBALU", Seq('0')))
  addFragment(ConfFragment("CLBALU.MODE_ALU", Seq.fill(32)('0')))
  assert(confLength == 32 + 2, s"CLB conf issue 34 != $confLength | $fragments")

  override def parseFASM(fasm: String): Unit = {
    println(s"    ALU parsing -> $fasm  ")
    fasm match {
      case x if x.endsWith("CLBALU") => fragments.find(_.id == "CLBALU").get.bits(0) = '1'
      case x if x.contains("CLBALU.MODE_ALU") =>
        val alumode = fragments.find(_.id == "CLBALU.MODE_ALU").get
        x.split("=32'b")(1).toCharArray.reverse.zipWithIndex.foreach { case (bit, idx) => alumode.bits(idx) = bit }
      case _ => assert(false, s"Unexpected FASM for ALU($prefix) $fasm")
    }
  }
}

case class ClbAluConfig(prefix: String = "") extends ConfigBlock {

  val (aluConf, clbConf) = (AluConf("ALU"), ClbConf("BLEs"))
  addConfig(aluConf)
  addConfigBlock(clbConf)
  assert(confLength == 20*8 + 32 + 2, "CLB conf issue")

  override def parseFASM(fasm: String): Unit = {
    println(s"    CLBALU parsing $fasm, ${fasm.split(".").toList}")
    fasm match {
      case x if x.contains("ALU") => aluConf.parseFASM(fasm)
      case x if x.contains("BLE") => clbConf.parseFASM(fasm)
      case _ => assert(false, s"Unexpected FASM for CLBALU $fasm")
    }
  }

}

case class MemConf(val prefix: String = "") extends Config {
  //override val fragments =  mutable.SortedMap.empty

  addFragment(ConfFragment("clkEnb", Seq('0')))
  addFragment(ConfFragment("CLBRAM", Seq('0')))
  addFragment(ConfFragment("CLBRAM.DONT_USE_FF", Seq('1')))
  assert(confLength == 3, s"CLB conf issue 3 != $confLength | $fragments")

  override def parseFASM(fasm: String): Unit = {
    fasm match {
      case x if x.contains("CLBRAM") => fragments.find(_.id == "CLBRAM").get.bits(0) = '1'
      case x if x.contains("CLBALU.USE_FF") => fragments.find(_.id == "CLBRAM.DONT_USE_FF").get.bits(0) = '0'
      case _ => assert(false, s"Unexpected FASM for ALU($prefix) $fasm")
    }
  }
}


case class ClbMulConfig(prefix: String = "") extends ConfigBlock {

  val (aluConf, clbConf) = (AluConf("ALU"), ClbConf("BLEs"))
  addConfig(aluConf)
  addConfigBlock(clbConf)
  assert(confLength == 20*8 + 32 + 2, "CLB conf issue")

  override def parseFASM(fasm: String): Unit = {
    fasm match {
      case x if x.contains("ALU") => aluConf.parseFASM(fasm)
      case x if x.contains("BLE") => clbConf.parseFASM(fasm)
      case _ => assert(false, s"Unexpected FASM for CLBALU $fasm")
    }
  }

}

case class ClbMemConfig(numBle:Int = 8) extends ConfigBlock {
  val (memConf, clbConf) = (MemConf("RAM"), ClbConf("BLEs"))
  addConfig(memConf) // 0
  addConfigBlock(clbConf)
  assert (confLength == 20*8 + 3, "CLBMEM conf issue")

  override def parseFASM(fasm: String): Unit = {
    fasm match {
      case x if x.contains("RAM") => memConf.parseFASM(fasm)
      case x if x.contains("BLE") => clbConf.parseFASM(fasm)
      case _ => assert(false, s"Unexpected FASM for CLBALU $fasm")
    }
  }

}

case class IOConfig() extends Config {
  addFragment(ConfFragment("IO.USE_FF", Seq.fill(16)('0')))
  assert (confLength == 16, "CLB conf issue")

  override def parseFASM(fasm: String): Unit = ???
}

case class IOBlockConfig(numBle:Int = 8) extends ConfigBlock {
  val ioConfig = IOConfig()
  addConfig(ioConfig)
  override def parseFASM(fasm: String): Unit = ???

}

case class CustMulConfig(val prefix: String = "") extends Config {

  // Add from MSB t0 LSB
  addFragment(ConfFragment("CUSTMUL.MODE_CUSTMUL", Seq.fill(32)('0')))
  assert(confLength == 32, s"CUSTMUL conf issue 32 != $confLength | $fragments")

  override def parseFASM(fasm: String): Unit = {
    println(s"    CUSTMUL parsing -> $fasm  ")
    fasm match {
      case x if x.contains("CUSTMUL_LB.MODE_CUSTMUL") =>
        val custmulmode = fragments.find(_.id == "CUSTMUL.MODE_CUSTMUL").get
        x.split("=32'b")(1).toCharArray.reverse.zipWithIndex.foreach { case (bit, idx) => custmulmode.bits(idx) = bit }
      case _ => assert(false, s"Unexpected FASM for CUSTMUL($prefix) $fasm")
    }
  }

}

case class CustMulBlockConfig() extends ConfigBlock {
  val custMulConfig = CustMulConfig()
  addConfig(custMulConfig)
  assert(confLength == 32, "CUSTMUL block conf issue")

  override def parseFASM(fasm: String): Unit = {
    println(s"    CUSTMUL parsing $fasm, ${fasm.split(".").toList}")
    fasm match {
      case x if x.contains("CUSTMUL") => custMulConfig.parseFASM(fasm)
      case _ => assert(false, s"Unexpected FASM for CUSTMUL $fasm")
    }
  }

}