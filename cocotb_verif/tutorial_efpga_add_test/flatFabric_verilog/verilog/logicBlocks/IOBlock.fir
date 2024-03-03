circuit IOBlock :
  module IOBlock :
    input IPIN_0 : UInt<1>
    input IPIN_2 : UInt<1>
    input IPIN_4 : UInt<1>
    input IPIN_6 : UInt<1>
    input IPIN_8 : UInt<1>
    input IPIN_10 : UInt<1>
    input IPIN_12 : UInt<1>
    input IPIN_14 : UInt<1>
    input IPIN_16 : UInt<1>
    input IPIN_18 : UInt<1>
    input IPIN_20 : UInt<1>
    input IPIN_22 : UInt<1>
    input IPIN_24 : UInt<1>
    input IPIN_26 : UInt<1>
    input IPIN_28 : UInt<1>
    input IPIN_30 : UInt<1>
    input IPIN_32 : UInt<1>
    input IPIN_34 : UInt<1>
    input IPIN_36 : UInt<1>
    input IPIN_38 : UInt<1>
    input IPIN_40 : UInt<1>
    input IPIN_42 : UInt<1>
    input IPIN_44 : UInt<1>
    input IPIN_46 : UInt<1>
    input IPIN_48 : UInt<1>
    input IPIN_50 : UInt<1>
    input IPIN_52 : UInt<1>
    input IPIN_54 : UInt<1>
    input IPIN_56 : UInt<1>
    input IPIN_58 : UInt<1>
    input IPIN_60 : UInt<1>
    input IPIN_62 : UInt<1>
    output OPIN_1 : UInt<1>
    output OPIN_3 : UInt<1>
    output OPIN_5 : UInt<1>
    output OPIN_7 : UInt<1>
    output OPIN_9 : UInt<1>
    output OPIN_11 : UInt<1>
    output OPIN_13 : UInt<1>
    output OPIN_15 : UInt<1>
    output OPIN_17 : UInt<1>
    output OPIN_19 : UInt<1>
    output OPIN_21 : UInt<1>
    output OPIN_23 : UInt<1>
    output OPIN_25 : UInt<1>
    output OPIN_27 : UInt<1>
    output OPIN_29 : UInt<1>
    output OPIN_31 : UInt<1>
    output OPIN_33 : UInt<1>
    output OPIN_35 : UInt<1>
    output OPIN_37 : UInt<1>
    output OPIN_39 : UInt<1>
    output OPIN_41 : UInt<1>
    output OPIN_43 : UInt<1>
    output OPIN_45 : UInt<1>
    output OPIN_47 : UInt<1>
    output OPIN_49 : UInt<1>
    output OPIN_51 : UInt<1>
    output OPIN_53 : UInt<1>
    output OPIN_55 : UInt<1>
    output OPIN_57 : UInt<1>
    output OPIN_59 : UInt<1>
    output OPIN_61 : UInt<1>
    output OPIN_63 : UInt<1>
    input clock : Clock
    input reset : UInt<1>
    output ioPad : { flip i : UInt<32>, o : UInt<32>}
    input configBits : UInt<16>
    input loopBreak : UInt<1>
    input gndLBouts : UInt<1>

    wire _padOutReg_WIRE : UInt<1>[32] @[IOBlock.scala 31:38]
    _padOutReg_WIRE[0] <= IPIN_0 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[1] <= IPIN_2 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[2] <= IPIN_4 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[3] <= IPIN_6 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[4] <= IPIN_8 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[5] <= IPIN_10 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[6] <= IPIN_12 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[7] <= IPIN_14 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[8] <= IPIN_16 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[9] <= IPIN_18 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[10] <= IPIN_20 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[11] <= IPIN_22 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[12] <= IPIN_24 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[13] <= IPIN_26 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[14] <= IPIN_28 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[15] <= IPIN_30 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[16] <= IPIN_32 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[17] <= IPIN_34 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[18] <= IPIN_36 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[19] <= IPIN_38 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[20] <= IPIN_40 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[21] <= IPIN_42 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[22] <= IPIN_44 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[23] <= IPIN_46 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[24] <= IPIN_48 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[25] <= IPIN_50 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[26] <= IPIN_52 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[27] <= IPIN_54 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[28] <= IPIN_56 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[29] <= IPIN_58 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[30] <= IPIN_60 @[IOBlock.scala 31:38]
    _padOutReg_WIRE[31] <= IPIN_62 @[IOBlock.scala 31:38]
    node padOutReg_lo_lo_lo_lo = cat(_padOutReg_WIRE[1], _padOutReg_WIRE[0]) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo_lo_hi = cat(_padOutReg_WIRE[3], _padOutReg_WIRE[2]) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo_lo = cat(padOutReg_lo_lo_lo_hi, padOutReg_lo_lo_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo_hi_lo = cat(_padOutReg_WIRE[5], _padOutReg_WIRE[4]) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo_hi_hi = cat(_padOutReg_WIRE[7], _padOutReg_WIRE[6]) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo_hi = cat(padOutReg_lo_lo_hi_hi, padOutReg_lo_lo_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo_lo = cat(padOutReg_lo_lo_hi, padOutReg_lo_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_lo_lo = cat(_padOutReg_WIRE[9], _padOutReg_WIRE[8]) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_lo_hi = cat(_padOutReg_WIRE[11], _padOutReg_WIRE[10]) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_lo = cat(padOutReg_lo_hi_lo_hi, padOutReg_lo_hi_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_hi_lo = cat(_padOutReg_WIRE[13], _padOutReg_WIRE[12]) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_hi_hi = cat(_padOutReg_WIRE[15], _padOutReg_WIRE[14]) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi_hi = cat(padOutReg_lo_hi_hi_hi, padOutReg_lo_hi_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo_hi = cat(padOutReg_lo_hi_hi, padOutReg_lo_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_lo = cat(padOutReg_lo_hi, padOutReg_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_lo_lo = cat(_padOutReg_WIRE[17], _padOutReg_WIRE[16]) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_lo_hi = cat(_padOutReg_WIRE[19], _padOutReg_WIRE[18]) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_lo = cat(padOutReg_hi_lo_lo_hi, padOutReg_hi_lo_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_hi_lo = cat(_padOutReg_WIRE[21], _padOutReg_WIRE[20]) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_hi_hi = cat(_padOutReg_WIRE[23], _padOutReg_WIRE[22]) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo_hi = cat(padOutReg_hi_lo_hi_hi, padOutReg_hi_lo_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_lo = cat(padOutReg_hi_lo_hi, padOutReg_hi_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_lo_lo = cat(_padOutReg_WIRE[25], _padOutReg_WIRE[24]) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_lo_hi = cat(_padOutReg_WIRE[27], _padOutReg_WIRE[26]) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_lo = cat(padOutReg_hi_hi_lo_hi, padOutReg_hi_hi_lo_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_hi_lo = cat(_padOutReg_WIRE[29], _padOutReg_WIRE[28]) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_hi_hi = cat(_padOutReg_WIRE[31], _padOutReg_WIRE[30]) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi_hi = cat(padOutReg_hi_hi_hi_hi, padOutReg_hi_hi_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi_hi = cat(padOutReg_hi_hi_hi, padOutReg_hi_hi_lo) @[IOBlock.scala 31:60]
    node padOutReg_hi = cat(padOutReg_hi_hi, padOutReg_hi_lo) @[IOBlock.scala 31:60]
    node _padOutReg_T = cat(padOutReg_hi, padOutReg_lo) @[IOBlock.scala 31:60]
    node _padOutReg_T_1 = bits(configBits, 15, 15) @[IOBlock.scala 31:93]
    reg padOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Reg.scala 28:20]
    when _padOutReg_T_1 : @[Reg.scala 29:18]
      padOutReg <= _padOutReg_T @[Reg.scala 29:22]
    node _padOut_T = bits(configBits, 15, 15) @[IOBlock.scala 32:32]
    node _padOut_T_1 = or(_padOut_T, loopBreak) @[IOBlock.scala 32:37]
    wire _padOut_WIRE : UInt<1>[32] @[IOBlock.scala 32:68]
    _padOut_WIRE[0] <= IPIN_0 @[IOBlock.scala 32:68]
    _padOut_WIRE[1] <= IPIN_2 @[IOBlock.scala 32:68]
    _padOut_WIRE[2] <= IPIN_4 @[IOBlock.scala 32:68]
    _padOut_WIRE[3] <= IPIN_6 @[IOBlock.scala 32:68]
    _padOut_WIRE[4] <= IPIN_8 @[IOBlock.scala 32:68]
    _padOut_WIRE[5] <= IPIN_10 @[IOBlock.scala 32:68]
    _padOut_WIRE[6] <= IPIN_12 @[IOBlock.scala 32:68]
    _padOut_WIRE[7] <= IPIN_14 @[IOBlock.scala 32:68]
    _padOut_WIRE[8] <= IPIN_16 @[IOBlock.scala 32:68]
    _padOut_WIRE[9] <= IPIN_18 @[IOBlock.scala 32:68]
    _padOut_WIRE[10] <= IPIN_20 @[IOBlock.scala 32:68]
    _padOut_WIRE[11] <= IPIN_22 @[IOBlock.scala 32:68]
    _padOut_WIRE[12] <= IPIN_24 @[IOBlock.scala 32:68]
    _padOut_WIRE[13] <= IPIN_26 @[IOBlock.scala 32:68]
    _padOut_WIRE[14] <= IPIN_28 @[IOBlock.scala 32:68]
    _padOut_WIRE[15] <= IPIN_30 @[IOBlock.scala 32:68]
    _padOut_WIRE[16] <= IPIN_32 @[IOBlock.scala 32:68]
    _padOut_WIRE[17] <= IPIN_34 @[IOBlock.scala 32:68]
    _padOut_WIRE[18] <= IPIN_36 @[IOBlock.scala 32:68]
    _padOut_WIRE[19] <= IPIN_38 @[IOBlock.scala 32:68]
    _padOut_WIRE[20] <= IPIN_40 @[IOBlock.scala 32:68]
    _padOut_WIRE[21] <= IPIN_42 @[IOBlock.scala 32:68]
    _padOut_WIRE[22] <= IPIN_44 @[IOBlock.scala 32:68]
    _padOut_WIRE[23] <= IPIN_46 @[IOBlock.scala 32:68]
    _padOut_WIRE[24] <= IPIN_48 @[IOBlock.scala 32:68]
    _padOut_WIRE[25] <= IPIN_50 @[IOBlock.scala 32:68]
    _padOut_WIRE[26] <= IPIN_52 @[IOBlock.scala 32:68]
    _padOut_WIRE[27] <= IPIN_54 @[IOBlock.scala 32:68]
    _padOut_WIRE[28] <= IPIN_56 @[IOBlock.scala 32:68]
    _padOut_WIRE[29] <= IPIN_58 @[IOBlock.scala 32:68]
    _padOut_WIRE[30] <= IPIN_60 @[IOBlock.scala 32:68]
    _padOut_WIRE[31] <= IPIN_62 @[IOBlock.scala 32:68]
    node padOut_lo_lo_lo_lo = cat(_padOut_WIRE[1], _padOut_WIRE[0]) @[IOBlock.scala 32:90]
    node padOut_lo_lo_lo_hi = cat(_padOut_WIRE[3], _padOut_WIRE[2]) @[IOBlock.scala 32:90]
    node padOut_lo_lo_lo = cat(padOut_lo_lo_lo_hi, padOut_lo_lo_lo_lo) @[IOBlock.scala 32:90]
    node padOut_lo_lo_hi_lo = cat(_padOut_WIRE[5], _padOut_WIRE[4]) @[IOBlock.scala 32:90]
    node padOut_lo_lo_hi_hi = cat(_padOut_WIRE[7], _padOut_WIRE[6]) @[IOBlock.scala 32:90]
    node padOut_lo_lo_hi = cat(padOut_lo_lo_hi_hi, padOut_lo_lo_hi_lo) @[IOBlock.scala 32:90]
    node padOut_lo_lo = cat(padOut_lo_lo_hi, padOut_lo_lo_lo) @[IOBlock.scala 32:90]
    node padOut_lo_hi_lo_lo = cat(_padOut_WIRE[9], _padOut_WIRE[8]) @[IOBlock.scala 32:90]
    node padOut_lo_hi_lo_hi = cat(_padOut_WIRE[11], _padOut_WIRE[10]) @[IOBlock.scala 32:90]
    node padOut_lo_hi_lo = cat(padOut_lo_hi_lo_hi, padOut_lo_hi_lo_lo) @[IOBlock.scala 32:90]
    node padOut_lo_hi_hi_lo = cat(_padOut_WIRE[13], _padOut_WIRE[12]) @[IOBlock.scala 32:90]
    node padOut_lo_hi_hi_hi = cat(_padOut_WIRE[15], _padOut_WIRE[14]) @[IOBlock.scala 32:90]
    node padOut_lo_hi_hi = cat(padOut_lo_hi_hi_hi, padOut_lo_hi_hi_lo) @[IOBlock.scala 32:90]
    node padOut_lo_hi = cat(padOut_lo_hi_hi, padOut_lo_hi_lo) @[IOBlock.scala 32:90]
    node padOut_lo = cat(padOut_lo_hi, padOut_lo_lo) @[IOBlock.scala 32:90]
    node padOut_hi_lo_lo_lo = cat(_padOut_WIRE[17], _padOut_WIRE[16]) @[IOBlock.scala 32:90]
    node padOut_hi_lo_lo_hi = cat(_padOut_WIRE[19], _padOut_WIRE[18]) @[IOBlock.scala 32:90]
    node padOut_hi_lo_lo = cat(padOut_hi_lo_lo_hi, padOut_hi_lo_lo_lo) @[IOBlock.scala 32:90]
    node padOut_hi_lo_hi_lo = cat(_padOut_WIRE[21], _padOut_WIRE[20]) @[IOBlock.scala 32:90]
    node padOut_hi_lo_hi_hi = cat(_padOut_WIRE[23], _padOut_WIRE[22]) @[IOBlock.scala 32:90]
    node padOut_hi_lo_hi = cat(padOut_hi_lo_hi_hi, padOut_hi_lo_hi_lo) @[IOBlock.scala 32:90]
    node padOut_hi_lo = cat(padOut_hi_lo_hi, padOut_hi_lo_lo) @[IOBlock.scala 32:90]
    node padOut_hi_hi_lo_lo = cat(_padOut_WIRE[25], _padOut_WIRE[24]) @[IOBlock.scala 32:90]
    node padOut_hi_hi_lo_hi = cat(_padOut_WIRE[27], _padOut_WIRE[26]) @[IOBlock.scala 32:90]
    node padOut_hi_hi_lo = cat(padOut_hi_hi_lo_hi, padOut_hi_hi_lo_lo) @[IOBlock.scala 32:90]
    node padOut_hi_hi_hi_lo = cat(_padOut_WIRE[29], _padOut_WIRE[28]) @[IOBlock.scala 32:90]
    node padOut_hi_hi_hi_hi = cat(_padOut_WIRE[31], _padOut_WIRE[30]) @[IOBlock.scala 32:90]
    node padOut_hi_hi_hi = cat(padOut_hi_hi_hi_hi, padOut_hi_hi_hi_lo) @[IOBlock.scala 32:90]
    node padOut_hi_hi = cat(padOut_hi_hi_hi, padOut_hi_hi_lo) @[IOBlock.scala 32:90]
    node padOut_hi = cat(padOut_hi_hi, padOut_hi_lo) @[IOBlock.scala 32:90]
    node _padOut_T_2 = cat(padOut_hi, padOut_lo) @[IOBlock.scala 32:90]
    node padOut = mux(_padOut_T_1, padOutReg, _padOut_T_2) @[IOBlock.scala 32:21]
    ioPad.o <= padOut @[IOBlock.scala 33:17]
    node _padInReg_T = bits(configBits, 15, 15) @[IOBlock.scala 37:58]
    reg padInReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 28:20]
    when _padInReg_T : @[Reg.scala 29:18]
      padInReg <= ioPad.i @[Reg.scala 29:22]
    node _padIn_T = bits(configBits, 15, 15) @[IOBlock.scala 38:32]
    node _padIn_T_1 = or(_padIn_T, loopBreak) @[IOBlock.scala 38:37]
    node padIn = mux(_padIn_T_1, padInReg, ioPad.i) @[IOBlock.scala 38:21]
    node padIngnd = mux(gndLBouts, UInt<1>("h0"), padIn) @[IOBlock.scala 39:23]
    node _OPIN_1_T = bits(padIngnd, 0, 0) @[IOBlock.scala 47:74]
    OPIN_1 <= _OPIN_1_T @[IOBlock.scala 47:65]
    node _OPIN_3_T = bits(padIngnd, 1, 1) @[IOBlock.scala 47:74]
    OPIN_3 <= _OPIN_3_T @[IOBlock.scala 47:65]
    node _OPIN_5_T = bits(padIngnd, 2, 2) @[IOBlock.scala 47:74]
    OPIN_5 <= _OPIN_5_T @[IOBlock.scala 47:65]
    node _OPIN_7_T = bits(padIngnd, 3, 3) @[IOBlock.scala 47:74]
    OPIN_7 <= _OPIN_7_T @[IOBlock.scala 47:65]
    node _OPIN_9_T = bits(padIngnd, 4, 4) @[IOBlock.scala 47:74]
    OPIN_9 <= _OPIN_9_T @[IOBlock.scala 47:65]
    node _OPIN_11_T = bits(padIngnd, 5, 5) @[IOBlock.scala 47:74]
    OPIN_11 <= _OPIN_11_T @[IOBlock.scala 47:65]
    node _OPIN_13_T = bits(padIngnd, 6, 6) @[IOBlock.scala 47:74]
    OPIN_13 <= _OPIN_13_T @[IOBlock.scala 47:65]
    node _OPIN_15_T = bits(padIngnd, 7, 7) @[IOBlock.scala 47:74]
    OPIN_15 <= _OPIN_15_T @[IOBlock.scala 47:65]
    node _OPIN_17_T = bits(padIngnd, 8, 8) @[IOBlock.scala 47:74]
    OPIN_17 <= _OPIN_17_T @[IOBlock.scala 47:65]
    node _OPIN_19_T = bits(padIngnd, 9, 9) @[IOBlock.scala 47:74]
    OPIN_19 <= _OPIN_19_T @[IOBlock.scala 47:65]
    node _OPIN_21_T = bits(padIngnd, 10, 10) @[IOBlock.scala 47:74]
    OPIN_21 <= _OPIN_21_T @[IOBlock.scala 47:65]
    node _OPIN_23_T = bits(padIngnd, 11, 11) @[IOBlock.scala 47:74]
    OPIN_23 <= _OPIN_23_T @[IOBlock.scala 47:65]
    node _OPIN_25_T = bits(padIngnd, 12, 12) @[IOBlock.scala 47:74]
    OPIN_25 <= _OPIN_25_T @[IOBlock.scala 47:65]
    node _OPIN_27_T = bits(padIngnd, 13, 13) @[IOBlock.scala 47:74]
    OPIN_27 <= _OPIN_27_T @[IOBlock.scala 47:65]
    node _OPIN_29_T = bits(padIngnd, 14, 14) @[IOBlock.scala 47:74]
    OPIN_29 <= _OPIN_29_T @[IOBlock.scala 47:65]
    node _OPIN_31_T = bits(padIngnd, 15, 15) @[IOBlock.scala 47:74]
    OPIN_31 <= _OPIN_31_T @[IOBlock.scala 47:65]
    node _OPIN_33_T = bits(padIngnd, 16, 16) @[IOBlock.scala 47:74]
    OPIN_33 <= _OPIN_33_T @[IOBlock.scala 47:65]
    node _OPIN_35_T = bits(padIngnd, 17, 17) @[IOBlock.scala 47:74]
    OPIN_35 <= _OPIN_35_T @[IOBlock.scala 47:65]
    node _OPIN_37_T = bits(padIngnd, 18, 18) @[IOBlock.scala 47:74]
    OPIN_37 <= _OPIN_37_T @[IOBlock.scala 47:65]
    node _OPIN_39_T = bits(padIngnd, 19, 19) @[IOBlock.scala 47:74]
    OPIN_39 <= _OPIN_39_T @[IOBlock.scala 47:65]
    node _OPIN_41_T = bits(padIngnd, 20, 20) @[IOBlock.scala 47:74]
    OPIN_41 <= _OPIN_41_T @[IOBlock.scala 47:65]
    node _OPIN_43_T = bits(padIngnd, 21, 21) @[IOBlock.scala 47:74]
    OPIN_43 <= _OPIN_43_T @[IOBlock.scala 47:65]
    node _OPIN_45_T = bits(padIngnd, 22, 22) @[IOBlock.scala 47:74]
    OPIN_45 <= _OPIN_45_T @[IOBlock.scala 47:65]
    node _OPIN_47_T = bits(padIngnd, 23, 23) @[IOBlock.scala 47:74]
    OPIN_47 <= _OPIN_47_T @[IOBlock.scala 47:65]
    node _OPIN_49_T = bits(padIngnd, 24, 24) @[IOBlock.scala 47:74]
    OPIN_49 <= _OPIN_49_T @[IOBlock.scala 47:65]
    node _OPIN_51_T = bits(padIngnd, 25, 25) @[IOBlock.scala 47:74]
    OPIN_51 <= _OPIN_51_T @[IOBlock.scala 47:65]
    node _OPIN_53_T = bits(padIngnd, 26, 26) @[IOBlock.scala 47:74]
    OPIN_53 <= _OPIN_53_T @[IOBlock.scala 47:65]
    node _OPIN_55_T = bits(padIngnd, 27, 27) @[IOBlock.scala 47:74]
    OPIN_55 <= _OPIN_55_T @[IOBlock.scala 47:65]
    node _OPIN_57_T = bits(padIngnd, 28, 28) @[IOBlock.scala 47:74]
    OPIN_57 <= _OPIN_57_T @[IOBlock.scala 47:65]
    node _OPIN_59_T = bits(padIngnd, 29, 29) @[IOBlock.scala 47:74]
    OPIN_59 <= _OPIN_59_T @[IOBlock.scala 47:65]
    node _OPIN_61_T = bits(padIngnd, 30, 30) @[IOBlock.scala 47:74]
    OPIN_61 <= _OPIN_61_T @[IOBlock.scala 47:65]
    node _OPIN_63_T = bits(padIngnd, 31, 31) @[IOBlock.scala 47:74]
    OPIN_63 <= _OPIN_63_T @[IOBlock.scala 47:65]

