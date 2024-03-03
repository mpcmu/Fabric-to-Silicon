circuit CLBlut4N10 :
  extmodule Mux16C :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_1 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_1 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_2 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_2 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_3 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_3 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_4 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_4 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_5 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_5 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_6 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_6 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  extmodule Mux16C_7 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>}

    inst lut of Mux16C_7 @[CLBlut4N10Clb.scala 73:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 74:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 74:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 75:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 75:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 75:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 75:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 77:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 80:27]
    node _io_outR_T_1 = mux(_io_outR_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 80:17]
    node _io_outR_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 80:52]
    node _io_outR_T_3 = and(_io_outR_T_1, _io_outR_T_2) @[CLBlut4N10Clb.scala 80:50]
    io.outR <= _io_outR_T_3 @[CLBlut4N10Clb.scala 80:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 81:27]
    node _io_outT_T_1 = mux(_io_outT_T, lut.o, bleFF) @[CLBlut4N10Clb.scala 81:17]
    node _io_outT_T_2 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 81:52]
    node _io_outT_T_3 = and(_io_outT_T_1, _io_outT_T_2) @[CLBlut4N10Clb.scala 81:50]
    io.outT <= _io_outT_T_3 @[CLBlut4N10Clb.scala 81:11]

  module CLBlut4N10 :
    input IPIN_0 : UInt<1>
    input IPIN_1 : UInt<1>
    input IPIN_2 : UInt<1>
    input IPIN_3 : UInt<1>
    input IPIN_4 : UInt<1>
    input IPIN_5 : UInt<1>
    input IPIN_6 : UInt<1>
    input IPIN_7 : UInt<1>
    input IPIN_8 : UInt<1>
    input IPIN_9 : UInt<1>
    input IPIN_10 : UInt<1>
    input IPIN_11 : UInt<1>
    input IPIN_12 : UInt<1>
    input IPIN_13 : UInt<1>
    input IPIN_14 : UInt<1>
    input IPIN_15 : UInt<1>
    input IPIN_16 : UInt<1>
    input IPIN_17 : UInt<1>
    input IPIN_18 : UInt<1>
    input IPIN_19 : UInt<1>
    input IPIN_20 : UInt<1>
    input IPIN_21 : UInt<1>
    input IPIN_22 : UInt<1>
    input IPIN_23 : UInt<1>
    input IPIN_24 : UInt<1>
    input IPIN_25 : UInt<1>
    input IPIN_26 : UInt<1>
    input IPIN_27 : UInt<1>
    input IPIN_28 : UInt<1>
    input IPIN_29 : UInt<1>
    input IPIN_30 : UInt<1>
    input IPIN_31 : UInt<1>
    input IPIN_32 : UInt<1>
    input IPIN_33 : UInt<1>
    input IPIN_34 : UInt<1>
    input IPIN_35 : UInt<1>
    input IPIN_36 : UInt<1>
    input IPIN_37 : UInt<1>
    input IPIN_38 : UInt<1>
    input IPIN_39 : UInt<1>
    output OPIN_40 : UInt<1>
    output OPIN_41 : UInt<1>
    output OPIN_42 : UInt<1>
    output OPIN_43 : UInt<1>
    output OPIN_44 : UInt<1>
    output OPIN_45 : UInt<1>
    output OPIN_46 : UInt<1>
    output OPIN_47 : UInt<1>
    output OPIN_48 : UInt<1>
    output OPIN_49 : UInt<1>
    output OPIN_50 : UInt<1>
    output OPIN_51 : UInt<1>
    output OPIN_52 : UInt<1>
    output OPIN_53 : UInt<1>
    output OPIN_54 : UInt<1>
    output OPIN_55 : UInt<1>
    input clock : Clock
    input reset : UInt<1>
    input configBits : UInt<162>
    input loopBreak : UInt<1>
    input gndLBouts : UInt<1>

    wire _I_WIRE : UInt<1>[8] @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[0] <= IPIN_0 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[1] <= IPIN_1 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[2] <= IPIN_2 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[3] <= IPIN_3 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[4] <= IPIN_4 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[5] <= IPIN_5 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[6] <= IPIN_6 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE[7] <= IPIN_7 @[CLBlut4N10Clb.scala 35:82]
    node I_lo_lo = cat(_I_WIRE[1], _I_WIRE[0]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_hi = cat(_I_WIRE[3], _I_WIRE[2]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo = cat(I_lo_hi, I_lo_lo) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_lo = cat(_I_WIRE[5], _I_WIRE[4]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_hi = cat(_I_WIRE[7], _I_WIRE[6]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi = cat(I_hi_hi, I_hi_lo) @[CLBlut4N10Clb.scala 35:92]
    node I_0 = cat(I_hi, I_lo) @[CLBlut4N10Clb.scala 35:92]
    wire _I_WIRE_1 : UInt<1>[8] @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[0] <= IPIN_8 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[1] <= IPIN_9 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[2] <= IPIN_10 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[3] <= IPIN_11 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[4] <= IPIN_12 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[5] <= IPIN_13 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[6] <= IPIN_14 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_1[7] <= IPIN_15 @[CLBlut4N10Clb.scala 35:82]
    node I_lo_lo_1 = cat(_I_WIRE_1[1], _I_WIRE_1[0]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_hi_1 = cat(_I_WIRE_1[3], _I_WIRE_1[2]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_1 = cat(I_lo_hi_1, I_lo_lo_1) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_lo_1 = cat(_I_WIRE_1[5], _I_WIRE_1[4]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_hi_1 = cat(_I_WIRE_1[7], _I_WIRE_1[6]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_1 = cat(I_hi_hi_1, I_hi_lo_1) @[CLBlut4N10Clb.scala 35:92]
    node I_1 = cat(I_hi_1, I_lo_1) @[CLBlut4N10Clb.scala 35:92]
    wire _I_WIRE_2 : UInt<1>[8] @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[0] <= IPIN_16 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[1] <= IPIN_17 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[2] <= IPIN_18 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[3] <= IPIN_19 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[4] <= IPIN_20 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[5] <= IPIN_21 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[6] <= IPIN_22 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_2[7] <= IPIN_23 @[CLBlut4N10Clb.scala 35:82]
    node I_lo_lo_2 = cat(_I_WIRE_2[1], _I_WIRE_2[0]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_hi_2 = cat(_I_WIRE_2[3], _I_WIRE_2[2]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_2 = cat(I_lo_hi_2, I_lo_lo_2) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_lo_2 = cat(_I_WIRE_2[5], _I_WIRE_2[4]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_hi_2 = cat(_I_WIRE_2[7], _I_WIRE_2[6]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_2 = cat(I_hi_hi_2, I_hi_lo_2) @[CLBlut4N10Clb.scala 35:92]
    node I_2 = cat(I_hi_2, I_lo_2) @[CLBlut4N10Clb.scala 35:92]
    wire _I_WIRE_3 : UInt<1>[8] @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[0] <= IPIN_24 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[1] <= IPIN_25 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[2] <= IPIN_26 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[3] <= IPIN_27 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[4] <= IPIN_28 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[5] <= IPIN_29 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[6] <= IPIN_30 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_3[7] <= IPIN_31 @[CLBlut4N10Clb.scala 35:82]
    node I_lo_lo_3 = cat(_I_WIRE_3[1], _I_WIRE_3[0]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_hi_3 = cat(_I_WIRE_3[3], _I_WIRE_3[2]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_3 = cat(I_lo_hi_3, I_lo_lo_3) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_lo_3 = cat(_I_WIRE_3[5], _I_WIRE_3[4]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_hi_3 = cat(_I_WIRE_3[7], _I_WIRE_3[6]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_3 = cat(I_hi_hi_3, I_hi_lo_3) @[CLBlut4N10Clb.scala 35:92]
    node I_3 = cat(I_hi_3, I_lo_3) @[CLBlut4N10Clb.scala 35:92]
    wire _I_WIRE_4 : UInt<1>[8] @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[0] <= IPIN_32 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[1] <= IPIN_33 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[2] <= IPIN_34 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[3] <= IPIN_35 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[4] <= IPIN_36 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[5] <= IPIN_37 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[6] <= IPIN_38 @[CLBlut4N10Clb.scala 35:82]
    _I_WIRE_4[7] <= IPIN_39 @[CLBlut4N10Clb.scala 35:82]
    node I_lo_lo_4 = cat(_I_WIRE_4[1], _I_WIRE_4[0]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_hi_4 = cat(_I_WIRE_4[3], _I_WIRE_4[2]) @[CLBlut4N10Clb.scala 35:92]
    node I_lo_4 = cat(I_lo_hi_4, I_lo_lo_4) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_lo_4 = cat(_I_WIRE_4[5], _I_WIRE_4[4]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_hi_4 = cat(_I_WIRE_4[7], _I_WIRE_4[6]) @[CLBlut4N10Clb.scala 35:92]
    node I_hi_4 = cat(I_hi_hi_4, I_hi_lo_4) @[CLBlut4N10Clb.scala 35:92]
    node I_4 = cat(I_hi_4, I_lo_4) @[CLBlut4N10Clb.scala 35:92]
    wire OClb : UInt<1>[16] @[CLBlut4N10Clb.scala 37:18]
    OPIN_40 <= OClb[0] @[CLBlut4N10Clb.scala 38:57]
    OPIN_41 <= OClb[1] @[CLBlut4N10Clb.scala 38:57]
    OPIN_42 <= OClb[2] @[CLBlut4N10Clb.scala 38:57]
    OPIN_43 <= OClb[3] @[CLBlut4N10Clb.scala 38:57]
    OPIN_44 <= OClb[4] @[CLBlut4N10Clb.scala 38:57]
    OPIN_45 <= OClb[5] @[CLBlut4N10Clb.scala 38:57]
    OPIN_46 <= OClb[6] @[CLBlut4N10Clb.scala 38:57]
    OPIN_47 <= OClb[7] @[CLBlut4N10Clb.scala 38:57]
    OPIN_48 <= OClb[8] @[CLBlut4N10Clb.scala 38:57]
    OPIN_49 <= OClb[9] @[CLBlut4N10Clb.scala 38:57]
    OPIN_50 <= OClb[10] @[CLBlut4N10Clb.scala 38:57]
    OPIN_51 <= OClb[11] @[CLBlut4N10Clb.scala 38:57]
    OPIN_52 <= OClb[12] @[CLBlut4N10Clb.scala 38:57]
    OPIN_53 <= OClb[13] @[CLBlut4N10Clb.scala 38:57]
    OPIN_54 <= OClb[14] @[CLBlut4N10Clb.scala 38:57]
    OPIN_55 <= OClb[15] @[CLBlut4N10Clb.scala 38:57]
    inst BLE_0 of Ble4 @[CLBlut4N10Clb.scala 45:48]
    BLE_0.clock <= clock
    BLE_0.reset <= reset
    inst BLE_1 of Ble4_1 @[CLBlut4N10Clb.scala 45:48]
    BLE_1.clock <= clock
    BLE_1.reset <= reset
    inst BLE_2 of Ble4_2 @[CLBlut4N10Clb.scala 45:48]
    BLE_2.clock <= clock
    BLE_2.reset <= reset
    inst BLE_3 of Ble4_3 @[CLBlut4N10Clb.scala 45:48]
    BLE_3.clock <= clock
    BLE_3.reset <= reset
    inst BLE_4 of Ble4_4 @[CLBlut4N10Clb.scala 45:48]
    BLE_4.clock <= clock
    BLE_4.reset <= reset
    inst BLE_5 of Ble4_5 @[CLBlut4N10Clb.scala 45:48]
    BLE_5.clock <= clock
    BLE_5.reset <= reset
    inst BLE_6 of Ble4_6 @[CLBlut4N10Clb.scala 45:48]
    BLE_6.clock <= clock
    BLE_6.reset <= reset
    inst BLE_7 of Ble4_7 @[CLBlut4N10Clb.scala 45:48]
    BLE_7.clock <= clock
    BLE_7.reset <= reset
    node _BLE_0_io_config_T = bits(configBits, 19, 0) @[CLBlut4N10Clb.scala 47:38]
    BLE_0.io.config <= _BLE_0_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_0_io_in_0_T = bits(I_0, 0, 0) @[CLBlut4N10Clb.scala 48:62]
    BLE_0.io.in[0] <= _BLE_0_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_0_io_in_1_T = bits(I_1, 0, 0) @[CLBlut4N10Clb.scala 48:62]
    BLE_0.io.in[1] <= _BLE_0_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_0_io_in_2_T = bits(I_2, 0, 0) @[CLBlut4N10Clb.scala 48:62]
    BLE_0.io.in[2] <= _BLE_0_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_0_io_in_3_T = bits(I_3, 0, 0) @[CLBlut4N10Clb.scala 48:62]
    BLE_0.io.in[3] <= _BLE_0_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[0] <= BLE_0.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[8] <= BLE_0.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_0.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_0_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_0.io.clkEnb <= _BLE_0_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_1_io_config_T = bits(configBits, 39, 20) @[CLBlut4N10Clb.scala 47:38]
    BLE_1.io.config <= _BLE_1_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_1_io_in_0_T = bits(I_0, 1, 1) @[CLBlut4N10Clb.scala 48:62]
    BLE_1.io.in[0] <= _BLE_1_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_1_io_in_1_T = bits(I_1, 1, 1) @[CLBlut4N10Clb.scala 48:62]
    BLE_1.io.in[1] <= _BLE_1_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_1_io_in_2_T = bits(I_2, 1, 1) @[CLBlut4N10Clb.scala 48:62]
    BLE_1.io.in[2] <= _BLE_1_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_1_io_in_3_T = bits(I_3, 1, 1) @[CLBlut4N10Clb.scala 48:62]
    BLE_1.io.in[3] <= _BLE_1_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[1] <= BLE_1.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[9] <= BLE_1.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_1.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_1_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_1.io.clkEnb <= _BLE_1_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_2_io_config_T = bits(configBits, 59, 40) @[CLBlut4N10Clb.scala 47:38]
    BLE_2.io.config <= _BLE_2_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_2_io_in_0_T = bits(I_0, 2, 2) @[CLBlut4N10Clb.scala 48:62]
    BLE_2.io.in[0] <= _BLE_2_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_2_io_in_1_T = bits(I_1, 2, 2) @[CLBlut4N10Clb.scala 48:62]
    BLE_2.io.in[1] <= _BLE_2_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_2_io_in_2_T = bits(I_2, 2, 2) @[CLBlut4N10Clb.scala 48:62]
    BLE_2.io.in[2] <= _BLE_2_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_2_io_in_3_T = bits(I_3, 2, 2) @[CLBlut4N10Clb.scala 48:62]
    BLE_2.io.in[3] <= _BLE_2_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[2] <= BLE_2.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[10] <= BLE_2.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_2.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_2_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_2.io.clkEnb <= _BLE_2_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_3_io_config_T = bits(configBits, 79, 60) @[CLBlut4N10Clb.scala 47:38]
    BLE_3.io.config <= _BLE_3_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_3_io_in_0_T = bits(I_0, 3, 3) @[CLBlut4N10Clb.scala 48:62]
    BLE_3.io.in[0] <= _BLE_3_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_3_io_in_1_T = bits(I_1, 3, 3) @[CLBlut4N10Clb.scala 48:62]
    BLE_3.io.in[1] <= _BLE_3_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_3_io_in_2_T = bits(I_2, 3, 3) @[CLBlut4N10Clb.scala 48:62]
    BLE_3.io.in[2] <= _BLE_3_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_3_io_in_3_T = bits(I_3, 3, 3) @[CLBlut4N10Clb.scala 48:62]
    BLE_3.io.in[3] <= _BLE_3_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[3] <= BLE_3.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[11] <= BLE_3.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_3.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_3_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_3.io.clkEnb <= _BLE_3_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_4_io_config_T = bits(configBits, 99, 80) @[CLBlut4N10Clb.scala 47:38]
    BLE_4.io.config <= _BLE_4_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_4_io_in_0_T = bits(I_0, 4, 4) @[CLBlut4N10Clb.scala 48:62]
    BLE_4.io.in[0] <= _BLE_4_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_4_io_in_1_T = bits(I_1, 4, 4) @[CLBlut4N10Clb.scala 48:62]
    BLE_4.io.in[1] <= _BLE_4_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_4_io_in_2_T = bits(I_2, 4, 4) @[CLBlut4N10Clb.scala 48:62]
    BLE_4.io.in[2] <= _BLE_4_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_4_io_in_3_T = bits(I_3, 4, 4) @[CLBlut4N10Clb.scala 48:62]
    BLE_4.io.in[3] <= _BLE_4_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[4] <= BLE_4.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[12] <= BLE_4.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_4.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_4_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_4.io.clkEnb <= _BLE_4_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_5_io_config_T = bits(configBits, 119, 100) @[CLBlut4N10Clb.scala 47:38]
    BLE_5.io.config <= _BLE_5_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_5_io_in_0_T = bits(I_0, 5, 5) @[CLBlut4N10Clb.scala 48:62]
    BLE_5.io.in[0] <= _BLE_5_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_5_io_in_1_T = bits(I_1, 5, 5) @[CLBlut4N10Clb.scala 48:62]
    BLE_5.io.in[1] <= _BLE_5_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_5_io_in_2_T = bits(I_2, 5, 5) @[CLBlut4N10Clb.scala 48:62]
    BLE_5.io.in[2] <= _BLE_5_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_5_io_in_3_T = bits(I_3, 5, 5) @[CLBlut4N10Clb.scala 48:62]
    BLE_5.io.in[3] <= _BLE_5_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[5] <= BLE_5.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[13] <= BLE_5.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_5.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_5_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_5.io.clkEnb <= _BLE_5_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_6_io_config_T = bits(configBits, 139, 120) @[CLBlut4N10Clb.scala 47:38]
    BLE_6.io.config <= _BLE_6_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_6_io_in_0_T = bits(I_0, 6, 6) @[CLBlut4N10Clb.scala 48:62]
    BLE_6.io.in[0] <= _BLE_6_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_6_io_in_1_T = bits(I_1, 6, 6) @[CLBlut4N10Clb.scala 48:62]
    BLE_6.io.in[1] <= _BLE_6_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_6_io_in_2_T = bits(I_2, 6, 6) @[CLBlut4N10Clb.scala 48:62]
    BLE_6.io.in[2] <= _BLE_6_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_6_io_in_3_T = bits(I_3, 6, 6) @[CLBlut4N10Clb.scala 48:62]
    BLE_6.io.in[3] <= _BLE_6_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[6] <= BLE_6.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[14] <= BLE_6.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_6.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_6_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_6.io.clkEnb <= _BLE_6_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]
    node _BLE_7_io_config_T = bits(configBits, 159, 140) @[CLBlut4N10Clb.scala 47:38]
    BLE_7.io.config <= _BLE_7_io_config_T @[CLBlut4N10Clb.scala 47:25]
    node _BLE_7_io_in_0_T = bits(I_0, 7, 7) @[CLBlut4N10Clb.scala 48:62]
    BLE_7.io.in[0] <= _BLE_7_io_in_0_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_7_io_in_1_T = bits(I_1, 7, 7) @[CLBlut4N10Clb.scala 48:62]
    BLE_7.io.in[1] <= _BLE_7_io_in_1_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_7_io_in_2_T = bits(I_2, 7, 7) @[CLBlut4N10Clb.scala 48:62]
    BLE_7.io.in[2] <= _BLE_7_io_in_2_T @[CLBlut4N10Clb.scala 48:53]
    node _BLE_7_io_in_3_T = bits(I_3, 7, 7) @[CLBlut4N10Clb.scala 48:62]
    BLE_7.io.in[3] <= _BLE_7_io_in_3_T @[CLBlut4N10Clb.scala 48:53]
    OClb[7] <= BLE_7.io.outR @[CLBlut4N10Clb.scala 49:15]
    OClb[15] <= BLE_7.io.outT @[CLBlut4N10Clb.scala 50:17]
    BLE_7.io.gndOuts <= gndLBouts @[CLBlut4N10Clb.scala 51:26]
    node _BLE_7_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Clb.scala 52:38]
    BLE_7.io.clkEnb <= _BLE_7_io_clkEnb_T @[CLBlut4N10Clb.scala 52:25]

