circuit Alu :
  module Alu :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i0 : UInt<16>, flip i1 : UInt<16>, flip ib32 : UInt<32>, flip ctrl : UInt<8>, q : UInt<16>, ob32 : UInt<32>, flip config : UInt<32>, flip gndOuts : UInt<1>, flip clkEnb : UInt<1>, flip loopBreak : UInt<1>}

    node _i0FF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Alu.scala 100:44]
    reg i0FF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _i0FF_T : @[Reg.scala 29:18]
      i0FF <= io.i0 @[Reg.scala 29:22]
    node _i1FF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Alu.scala 101:36]
    reg i1FF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _i1FF_T : @[Reg.scala 29:18]
      i1FF <= io.i1 @[Reg.scala 29:22]
    node _ib32FF_T = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Alu.scala 102:40]
    reg ib32FF : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _ib32FF_T : @[Reg.scala 29:18]
      ib32FF <= io.ib32 @[Reg.scala 29:22]
    node _in0_T = bits(io.config, 0, 0) @[CLBlut4N10Alu.scala 104:26]
    node _in0_T_1 = mux(_in0_T, io.i0, i0FF) @[CLBlut4N10Alu.scala 104:16]
    node in0 = asSInt(_in0_T_1) @[CLBlut4N10Alu.scala 104:44]
    node _in1_T = bits(io.config, 1, 1) @[CLBlut4N10Alu.scala 105:26]
    node _in1_T_1 = mux(_in1_T, io.i1, i1FF) @[CLBlut4N10Alu.scala 105:16]
    node in1 = asSInt(_in1_T_1) @[CLBlut4N10Alu.scala 105:44]
    node _ib32_T = bits(io.config, 2, 2) @[CLBlut4N10Alu.scala 106:27]
    node _ib32_T_1 = mux(_ib32_T, io.ib32, ib32FF) @[CLBlut4N10Alu.scala 106:17]
    node ib32 = asSInt(_ib32_T_1) @[CLBlut4N10Alu.scala 106:49]
    node _acc_T = add(in0, in1) @[CLBlut4N10Alu.scala 108:17]
    node _acc_T_1 = tail(_acc_T, 1) @[CLBlut4N10Alu.scala 108:17]
    node _acc_T_2 = asSInt(_acc_T_1) @[CLBlut4N10Alu.scala 108:17]
    node _acc_T_3 = add(_acc_T_2, ib32) @[CLBlut4N10Alu.scala 108:23]
    node _acc_T_4 = tail(_acc_T_3, 1) @[CLBlut4N10Alu.scala 108:23]
    node acc = asSInt(_acc_T_4) @[CLBlut4N10Alu.scala 108:23]
    wire mul8 : SInt<32> @[CLBlut4N10Alu.scala 109:18]
    node _mul8_T = bits(in0, 8, 0) @[CLBlut4N10Alu.scala 110:14]
    node _mul8_T_1 = asSInt(_mul8_T) @[CLBlut4N10Alu.scala 110:20]
    node _mul8_T_2 = bits(in1, 8, 0) @[CLBlut4N10Alu.scala 110:32]
    node _mul8_T_3 = asSInt(_mul8_T_2) @[CLBlut4N10Alu.scala 110:38]
    node _mul8_T_4 = mul(_mul8_T_1, _mul8_T_3) @[CLBlut4N10Alu.scala 110:27]
    mul8 <= _mul8_T_4 @[CLBlut4N10Alu.scala 110:8]
    node _mux_T = bits(io.ctrl, 3, 3) @[CLBlut4N10Alu.scala 111:44]
    node _mux_T_1 = mux(_mux_T, in1, in0) @[CLBlut4N10Alu.scala 111:36]
    node mux_lo = asUInt(_mux_T_1) @[Cat.scala 31:58]
    node mux_hi = asUInt(asSInt(UInt<16>("h0"))) @[Cat.scala 31:58]
    node _mux_T_2 = cat(mux_hi, mux_lo) @[Cat.scala 31:58]
    node mux = asSInt(_mux_T_2) @[CLBlut4N10Alu.scala 111:60]
    node _mulMux_T = bits(io.config, 3, 3) @[CLBlut4N10Alu.scala 112:29]
    node mulMux = mux(_mulMux_T, mux, mul8) @[CLBlut4N10Alu.scala 112:19]
    node _combOut_T = bits(io.config, 4, 4) @[CLBlut4N10Alu.scala 113:30]
    node combOut = mux(_combOut_T, mulMux, acc) @[CLBlut4N10Alu.scala 113:20]
    node _accFF_T = bits(io.ctrl, 0, 0) @[CLBlut4N10Alu.scala 116:36]
    node _accFF_T_1 = mux(_accFF_T, asSInt(UInt<1>("h0")), combOut) @[CLBlut4N10Alu.scala 116:28]
    node _accFF_T_2 = bits(io.ctrl, 1, 1) @[CLBlut4N10Alu.scala 116:68]
    node _accFF_T_3 = eq(io.clkEnb, UInt<1>("h0")) @[CLBlut4N10Alu.scala 116:74]
    node _accFF_T_4 = and(_accFF_T_2, _accFF_T_3) @[CLBlut4N10Alu.scala 116:72]
    reg accFF : SInt, clock with :
      reset => (reset, asSInt(UInt<1>("h0"))) @[Reg.scala 28:20]
    when _accFF_T_4 : @[Reg.scala 29:18]
      accFF <= _accFF_T_1 @[Reg.scala 29:22]
    node _out_T = bits(io.config, 3, 3) @[CLBlut4N10Alu.scala 119:26]
    node _out_T_1 = or(_out_T, io.loopBreak) @[CLBlut4N10Alu.scala 119:30]
    node _out_T_2 = mux(_out_T_1, accFF, combOut) @[CLBlut4N10Alu.scala 119:16]
    node _out_T_3 = asUInt(_out_T_2) @[CLBlut4N10Alu.scala 119:62]
    node _out_T_4 = eq(io.gndOuts, UInt<1>("h0")) @[CLBlut4N10Alu.scala 119:71]
    node out = and(_out_T_3, _out_T_4) @[CLBlut4N10Alu.scala 119:69]
    io.ob32 <= out @[CLBlut4N10Alu.scala 120:11]
    node _io_q_T = bits(io.ctrl, 2, 2) @[CLBlut4N10Alu.scala 121:22]
    node _io_q_T_1 = bits(out, 31, 16) @[CLBlut4N10Alu.scala 121:30]
    node _io_q_T_2 = bits(out, 15, 0) @[CLBlut4N10Alu.scala 121:42]
    node _io_q_T_3 = mux(_io_q_T, _io_q_T_1, _io_q_T_2) @[CLBlut4N10Alu.scala 121:14]
    io.q <= _io_q_T_3 @[CLBlut4N10Alu.scala 121:8]

