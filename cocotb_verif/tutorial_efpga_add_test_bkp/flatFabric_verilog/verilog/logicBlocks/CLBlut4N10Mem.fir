circuit CLBlut4N10Mem :
  extmodule Mux16C :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_1 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_1 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_2 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_2 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_3 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_3 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_4 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_4 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_5 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_5 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_6 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_6 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  extmodule Mux16C_7 :
    input in : UInt<16>
    input sel : UInt<4>
    output o : UInt<1>
    defname = Mux16C

  module Ble4_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip config : UInt<20>, flip in : UInt<1>[4], outR : UInt<1>, outT : UInt<1>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    inst lut of Mux16C_7 @[CLBlut4N10Clb.scala 75:27]
    lut.o is invalid
    lut.sel is invalid
    lut.in is invalid
    node _lut_io_in_T = bits(io.config, 15, 0) @[CLBlut4N10Clb.scala 76:25]
    lut.in <= _lut_io_in_T @[CLBlut4N10Clb.scala 76:13]
    node lut_io_sel_lo = cat(io.in[1], io.in[0]) @[CLBlut4N10Clb.scala 77:23]
    node lut_io_sel_hi = cat(io.in[3], io.in[2]) @[CLBlut4N10Clb.scala 77:23]
    node _lut_io_sel_T = cat(lut_io_sel_hi, lut_io_sel_lo) @[CLBlut4N10Clb.scala 77:23]
    lut.sel <= _lut_io_sel_T @[CLBlut4N10Clb.scala 77:14]
    node _bleFF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Clb.scala 79:48]
    reg bleFF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _bleFF_T : @[Reg.scala 29:18]
      bleFF <= lut.o @[Reg.scala 29:22]
    node _io_outR_T = bits(io.config, 16, 16) @[CLBlut4N10Clb.scala 82:27]
    node _io_outR_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:34]
    node _io_outR_T_2 = and(_io_outR_T, _io_outR_T_1) @[CLBlut4N10Clb.scala 82:32]
    node _io_outR_T_3 = mux(_io_outR_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 82:17]
    node _io_outR_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 82:68]
    node _io_outR_T_5 = and(_io_outR_T_3, _io_outR_T_4) @[CLBlut4N10Clb.scala 82:66]
    io.outR <= _io_outR_T_5 @[CLBlut4N10Clb.scala 82:11]
    node _io_outT_T = bits(io.config, 17, 17) @[CLBlut4N10Clb.scala 83:27]
    node _io_outT_T_1 = eq(io.loopBreak, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:34]
    node _io_outT_T_2 = and(_io_outT_T, _io_outT_T_1) @[CLBlut4N10Clb.scala 83:32]
    node _io_outT_T_3 = mux(_io_outT_T_2, lut.o, bleFF) @[CLBlut4N10Clb.scala 83:17]
    node _io_outT_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Clb.scala 83:68]
    node _io_outT_T_5 = and(_io_outT_T_3, _io_outT_T_4) @[CLBlut4N10Clb.scala 83:66]
    io.outT <= _io_outT_T_5 @[CLBlut4N10Clb.scala 83:11]

  module CLBlut4N10Mem :
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
    output OPIN_56 : UInt<1>
    input clock : Clock
    input reset : UInt<1>
    output ioPad : { flip i : UInt<16>, o : UInt<40>}
    input configBits : UInt<162>
    input loopBreak : UInt<1>
    input gndLBouts : UInt<1>

    wire _I_WIRE : UInt<1>[8] @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[0] <= IPIN_0 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[1] <= IPIN_1 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[2] <= IPIN_2 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[3] <= IPIN_3 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[4] <= IPIN_4 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[5] <= IPIN_5 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[6] <= IPIN_6 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE[7] <= IPIN_7 @[CLBlut4N10Mem.scala 35:82]
    node I_lo_lo = cat(_I_WIRE[1], _I_WIRE[0]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_hi = cat(_I_WIRE[3], _I_WIRE[2]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo = cat(I_lo_hi, I_lo_lo) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_lo = cat(_I_WIRE[5], _I_WIRE[4]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_hi = cat(_I_WIRE[7], _I_WIRE[6]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi = cat(I_hi_hi, I_hi_lo) @[CLBlut4N10Mem.scala 35:92]
    node I_0 = cat(I_hi, I_lo) @[CLBlut4N10Mem.scala 35:92]
    wire _I_WIRE_1 : UInt<1>[8] @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[0] <= IPIN_8 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[1] <= IPIN_9 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[2] <= IPIN_10 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[3] <= IPIN_11 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[4] <= IPIN_12 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[5] <= IPIN_13 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[6] <= IPIN_14 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_1[7] <= IPIN_15 @[CLBlut4N10Mem.scala 35:82]
    node I_lo_lo_1 = cat(_I_WIRE_1[1], _I_WIRE_1[0]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_hi_1 = cat(_I_WIRE_1[3], _I_WIRE_1[2]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_1 = cat(I_lo_hi_1, I_lo_lo_1) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_lo_1 = cat(_I_WIRE_1[5], _I_WIRE_1[4]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_hi_1 = cat(_I_WIRE_1[7], _I_WIRE_1[6]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_1 = cat(I_hi_hi_1, I_hi_lo_1) @[CLBlut4N10Mem.scala 35:92]
    node I_1 = cat(I_hi_1, I_lo_1) @[CLBlut4N10Mem.scala 35:92]
    wire _I_WIRE_2 : UInt<1>[8] @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[0] <= IPIN_16 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[1] <= IPIN_17 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[2] <= IPIN_18 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[3] <= IPIN_19 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[4] <= IPIN_20 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[5] <= IPIN_21 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[6] <= IPIN_22 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_2[7] <= IPIN_23 @[CLBlut4N10Mem.scala 35:82]
    node I_lo_lo_2 = cat(_I_WIRE_2[1], _I_WIRE_2[0]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_hi_2 = cat(_I_WIRE_2[3], _I_WIRE_2[2]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_2 = cat(I_lo_hi_2, I_lo_lo_2) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_lo_2 = cat(_I_WIRE_2[5], _I_WIRE_2[4]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_hi_2 = cat(_I_WIRE_2[7], _I_WIRE_2[6]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_2 = cat(I_hi_hi_2, I_hi_lo_2) @[CLBlut4N10Mem.scala 35:92]
    node I_2 = cat(I_hi_2, I_lo_2) @[CLBlut4N10Mem.scala 35:92]
    wire _I_WIRE_3 : UInt<1>[8] @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[0] <= IPIN_24 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[1] <= IPIN_25 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[2] <= IPIN_26 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[3] <= IPIN_27 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[4] <= IPIN_28 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[5] <= IPIN_29 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[6] <= IPIN_30 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_3[7] <= IPIN_31 @[CLBlut4N10Mem.scala 35:82]
    node I_lo_lo_3 = cat(_I_WIRE_3[1], _I_WIRE_3[0]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_hi_3 = cat(_I_WIRE_3[3], _I_WIRE_3[2]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_3 = cat(I_lo_hi_3, I_lo_lo_3) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_lo_3 = cat(_I_WIRE_3[5], _I_WIRE_3[4]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_hi_3 = cat(_I_WIRE_3[7], _I_WIRE_3[6]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_3 = cat(I_hi_hi_3, I_hi_lo_3) @[CLBlut4N10Mem.scala 35:92]
    node I_3 = cat(I_hi_3, I_lo_3) @[CLBlut4N10Mem.scala 35:92]
    wire _I_WIRE_4 : UInt<1>[8] @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[0] <= IPIN_32 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[1] <= IPIN_33 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[2] <= IPIN_34 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[3] <= IPIN_35 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[4] <= IPIN_36 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[5] <= IPIN_37 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[6] <= IPIN_38 @[CLBlut4N10Mem.scala 35:82]
    _I_WIRE_4[7] <= IPIN_39 @[CLBlut4N10Mem.scala 35:82]
    node I_lo_lo_4 = cat(_I_WIRE_4[1], _I_WIRE_4[0]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_hi_4 = cat(_I_WIRE_4[3], _I_WIRE_4[2]) @[CLBlut4N10Mem.scala 35:92]
    node I_lo_4 = cat(I_lo_hi_4, I_lo_lo_4) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_lo_4 = cat(_I_WIRE_4[5], _I_WIRE_4[4]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_hi_4 = cat(_I_WIRE_4[7], _I_WIRE_4[6]) @[CLBlut4N10Mem.scala 35:92]
    node I_hi_4 = cat(I_hi_hi_4, I_hi_lo_4) @[CLBlut4N10Mem.scala 35:92]
    node I_4 = cat(I_hi_4, I_lo_4) @[CLBlut4N10Mem.scala 35:92]
    wire OMem : UInt<1>[16] @[CLBlut4N10Mem.scala 37:18]
    wire OClb : UInt<1>[16] @[CLBlut4N10Mem.scala 38:18]
    node _OPIN_41_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_41_T_1 = mux(_OPIN_41_T, OMem[0], OClb[0]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_41 <= _OPIN_41_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_42_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_42_T_1 = mux(_OPIN_42_T, OMem[1], OClb[1]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_42 <= _OPIN_42_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_43_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_43_T_1 = mux(_OPIN_43_T, OMem[2], OClb[2]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_43 <= _OPIN_43_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_44_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_44_T_1 = mux(_OPIN_44_T, OMem[3], OClb[3]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_44 <= _OPIN_44_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_45_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_45_T_1 = mux(_OPIN_45_T, OMem[4], OClb[4]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_45 <= _OPIN_45_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_46_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_46_T_1 = mux(_OPIN_46_T, OMem[5], OClb[5]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_46 <= _OPIN_46_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_47_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_47_T_1 = mux(_OPIN_47_T, OMem[6], OClb[6]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_47 <= _OPIN_47_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_48_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_48_T_1 = mux(_OPIN_48_T, OMem[7], OClb[7]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_48 <= _OPIN_48_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_49_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_49_T_1 = mux(_OPIN_49_T, OMem[8], OClb[8]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_49 <= _OPIN_49_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_50_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_50_T_1 = mux(_OPIN_50_T, OMem[9], OClb[9]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_50 <= _OPIN_50_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_51_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_51_T_1 = mux(_OPIN_51_T, OMem[10], OClb[10]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_51 <= _OPIN_51_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_52_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_52_T_1 = mux(_OPIN_52_T, OMem[11], OClb[11]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_52 <= _OPIN_52_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_53_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_53_T_1 = mux(_OPIN_53_T, OMem[12], OClb[12]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_53 <= _OPIN_53_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_54_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_54_T_1 = mux(_OPIN_54_T, OMem[13], OClb[13]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_54 <= _OPIN_54_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_55_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_55_T_1 = mux(_OPIN_55_T, OMem[14], OClb[14]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_55 <= _OPIN_55_T_1 @[CLBlut4N10Mem.scala 40:9]
    node _OPIN_56_T = bits(configBits, 160, 160) @[CLBlut4N10Mem.scala 40:26]
    node _OPIN_56_T_1 = mux(_OPIN_56_T, OMem[15], OClb[15]) @[CLBlut4N10Mem.scala 40:15]
    OPIN_56 <= _OPIN_56_T_1 @[CLBlut4N10Mem.scala 40:9]
    node braminFF_lo_lo_lo_lo = cat(IPIN_1, IPIN_0) @[Cat.scala 31:58]
    node braminFF_lo_lo_lo_hi_hi = cat(IPIN_4, IPIN_3) @[Cat.scala 31:58]
    node braminFF_lo_lo_lo_hi = cat(braminFF_lo_lo_lo_hi_hi, IPIN_2) @[Cat.scala 31:58]
    node braminFF_lo_lo_lo = cat(braminFF_lo_lo_lo_hi, braminFF_lo_lo_lo_lo) @[Cat.scala 31:58]
    node braminFF_lo_lo_hi_lo = cat(IPIN_6, IPIN_5) @[Cat.scala 31:58]
    node braminFF_lo_lo_hi_hi_hi = cat(IPIN_9, IPIN_8) @[Cat.scala 31:58]
    node braminFF_lo_lo_hi_hi = cat(braminFF_lo_lo_hi_hi_hi, IPIN_7) @[Cat.scala 31:58]
    node braminFF_lo_lo_hi = cat(braminFF_lo_lo_hi_hi, braminFF_lo_lo_hi_lo) @[Cat.scala 31:58]
    node braminFF_lo_lo = cat(braminFF_lo_lo_hi, braminFF_lo_lo_lo) @[Cat.scala 31:58]
    node braminFF_lo_hi_lo_lo = cat(IPIN_11, IPIN_10) @[Cat.scala 31:58]
    node braminFF_lo_hi_lo_hi_hi = cat(IPIN_14, IPIN_13) @[Cat.scala 31:58]
    node braminFF_lo_hi_lo_hi = cat(braminFF_lo_hi_lo_hi_hi, IPIN_12) @[Cat.scala 31:58]
    node braminFF_lo_hi_lo = cat(braminFF_lo_hi_lo_hi, braminFF_lo_hi_lo_lo) @[Cat.scala 31:58]
    node braminFF_lo_hi_hi_lo = cat(IPIN_16, IPIN_15) @[Cat.scala 31:58]
    node braminFF_lo_hi_hi_hi_hi = cat(IPIN_19, IPIN_18) @[Cat.scala 31:58]
    node braminFF_lo_hi_hi_hi = cat(braminFF_lo_hi_hi_hi_hi, IPIN_17) @[Cat.scala 31:58]
    node braminFF_lo_hi_hi = cat(braminFF_lo_hi_hi_hi, braminFF_lo_hi_hi_lo) @[Cat.scala 31:58]
    node braminFF_lo_hi = cat(braminFF_lo_hi_hi, braminFF_lo_hi_lo) @[Cat.scala 31:58]
    node braminFF_lo = cat(braminFF_lo_hi, braminFF_lo_lo) @[Cat.scala 31:58]
    node braminFF_hi_lo_lo_lo = cat(IPIN_21, IPIN_20) @[Cat.scala 31:58]
    node braminFF_hi_lo_lo_hi_hi = cat(IPIN_24, IPIN_23) @[Cat.scala 31:58]
    node braminFF_hi_lo_lo_hi = cat(braminFF_hi_lo_lo_hi_hi, IPIN_22) @[Cat.scala 31:58]
    node braminFF_hi_lo_lo = cat(braminFF_hi_lo_lo_hi, braminFF_hi_lo_lo_lo) @[Cat.scala 31:58]
    node braminFF_hi_lo_hi_lo = cat(IPIN_26, IPIN_25) @[Cat.scala 31:58]
    node braminFF_hi_lo_hi_hi_hi = cat(IPIN_29, IPIN_28) @[Cat.scala 31:58]
    node braminFF_hi_lo_hi_hi = cat(braminFF_hi_lo_hi_hi_hi, IPIN_27) @[Cat.scala 31:58]
    node braminFF_hi_lo_hi = cat(braminFF_hi_lo_hi_hi, braminFF_hi_lo_hi_lo) @[Cat.scala 31:58]
    node braminFF_hi_lo = cat(braminFF_hi_lo_hi, braminFF_hi_lo_lo) @[Cat.scala 31:58]
    node braminFF_hi_hi_lo_lo = cat(IPIN_31, IPIN_30) @[Cat.scala 31:58]
    node braminFF_hi_hi_lo_hi_hi = cat(IPIN_34, IPIN_33) @[Cat.scala 31:58]
    node braminFF_hi_hi_lo_hi = cat(braminFF_hi_hi_lo_hi_hi, IPIN_32) @[Cat.scala 31:58]
    node braminFF_hi_hi_lo = cat(braminFF_hi_hi_lo_hi, braminFF_hi_hi_lo_lo) @[Cat.scala 31:58]
    node braminFF_hi_hi_hi_lo = cat(IPIN_36, IPIN_35) @[Cat.scala 31:58]
    node braminFF_hi_hi_hi_hi_hi = cat(IPIN_39, IPIN_38) @[Cat.scala 31:58]
    node braminFF_hi_hi_hi_hi = cat(braminFF_hi_hi_hi_hi_hi, IPIN_37) @[Cat.scala 31:58]
    node braminFF_hi_hi_hi = cat(braminFF_hi_hi_hi_hi, braminFF_hi_hi_hi_lo) @[Cat.scala 31:58]
    node braminFF_hi_hi = cat(braminFF_hi_hi_hi, braminFF_hi_hi_lo) @[Cat.scala 31:58]
    node braminFF_hi = cat(braminFF_hi_hi, braminFF_hi_lo) @[Cat.scala 31:58]
    node _braminFF_T = cat(braminFF_hi, braminFF_lo) @[Cat.scala 31:58]
    reg braminFF : UInt, clock with :
      reset => (UInt<1>("h0"), braminFF) @[CLBlut4N10Mem.scala 45:42]
    braminFF <= _braminFF_T @[CLBlut4N10Mem.scala 45:42]
    node _ioPad_o_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 46:32]
    node ioPad_o_lo_lo_lo_lo = cat(IPIN_1, IPIN_0) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_lo_hi_hi = cat(IPIN_4, IPIN_3) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_lo_hi = cat(ioPad_o_lo_lo_lo_hi_hi, IPIN_2) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_lo = cat(ioPad_o_lo_lo_lo_hi, ioPad_o_lo_lo_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_hi_lo = cat(IPIN_6, IPIN_5) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_hi_hi_hi = cat(IPIN_9, IPIN_8) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_hi_hi = cat(ioPad_o_lo_lo_hi_hi_hi, IPIN_7) @[Cat.scala 31:58]
    node ioPad_o_lo_lo_hi = cat(ioPad_o_lo_lo_hi_hi, ioPad_o_lo_lo_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_lo_lo = cat(ioPad_o_lo_lo_hi, ioPad_o_lo_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_lo_lo = cat(IPIN_11, IPIN_10) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_lo_hi_hi = cat(IPIN_14, IPIN_13) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_lo_hi = cat(ioPad_o_lo_hi_lo_hi_hi, IPIN_12) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_lo = cat(ioPad_o_lo_hi_lo_hi, ioPad_o_lo_hi_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_hi_lo = cat(IPIN_16, IPIN_15) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_hi_hi_hi = cat(IPIN_19, IPIN_18) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_hi_hi = cat(ioPad_o_lo_hi_hi_hi_hi, IPIN_17) @[Cat.scala 31:58]
    node ioPad_o_lo_hi_hi = cat(ioPad_o_lo_hi_hi_hi, ioPad_o_lo_hi_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_lo_hi = cat(ioPad_o_lo_hi_hi, ioPad_o_lo_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_lo = cat(ioPad_o_lo_hi, ioPad_o_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_lo_lo = cat(IPIN_21, IPIN_20) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_lo_hi_hi = cat(IPIN_24, IPIN_23) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_lo_hi = cat(ioPad_o_hi_lo_lo_hi_hi, IPIN_22) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_lo = cat(ioPad_o_hi_lo_lo_hi, ioPad_o_hi_lo_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_hi_lo = cat(IPIN_26, IPIN_25) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_hi_hi_hi = cat(IPIN_29, IPIN_28) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_hi_hi = cat(ioPad_o_hi_lo_hi_hi_hi, IPIN_27) @[Cat.scala 31:58]
    node ioPad_o_hi_lo_hi = cat(ioPad_o_hi_lo_hi_hi, ioPad_o_hi_lo_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_lo = cat(ioPad_o_hi_lo_hi, ioPad_o_hi_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_lo_lo = cat(IPIN_31, IPIN_30) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_lo_hi_hi = cat(IPIN_34, IPIN_33) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_lo_hi = cat(ioPad_o_hi_hi_lo_hi_hi, IPIN_32) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_lo = cat(ioPad_o_hi_hi_lo_hi, ioPad_o_hi_hi_lo_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_hi_lo = cat(IPIN_36, IPIN_35) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_hi_hi_hi = cat(IPIN_39, IPIN_38) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_hi_hi = cat(ioPad_o_hi_hi_hi_hi_hi, IPIN_37) @[Cat.scala 31:58]
    node ioPad_o_hi_hi_hi = cat(ioPad_o_hi_hi_hi_hi, ioPad_o_hi_hi_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_hi_hi = cat(ioPad_o_hi_hi_hi, ioPad_o_hi_hi_lo) @[Cat.scala 31:58]
    node ioPad_o_hi = cat(ioPad_o_hi_hi, ioPad_o_hi_lo) @[Cat.scala 31:58]
    node _ioPad_o_T_1 = cat(ioPad_o_hi, ioPad_o_lo) @[Cat.scala 31:58]
    node _ioPad_o_T_2 = mux(_ioPad_o_T, _ioPad_o_T_1, braminFF) @[CLBlut4N10Mem.scala 46:21]
    ioPad.o <= _ioPad_o_T_2 @[CLBlut4N10Mem.scala 46:15]
    node _OMem_0_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_0_T_1 = bits(ioPad.i, 0, 0) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_0_T_2 = bits(ioPad.i, 0, 0) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_0_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_0_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_0_bramoutFF <= _OMem_0_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_0_T_3 = mux(_OMem_0_T, _OMem_0_T_1, OMem_0_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[0] <= _OMem_0_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_1_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_1_T_1 = bits(ioPad.i, 1, 1) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_1_T_2 = bits(ioPad.i, 1, 1) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_1_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_1_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_1_bramoutFF <= _OMem_1_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_1_T_3 = mux(_OMem_1_T, _OMem_1_T_1, OMem_1_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[1] <= _OMem_1_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_2_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_2_T_1 = bits(ioPad.i, 2, 2) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_2_T_2 = bits(ioPad.i, 2, 2) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_2_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_2_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_2_bramoutFF <= _OMem_2_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_2_T_3 = mux(_OMem_2_T, _OMem_2_T_1, OMem_2_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[2] <= _OMem_2_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_3_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_3_T_1 = bits(ioPad.i, 3, 3) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_3_T_2 = bits(ioPad.i, 3, 3) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_3_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_3_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_3_bramoutFF <= _OMem_3_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_3_T_3 = mux(_OMem_3_T, _OMem_3_T_1, OMem_3_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[3] <= _OMem_3_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_4_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_4_T_1 = bits(ioPad.i, 4, 4) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_4_T_2 = bits(ioPad.i, 4, 4) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_4_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_4_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_4_bramoutFF <= _OMem_4_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_4_T_3 = mux(_OMem_4_T, _OMem_4_T_1, OMem_4_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[4] <= _OMem_4_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_5_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_5_T_1 = bits(ioPad.i, 5, 5) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_5_T_2 = bits(ioPad.i, 5, 5) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_5_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_5_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_5_bramoutFF <= _OMem_5_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_5_T_3 = mux(_OMem_5_T, _OMem_5_T_1, OMem_5_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[5] <= _OMem_5_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_6_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_6_T_1 = bits(ioPad.i, 6, 6) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_6_T_2 = bits(ioPad.i, 6, 6) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_6_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_6_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_6_bramoutFF <= _OMem_6_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_6_T_3 = mux(_OMem_6_T, _OMem_6_T_1, OMem_6_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[6] <= _OMem_6_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_7_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_7_T_1 = bits(ioPad.i, 7, 7) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_7_T_2 = bits(ioPad.i, 7, 7) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_7_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_7_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_7_bramoutFF <= _OMem_7_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_7_T_3 = mux(_OMem_7_T, _OMem_7_T_1, OMem_7_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[7] <= _OMem_7_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_8_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_8_T_1 = bits(ioPad.i, 8, 8) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_8_T_2 = bits(ioPad.i, 8, 8) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_8_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_8_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_8_bramoutFF <= _OMem_8_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_8_T_3 = mux(_OMem_8_T, _OMem_8_T_1, OMem_8_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[8] <= _OMem_8_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_9_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_9_T_1 = bits(ioPad.i, 9, 9) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_9_T_2 = bits(ioPad.i, 9, 9) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_9_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_9_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_9_bramoutFF <= _OMem_9_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_9_T_3 = mux(_OMem_9_T, _OMem_9_T_1, OMem_9_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[9] <= _OMem_9_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_10_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_10_T_1 = bits(ioPad.i, 10, 10) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_10_T_2 = bits(ioPad.i, 10, 10) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_10_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_10_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_10_bramoutFF <= _OMem_10_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_10_T_3 = mux(_OMem_10_T, _OMem_10_T_1, OMem_10_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[10] <= _OMem_10_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_11_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_11_T_1 = bits(ioPad.i, 11, 11) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_11_T_2 = bits(ioPad.i, 11, 11) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_11_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_11_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_11_bramoutFF <= _OMem_11_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_11_T_3 = mux(_OMem_11_T, _OMem_11_T_1, OMem_11_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[11] <= _OMem_11_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_12_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_12_T_1 = bits(ioPad.i, 12, 12) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_12_T_2 = bits(ioPad.i, 12, 12) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_12_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_12_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_12_bramoutFF <= _OMem_12_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_12_T_3 = mux(_OMem_12_T, _OMem_12_T_1, OMem_12_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[12] <= _OMem_12_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_13_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_13_T_1 = bits(ioPad.i, 13, 13) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_13_T_2 = bits(ioPad.i, 13, 13) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_13_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_13_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_13_bramoutFF <= _OMem_13_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_13_T_3 = mux(_OMem_13_T, _OMem_13_T_1, OMem_13_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[13] <= _OMem_13_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_14_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_14_T_1 = bits(ioPad.i, 14, 14) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_14_T_2 = bits(ioPad.i, 14, 14) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_14_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_14_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_14_bramoutFF <= _OMem_14_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_14_T_3 = mux(_OMem_14_T, _OMem_14_T_1, OMem_14_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[14] <= _OMem_14_T_3 @[CLBlut4N10Mem.scala 48:51]
    node _OMem_15_T = bits(configBits, 19, 19) @[CLBlut4N10Mem.scala 48:68]
    node _OMem_15_T_1 = bits(ioPad.i, 15, 15) @[CLBlut4N10Mem.scala 48:85]
    node _OMem_15_T_2 = bits(ioPad.i, 15, 15) @[CLBlut4N10Mem.scala 48:128]
    reg OMem_15_bramoutFF : UInt<1>, clock with :
      reset => (UInt<1>("h0"), OMem_15_bramoutFF) @[CLBlut4N10Mem.scala 48:116]
    OMem_15_bramoutFF <= _OMem_15_T_2 @[CLBlut4N10Mem.scala 48:116]
    node _OMem_15_T_3 = mux(_OMem_15_T, _OMem_15_T_1, OMem_15_bramoutFF) @[CLBlut4N10Mem.scala 48:57]
    OMem[15] <= _OMem_15_T_3 @[CLBlut4N10Mem.scala 48:51]
    inst BLE_0 of Ble4 @[CLBlut4N10Mem.scala 55:48]
    BLE_0.clock <= clock
    BLE_0.reset <= reset
    inst BLE_1 of Ble4_1 @[CLBlut4N10Mem.scala 55:48]
    BLE_1.clock <= clock
    BLE_1.reset <= reset
    inst BLE_2 of Ble4_2 @[CLBlut4N10Mem.scala 55:48]
    BLE_2.clock <= clock
    BLE_2.reset <= reset
    inst BLE_3 of Ble4_3 @[CLBlut4N10Mem.scala 55:48]
    BLE_3.clock <= clock
    BLE_3.reset <= reset
    inst BLE_4 of Ble4_4 @[CLBlut4N10Mem.scala 55:48]
    BLE_4.clock <= clock
    BLE_4.reset <= reset
    inst BLE_5 of Ble4_5 @[CLBlut4N10Mem.scala 55:48]
    BLE_5.clock <= clock
    BLE_5.reset <= reset
    inst BLE_6 of Ble4_6 @[CLBlut4N10Mem.scala 55:48]
    BLE_6.clock <= clock
    BLE_6.reset <= reset
    inst BLE_7 of Ble4_7 @[CLBlut4N10Mem.scala 55:48]
    BLE_7.clock <= clock
    BLE_7.reset <= reset
    node _BLE_0_io_config_T = bits(configBits, 19, 0) @[CLBlut4N10Mem.scala 57:38]
    BLE_0.io.config <= _BLE_0_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_0_io_in_0_T = bits(I_0, 0, 0) @[CLBlut4N10Mem.scala 58:62]
    BLE_0.io.in[0] <= _BLE_0_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_0_io_in_1_T = bits(I_1, 0, 0) @[CLBlut4N10Mem.scala 58:62]
    BLE_0.io.in[1] <= _BLE_0_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_0_io_in_2_T = bits(I_2, 0, 0) @[CLBlut4N10Mem.scala 58:62]
    BLE_0.io.in[2] <= _BLE_0_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_0_io_in_3_T = bits(I_3, 0, 0) @[CLBlut4N10Mem.scala 58:62]
    BLE_0.io.in[3] <= _BLE_0_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[0] <= BLE_0.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[8] <= BLE_0.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_0.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_0_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_0.io.clkEnb <= _BLE_0_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_0.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_1_io_config_T = bits(configBits, 39, 20) @[CLBlut4N10Mem.scala 57:38]
    BLE_1.io.config <= _BLE_1_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_1_io_in_0_T = bits(I_0, 1, 1) @[CLBlut4N10Mem.scala 58:62]
    BLE_1.io.in[0] <= _BLE_1_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_1_io_in_1_T = bits(I_1, 1, 1) @[CLBlut4N10Mem.scala 58:62]
    BLE_1.io.in[1] <= _BLE_1_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_1_io_in_2_T = bits(I_2, 1, 1) @[CLBlut4N10Mem.scala 58:62]
    BLE_1.io.in[2] <= _BLE_1_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_1_io_in_3_T = bits(I_3, 1, 1) @[CLBlut4N10Mem.scala 58:62]
    BLE_1.io.in[3] <= _BLE_1_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[1] <= BLE_1.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[9] <= BLE_1.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_1.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_1_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_1.io.clkEnb <= _BLE_1_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_1.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_2_io_config_T = bits(configBits, 59, 40) @[CLBlut4N10Mem.scala 57:38]
    BLE_2.io.config <= _BLE_2_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_2_io_in_0_T = bits(I_0, 2, 2) @[CLBlut4N10Mem.scala 58:62]
    BLE_2.io.in[0] <= _BLE_2_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_2_io_in_1_T = bits(I_1, 2, 2) @[CLBlut4N10Mem.scala 58:62]
    BLE_2.io.in[1] <= _BLE_2_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_2_io_in_2_T = bits(I_2, 2, 2) @[CLBlut4N10Mem.scala 58:62]
    BLE_2.io.in[2] <= _BLE_2_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_2_io_in_3_T = bits(I_3, 2, 2) @[CLBlut4N10Mem.scala 58:62]
    BLE_2.io.in[3] <= _BLE_2_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[2] <= BLE_2.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[10] <= BLE_2.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_2.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_2_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_2.io.clkEnb <= _BLE_2_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_2.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_3_io_config_T = bits(configBits, 79, 60) @[CLBlut4N10Mem.scala 57:38]
    BLE_3.io.config <= _BLE_3_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_3_io_in_0_T = bits(I_0, 3, 3) @[CLBlut4N10Mem.scala 58:62]
    BLE_3.io.in[0] <= _BLE_3_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_3_io_in_1_T = bits(I_1, 3, 3) @[CLBlut4N10Mem.scala 58:62]
    BLE_3.io.in[1] <= _BLE_3_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_3_io_in_2_T = bits(I_2, 3, 3) @[CLBlut4N10Mem.scala 58:62]
    BLE_3.io.in[2] <= _BLE_3_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_3_io_in_3_T = bits(I_3, 3, 3) @[CLBlut4N10Mem.scala 58:62]
    BLE_3.io.in[3] <= _BLE_3_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[3] <= BLE_3.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[11] <= BLE_3.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_3.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_3_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_3.io.clkEnb <= _BLE_3_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_3.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_4_io_config_T = bits(configBits, 99, 80) @[CLBlut4N10Mem.scala 57:38]
    BLE_4.io.config <= _BLE_4_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_4_io_in_0_T = bits(I_0, 4, 4) @[CLBlut4N10Mem.scala 58:62]
    BLE_4.io.in[0] <= _BLE_4_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_4_io_in_1_T = bits(I_1, 4, 4) @[CLBlut4N10Mem.scala 58:62]
    BLE_4.io.in[1] <= _BLE_4_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_4_io_in_2_T = bits(I_2, 4, 4) @[CLBlut4N10Mem.scala 58:62]
    BLE_4.io.in[2] <= _BLE_4_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_4_io_in_3_T = bits(I_3, 4, 4) @[CLBlut4N10Mem.scala 58:62]
    BLE_4.io.in[3] <= _BLE_4_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[4] <= BLE_4.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[12] <= BLE_4.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_4.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_4_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_4.io.clkEnb <= _BLE_4_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_4.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_5_io_config_T = bits(configBits, 119, 100) @[CLBlut4N10Mem.scala 57:38]
    BLE_5.io.config <= _BLE_5_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_5_io_in_0_T = bits(I_0, 5, 5) @[CLBlut4N10Mem.scala 58:62]
    BLE_5.io.in[0] <= _BLE_5_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_5_io_in_1_T = bits(I_1, 5, 5) @[CLBlut4N10Mem.scala 58:62]
    BLE_5.io.in[1] <= _BLE_5_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_5_io_in_2_T = bits(I_2, 5, 5) @[CLBlut4N10Mem.scala 58:62]
    BLE_5.io.in[2] <= _BLE_5_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_5_io_in_3_T = bits(I_3, 5, 5) @[CLBlut4N10Mem.scala 58:62]
    BLE_5.io.in[3] <= _BLE_5_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[5] <= BLE_5.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[13] <= BLE_5.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_5.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_5_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_5.io.clkEnb <= _BLE_5_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_5.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_6_io_config_T = bits(configBits, 139, 120) @[CLBlut4N10Mem.scala 57:38]
    BLE_6.io.config <= _BLE_6_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_6_io_in_0_T = bits(I_0, 6, 6) @[CLBlut4N10Mem.scala 58:62]
    BLE_6.io.in[0] <= _BLE_6_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_6_io_in_1_T = bits(I_1, 6, 6) @[CLBlut4N10Mem.scala 58:62]
    BLE_6.io.in[1] <= _BLE_6_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_6_io_in_2_T = bits(I_2, 6, 6) @[CLBlut4N10Mem.scala 58:62]
    BLE_6.io.in[2] <= _BLE_6_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_6_io_in_3_T = bits(I_3, 6, 6) @[CLBlut4N10Mem.scala 58:62]
    BLE_6.io.in[3] <= _BLE_6_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[6] <= BLE_6.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[14] <= BLE_6.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_6.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_6_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_6.io.clkEnb <= _BLE_6_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_6.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]
    node _BLE_7_io_config_T = bits(configBits, 159, 140) @[CLBlut4N10Mem.scala 57:38]
    BLE_7.io.config <= _BLE_7_io_config_T @[CLBlut4N10Mem.scala 57:25]
    node _BLE_7_io_in_0_T = bits(I_0, 7, 7) @[CLBlut4N10Mem.scala 58:62]
    BLE_7.io.in[0] <= _BLE_7_io_in_0_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_7_io_in_1_T = bits(I_1, 7, 7) @[CLBlut4N10Mem.scala 58:62]
    BLE_7.io.in[1] <= _BLE_7_io_in_1_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_7_io_in_2_T = bits(I_2, 7, 7) @[CLBlut4N10Mem.scala 58:62]
    BLE_7.io.in[2] <= _BLE_7_io_in_2_T @[CLBlut4N10Mem.scala 58:53]
    node _BLE_7_io_in_3_T = bits(I_3, 7, 7) @[CLBlut4N10Mem.scala 58:62]
    BLE_7.io.in[3] <= _BLE_7_io_in_3_T @[CLBlut4N10Mem.scala 58:53]
    OClb[7] <= BLE_7.io.outR @[CLBlut4N10Mem.scala 59:15]
    OClb[15] <= BLE_7.io.outT @[CLBlut4N10Mem.scala 60:17]
    BLE_7.io.gndOuts <= gndLBouts @[CLBlut4N10Mem.scala 61:26]
    node _BLE_7_io_clkEnb_T = bits(configBits, 161, 161) @[CLBlut4N10Mem.scala 62:38]
    BLE_7.io.clkEnb <= _BLE_7_io_clkEnb_T @[CLBlut4N10Mem.scala 62:25]
    BLE_7.io.loopBreak <= loopBreak @[CLBlut4N10Mem.scala 63:28]

