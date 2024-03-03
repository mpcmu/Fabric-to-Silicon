module Ble4(
  input         clock,
  input         reset,
  input  [19:0] io_config,
  input         io_in_0,
  input         io_in_1,
  input         io_in_2,
  input         io_in_3,
  output        io_outR,
  output        io_outT,
  input         io_gndOuts,
  input         io_clkEnb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] lut_in; // @[CLBlut4N10Clb.scala 73:27]
  wire [3:0] lut_sel; // @[CLBlut4N10Clb.scala 73:27]
  wire  lut_o; // @[CLBlut4N10Clb.scala 73:27]
  wire [1:0] lut_io_sel_lo = {io_in_1,io_in_0}; // @[CLBlut4N10Clb.scala 75:23]
  wire [1:0] lut_io_sel_hi = {io_in_3,io_in_2}; // @[CLBlut4N10Clb.scala 75:23]
  wire  _bleFF_T = ~io_clkEnb; // @[CLBlut4N10Clb.scala 77:48]
  reg  bleFF; // @[Reg.scala 28:20]
  wire  _io_outR_T_1 = io_config[16] ? lut_o : bleFF; // @[CLBlut4N10Clb.scala 80:17]
  wire  _io_outR_T_2 = ~io_gndOuts; // @[CLBlut4N10Clb.scala 80:52]
  wire  _io_outT_T_1 = io_config[17] ? lut_o : bleFF; // @[CLBlut4N10Clb.scala 81:17]
  Mux16C lut ( // @[CLBlut4N10Clb.scala 73:27]
    .in(lut_in),
    .sel(lut_sel),
    .o(lut_o)
  );
  assign io_outR = _io_outR_T_1 & ~io_gndOuts; // @[CLBlut4N10Clb.scala 80:50]
  assign io_outT = _io_outT_T_1 & _io_outR_T_2; // @[CLBlut4N10Clb.scala 81:50]
  assign lut_in = io_config[15:0]; // @[CLBlut4N10Clb.scala 74:25]
  assign lut_sel = {lut_io_sel_hi,lut_io_sel_lo}; // @[CLBlut4N10Clb.scala 75:23]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 28:20]
      bleFF <= 1'h0; // @[Reg.scala 28:20]
    end else if (_bleFF_T) begin // @[Reg.scala 29:18]
      bleFF <= lut_o; // @[Reg.scala 29:22]
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
  bleFF = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CLBlut4N10(
  input          IPIN_0,
  input          IPIN_1,
  input          IPIN_2,
  input          IPIN_3,
  input          IPIN_4,
  input          IPIN_5,
  input          IPIN_6,
  input          IPIN_7,
  input          IPIN_8,
  input          IPIN_9,
  input          IPIN_10,
  input          IPIN_11,
  input          IPIN_12,
  input          IPIN_13,
  input          IPIN_14,
  input          IPIN_15,
  input          IPIN_16,
  input          IPIN_17,
  input          IPIN_18,
  input          IPIN_19,
  input          IPIN_20,
  input          IPIN_21,
  input          IPIN_22,
  input          IPIN_23,
  input          IPIN_24,
  input          IPIN_25,
  input          IPIN_26,
  input          IPIN_27,
  input          IPIN_28,
  input          IPIN_29,
  input          IPIN_30,
  input          IPIN_31,
  input          IPIN_32,
  input          IPIN_33,
  input          IPIN_34,
  input          IPIN_35,
  input          IPIN_36,
  input          IPIN_37,
  input          IPIN_38,
  input          IPIN_39,
  output         OPIN_40,
  output         OPIN_41,
  output         OPIN_42,
  output         OPIN_43,
  output         OPIN_44,
  output         OPIN_45,
  output         OPIN_46,
  output         OPIN_47,
  output         OPIN_48,
  output         OPIN_49,
  output         OPIN_50,
  output         OPIN_51,
  output         OPIN_52,
  output         OPIN_53,
  output         OPIN_54,
  output         OPIN_55,
  input          clock,
  input          reset,
  input  [161:0] configBits,
  input          loopBreak,
  input          gndLBouts
);
  wire  BLE_0_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_0_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_0_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_1_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_1_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_2_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_2_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_3_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_3_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_4_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_4_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_5_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_5_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_6_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_6_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_clock; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_reset; // @[CLBlut4N10Clb.scala 45:48]
  wire [19:0] BLE_7_io_config; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_in_0; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_in_1; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_in_2; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_in_3; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_outR; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_outT; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_gndOuts; // @[CLBlut4N10Clb.scala 45:48]
  wire  BLE_7_io_clkEnb; // @[CLBlut4N10Clb.scala 45:48]
  wire [7:0] I_0 = {IPIN_7,IPIN_6,IPIN_5,IPIN_4,IPIN_3,IPIN_2,IPIN_1,IPIN_0}; // @[CLBlut4N10Clb.scala 35:92]
  wire [7:0] I_1 = {IPIN_15,IPIN_14,IPIN_13,IPIN_12,IPIN_11,IPIN_10,IPIN_9,IPIN_8}; // @[CLBlut4N10Clb.scala 35:92]
  wire [7:0] I_2 = {IPIN_23,IPIN_22,IPIN_21,IPIN_20,IPIN_19,IPIN_18,IPIN_17,IPIN_16}; // @[CLBlut4N10Clb.scala 35:92]
  wire [7:0] I_3 = {IPIN_31,IPIN_30,IPIN_29,IPIN_28,IPIN_27,IPIN_26,IPIN_25,IPIN_24}; // @[CLBlut4N10Clb.scala 35:92]
  Ble4 BLE_0 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_0_clock),
    .reset(BLE_0_reset),
    .io_config(BLE_0_io_config),
    .io_in_0(BLE_0_io_in_0),
    .io_in_1(BLE_0_io_in_1),
    .io_in_2(BLE_0_io_in_2),
    .io_in_3(BLE_0_io_in_3),
    .io_outR(BLE_0_io_outR),
    .io_outT(BLE_0_io_outT),
    .io_gndOuts(BLE_0_io_gndOuts),
    .io_clkEnb(BLE_0_io_clkEnb)
  );
  Ble4 BLE_1 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_1_clock),
    .reset(BLE_1_reset),
    .io_config(BLE_1_io_config),
    .io_in_0(BLE_1_io_in_0),
    .io_in_1(BLE_1_io_in_1),
    .io_in_2(BLE_1_io_in_2),
    .io_in_3(BLE_1_io_in_3),
    .io_outR(BLE_1_io_outR),
    .io_outT(BLE_1_io_outT),
    .io_gndOuts(BLE_1_io_gndOuts),
    .io_clkEnb(BLE_1_io_clkEnb)
  );
  Ble4 BLE_2 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_2_clock),
    .reset(BLE_2_reset),
    .io_config(BLE_2_io_config),
    .io_in_0(BLE_2_io_in_0),
    .io_in_1(BLE_2_io_in_1),
    .io_in_2(BLE_2_io_in_2),
    .io_in_3(BLE_2_io_in_3),
    .io_outR(BLE_2_io_outR),
    .io_outT(BLE_2_io_outT),
    .io_gndOuts(BLE_2_io_gndOuts),
    .io_clkEnb(BLE_2_io_clkEnb)
  );
  Ble4 BLE_3 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_3_clock),
    .reset(BLE_3_reset),
    .io_config(BLE_3_io_config),
    .io_in_0(BLE_3_io_in_0),
    .io_in_1(BLE_3_io_in_1),
    .io_in_2(BLE_3_io_in_2),
    .io_in_3(BLE_3_io_in_3),
    .io_outR(BLE_3_io_outR),
    .io_outT(BLE_3_io_outT),
    .io_gndOuts(BLE_3_io_gndOuts),
    .io_clkEnb(BLE_3_io_clkEnb)
  );
  Ble4 BLE_4 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_4_clock),
    .reset(BLE_4_reset),
    .io_config(BLE_4_io_config),
    .io_in_0(BLE_4_io_in_0),
    .io_in_1(BLE_4_io_in_1),
    .io_in_2(BLE_4_io_in_2),
    .io_in_3(BLE_4_io_in_3),
    .io_outR(BLE_4_io_outR),
    .io_outT(BLE_4_io_outT),
    .io_gndOuts(BLE_4_io_gndOuts),
    .io_clkEnb(BLE_4_io_clkEnb)
  );
  Ble4 BLE_5 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_5_clock),
    .reset(BLE_5_reset),
    .io_config(BLE_5_io_config),
    .io_in_0(BLE_5_io_in_0),
    .io_in_1(BLE_5_io_in_1),
    .io_in_2(BLE_5_io_in_2),
    .io_in_3(BLE_5_io_in_3),
    .io_outR(BLE_5_io_outR),
    .io_outT(BLE_5_io_outT),
    .io_gndOuts(BLE_5_io_gndOuts),
    .io_clkEnb(BLE_5_io_clkEnb)
  );
  Ble4 BLE_6 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_6_clock),
    .reset(BLE_6_reset),
    .io_config(BLE_6_io_config),
    .io_in_0(BLE_6_io_in_0),
    .io_in_1(BLE_6_io_in_1),
    .io_in_2(BLE_6_io_in_2),
    .io_in_3(BLE_6_io_in_3),
    .io_outR(BLE_6_io_outR),
    .io_outT(BLE_6_io_outT),
    .io_gndOuts(BLE_6_io_gndOuts),
    .io_clkEnb(BLE_6_io_clkEnb)
  );
  Ble4 BLE_7 ( // @[CLBlut4N10Clb.scala 45:48]
    .clock(BLE_7_clock),
    .reset(BLE_7_reset),
    .io_config(BLE_7_io_config),
    .io_in_0(BLE_7_io_in_0),
    .io_in_1(BLE_7_io_in_1),
    .io_in_2(BLE_7_io_in_2),
    .io_in_3(BLE_7_io_in_3),
    .io_outR(BLE_7_io_outR),
    .io_outT(BLE_7_io_outT),
    .io_gndOuts(BLE_7_io_gndOuts),
    .io_clkEnb(BLE_7_io_clkEnb)
  );
  assign OPIN_40 = BLE_0_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_41 = BLE_1_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_42 = BLE_2_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_43 = BLE_3_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_44 = BLE_4_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_45 = BLE_5_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_46 = BLE_6_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_47 = BLE_7_io_outR; // @[CLBlut4N10Clb.scala 37:18 49:15]
  assign OPIN_48 = BLE_0_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_49 = BLE_1_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_50 = BLE_2_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_51 = BLE_3_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_52 = BLE_4_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_53 = BLE_5_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_54 = BLE_6_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign OPIN_55 = BLE_7_io_outT; // @[CLBlut4N10Clb.scala 37:18 50:17]
  assign BLE_0_clock = clock;
  assign BLE_0_reset = reset;
  assign BLE_0_io_config = configBits[19:0]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_0_io_in_0 = I_0[0]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_0_io_in_1 = I_1[0]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_0_io_in_2 = I_2[0]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_0_io_in_3 = I_3[0]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_0_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_0_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_1_clock = clock;
  assign BLE_1_reset = reset;
  assign BLE_1_io_config = configBits[39:20]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_1_io_in_0 = I_0[1]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_1_io_in_1 = I_1[1]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_1_io_in_2 = I_2[1]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_1_io_in_3 = I_3[1]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_1_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_1_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_2_clock = clock;
  assign BLE_2_reset = reset;
  assign BLE_2_io_config = configBits[59:40]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_2_io_in_0 = I_0[2]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_2_io_in_1 = I_1[2]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_2_io_in_2 = I_2[2]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_2_io_in_3 = I_3[2]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_2_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_2_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_3_clock = clock;
  assign BLE_3_reset = reset;
  assign BLE_3_io_config = configBits[79:60]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_3_io_in_0 = I_0[3]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_3_io_in_1 = I_1[3]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_3_io_in_2 = I_2[3]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_3_io_in_3 = I_3[3]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_3_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_3_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_4_clock = clock;
  assign BLE_4_reset = reset;
  assign BLE_4_io_config = configBits[99:80]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_4_io_in_0 = I_0[4]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_4_io_in_1 = I_1[4]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_4_io_in_2 = I_2[4]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_4_io_in_3 = I_3[4]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_4_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_4_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_5_clock = clock;
  assign BLE_5_reset = reset;
  assign BLE_5_io_config = configBits[119:100]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_5_io_in_0 = I_0[5]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_5_io_in_1 = I_1[5]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_5_io_in_2 = I_2[5]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_5_io_in_3 = I_3[5]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_5_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_5_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_6_clock = clock;
  assign BLE_6_reset = reset;
  assign BLE_6_io_config = configBits[139:120]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_6_io_in_0 = I_0[6]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_6_io_in_1 = I_1[6]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_6_io_in_2 = I_2[6]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_6_io_in_3 = I_3[6]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_6_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_6_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
  assign BLE_7_clock = clock;
  assign BLE_7_reset = reset;
  assign BLE_7_io_config = configBits[159:140]; // @[CLBlut4N10Clb.scala 47:38]
  assign BLE_7_io_in_0 = I_0[7]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_7_io_in_1 = I_1[7]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_7_io_in_2 = I_2[7]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_7_io_in_3 = I_3[7]; // @[CLBlut4N10Clb.scala 48:62]
  assign BLE_7_io_gndOuts = gndLBouts; // @[CLBlut4N10Clb.scala 51:26]
  assign BLE_7_io_clkEnb = configBits[161]; // @[CLBlut4N10Clb.scala 52:38]
endmodule
