module IOBlock(
  input         IPIN_0,
  input         IPIN_2,
  input         IPIN_4,
  input         IPIN_6,
  input         IPIN_8,
  input         IPIN_10,
  input         IPIN_12,
  input         IPIN_14,
  input         IPIN_16,
  input         IPIN_18,
  input         IPIN_20,
  input         IPIN_22,
  input         IPIN_24,
  input         IPIN_26,
  input         IPIN_28,
  input         IPIN_30,
  input         IPIN_32,
  input         IPIN_34,
  input         IPIN_36,
  input         IPIN_38,
  input         IPIN_40,
  input         IPIN_42,
  input         IPIN_44,
  input         IPIN_46,
  input         IPIN_48,
  input         IPIN_50,
  input         IPIN_52,
  input         IPIN_54,
  input         IPIN_56,
  input         IPIN_58,
  input         IPIN_60,
  input         IPIN_62,
  output        OPIN_1,
  output        OPIN_3,
  output        OPIN_5,
  output        OPIN_7,
  output        OPIN_9,
  output        OPIN_11,
  output        OPIN_13,
  output        OPIN_15,
  output        OPIN_17,
  output        OPIN_19,
  output        OPIN_21,
  output        OPIN_23,
  output        OPIN_25,
  output        OPIN_27,
  output        OPIN_29,
  output        OPIN_31,
  output        OPIN_33,
  output        OPIN_35,
  output        OPIN_37,
  output        OPIN_39,
  output        OPIN_41,
  output        OPIN_43,
  output        OPIN_45,
  output        OPIN_47,
  output        OPIN_49,
  output        OPIN_51,
  output        OPIN_53,
  output        OPIN_55,
  output        OPIN_57,
  output        OPIN_59,
  output        OPIN_61,
  output        OPIN_63,
  input         clock,
  input         reset,
  input  [31:0] ioPad_i,
  output [31:0] ioPad_o,
  input  [15:0] configBits,
  input         loopBreak,
  input         gndLBouts
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] padOutReg_lo_lo = {IPIN_14,IPIN_12,IPIN_10,IPIN_8,IPIN_6,IPIN_4,IPIN_2,IPIN_0}; // @[IOBlock.scala 31:60]
  wire [15:0] padOutReg_lo = {IPIN_30,IPIN_28,IPIN_26,IPIN_24,IPIN_22,IPIN_20,IPIN_18,IPIN_16,padOutReg_lo_lo}; // @[IOBlock.scala 31:60]
  wire [7:0] padOutReg_hi_lo = {IPIN_46,IPIN_44,IPIN_42,IPIN_40,IPIN_38,IPIN_36,IPIN_34,IPIN_32}; // @[IOBlock.scala 31:60]
  wire [31:0] _padOutReg_T = {IPIN_62,IPIN_60,IPIN_58,IPIN_56,IPIN_54,IPIN_52,IPIN_50,IPIN_48,padOutReg_hi_lo,
    padOutReg_lo}; // @[IOBlock.scala 31:60]
  reg [31:0] padOutReg; // @[Reg.scala 28:20]
  wire  _padOut_T_1 = configBits[15] | loopBreak; // @[IOBlock.scala 32:37]
  reg [31:0] padInReg; // @[Reg.scala 28:20]
  wire [31:0] padIn = _padOut_T_1 ? padInReg : ioPad_i; // @[IOBlock.scala 38:21]
  wire [31:0] padIngnd = gndLBouts ? 32'h0 : padIn; // @[IOBlock.scala 39:23]
  assign OPIN_1 = padIngnd[0]; // @[IOBlock.scala 47:74]
  assign OPIN_3 = padIngnd[1]; // @[IOBlock.scala 47:74]
  assign OPIN_5 = padIngnd[2]; // @[IOBlock.scala 47:74]
  assign OPIN_7 = padIngnd[3]; // @[IOBlock.scala 47:74]
  assign OPIN_9 = padIngnd[4]; // @[IOBlock.scala 47:74]
  assign OPIN_11 = padIngnd[5]; // @[IOBlock.scala 47:74]
  assign OPIN_13 = padIngnd[6]; // @[IOBlock.scala 47:74]
  assign OPIN_15 = padIngnd[7]; // @[IOBlock.scala 47:74]
  assign OPIN_17 = padIngnd[8]; // @[IOBlock.scala 47:74]
  assign OPIN_19 = padIngnd[9]; // @[IOBlock.scala 47:74]
  assign OPIN_21 = padIngnd[10]; // @[IOBlock.scala 47:74]
  assign OPIN_23 = padIngnd[11]; // @[IOBlock.scala 47:74]
  assign OPIN_25 = padIngnd[12]; // @[IOBlock.scala 47:74]
  assign OPIN_27 = padIngnd[13]; // @[IOBlock.scala 47:74]
  assign OPIN_29 = padIngnd[14]; // @[IOBlock.scala 47:74]
  assign OPIN_31 = padIngnd[15]; // @[IOBlock.scala 47:74]
  assign OPIN_33 = padIngnd[16]; // @[IOBlock.scala 47:74]
  assign OPIN_35 = padIngnd[17]; // @[IOBlock.scala 47:74]
  assign OPIN_37 = padIngnd[18]; // @[IOBlock.scala 47:74]
  assign OPIN_39 = padIngnd[19]; // @[IOBlock.scala 47:74]
  assign OPIN_41 = padIngnd[20]; // @[IOBlock.scala 47:74]
  assign OPIN_43 = padIngnd[21]; // @[IOBlock.scala 47:74]
  assign OPIN_45 = padIngnd[22]; // @[IOBlock.scala 47:74]
  assign OPIN_47 = padIngnd[23]; // @[IOBlock.scala 47:74]
  assign OPIN_49 = padIngnd[24]; // @[IOBlock.scala 47:74]
  assign OPIN_51 = padIngnd[25]; // @[IOBlock.scala 47:74]
  assign OPIN_53 = padIngnd[26]; // @[IOBlock.scala 47:74]
  assign OPIN_55 = padIngnd[27]; // @[IOBlock.scala 47:74]
  assign OPIN_57 = padIngnd[28]; // @[IOBlock.scala 47:74]
  assign OPIN_59 = padIngnd[29]; // @[IOBlock.scala 47:74]
  assign OPIN_61 = padIngnd[30]; // @[IOBlock.scala 47:74]
  assign OPIN_63 = padIngnd[31]; // @[IOBlock.scala 47:74]
  assign ioPad_o = configBits[15] | loopBreak ? padOutReg : _padOutReg_T; // @[IOBlock.scala 32:21]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 28:20]
      padOutReg <= 32'h0; // @[Reg.scala 28:20]
    end else if (configBits[15]) begin // @[Reg.scala 29:18]
      padOutReg <= _padOutReg_T; // @[Reg.scala 29:22]
    end
    if (reset) begin // @[Reg.scala 28:20]
      padInReg <= 32'h0; // @[Reg.scala 28:20]
    end else if (configBits[15]) begin // @[Reg.scala 29:18]
      padInReg <= ioPad_i; // @[Reg.scala 29:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  padOutReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  padInReg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
