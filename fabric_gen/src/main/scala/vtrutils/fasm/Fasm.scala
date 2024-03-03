package vtrutils.fasm

import scala.collection.mutable._
import vtrutils.{Grid, Node, RRgraph}

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer
// Creates FASM configuration structure
case class ConfFragment(val id: String, var bits: Seq[Char]) {
  def length: Int = bits.length
  def bitStream: String = bits.reverse.mkString("")
}


trait Config {
  val fragments: mutable.ArrayBuffer[ConfFragment] = mutable.ArrayBuffer.empty

  def addFragment(frag:ConfFragment): Unit = {
    fragments += frag
  }

  def addFragments(frags:mutable.SortedMap[Int, ConfFragment]): Unit = {
    frags.foreach{ case(id,frag) =>
      fragments += frag
    }
  }

  def confLength: Int = fragments.map{_.length}.sum
  def bitStream: String = fragments.map{_.bitStream}.toString()

  def parseFASM(fasm: String): Unit

}


trait ConfigBlock {
  val configs: mutable.ArrayBuffer[Config] = mutable.ArrayBuffer.empty

  def addConfig(conf: Config): Unit = {
    configs += conf
  }

  // Type T must be a subset of ConfigBlock
  def addConfigBlock[T <: ConfigBlock](conf: T): Unit = {
    configs ++= conf.configs
  }

  def confLength: Int = configs.map{_.fragments.map{_.length}.sum}.sum
  def bitStream: List[String] = configs.flatMap{_.fragments.map{_.bitStream}}.toList

  def parseFASM(fasm: String): Unit

}


