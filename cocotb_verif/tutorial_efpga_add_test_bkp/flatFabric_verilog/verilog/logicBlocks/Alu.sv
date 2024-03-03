module Alu(
  input         clock,
  input         reset,
  input  [15:0] io_i0,
  input  [15:0] io_i1,
  input  [31:0] io_ib32,
  input  [7:0]  io_ctrl,
  output [15:0] io_q,
  output [31:0] io_ob32,
  input  [31:0] io_config,
  input         io_gndOuts,
  input         io_clkEnb,
  input         io_loopBreak
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  _i0FF_T = ~io_clkEnb; // @[CLBlut4N10Alu.scala 100:44]
  reg [15:0] i0FF; // @[Reg.scala 28:20]
  reg [15:0] i1FF; // @[Reg.scala 28:20]
  reg [31:0] ib32FF; // @[Reg.scala 28:20]
  wire [15:0] in0 = io_config[0] ? io_i0 : i0FF; // @[CLBlut4N10Alu.scala 104:44]
  wire [15:0] in1 = io_config[1] ? io_i1 : i1FF; // @[CLBlut4N10Alu.scala 105:44]
  wire [31:0] ib32 = io_config[2] ? io_ib32 : ib32FF; // @[CLBlut4N10Alu.scala 106:49]
  wire [15:0] _acc_T_2 = $signed(in0) + $signed(in1); // @[CLBlut4N10Alu.scala 108:17]
  wire [31:0] _GEN_4 = {{16{_acc_T_2[15]}},_acc_T_2}; // @[CLBlut4N10Alu.scala 108:23]
  wire [31:0] acc = $signed(_GEN_4) + $signed(ib32); // @[CLBlut4N10Alu.scala 108:23]
  wire [8:0] _mul8_T_1 = in0[8:0]; // @[CLBlut4N10Alu.scala 110:20]
  wire [8:0] _mul8_T_3 = in1[8:0]; // @[CLBlut4N10Alu.scala 110:38]
  wire [17:0] _mul8_T_4 = $signed(_mul8_T_1) * $signed(_mul8_T_3); // @[CLBlut4N10Alu.scala 110:27]
  wire [15:0] mux_lo = io_ctrl[3] ? $signed(in1) : $signed(in0); // @[Cat.scala 31:58]
  wire [31:0] mux = {16'h0,mux_lo}; // @[CLBlut4N10Alu.scala 111:60]
  wire [31:0] mul8 = {{14{_mul8_T_4[17]}},_mul8_T_4}; // @[CLBlut4N10Alu.scala 109:18 110:8]
  wire [31:0] mulMux = io_config[3] ? $signed(mux) : $signed(mul8); // @[CLBlut4N10Alu.scala 112:19]
  wire [31:0] combOut = io_config[4] ? $signed(mulMux) : $signed(acc); // @[CLBlut4N10Alu.scala 113:20]
  wire  _accFF_T_4 = io_ctrl[1] & _i0FF_T; // @[CLBlut4N10Alu.scala 116:72]
  reg [31:0] accFF; // @[Reg.scala 28:20]
  wire [31:0] _out_T_3 = io_config[3] | io_loopBreak ? $signed(accFF) : $signed(combOut); // @[CLBlut4N10Alu.scala 119:62]
  wire  _out_T_4 = ~io_gndOuts; // @[CLBlut4N10Alu.scala 119:71]
  wire [31:0] _GEN_5 = {{31'd0}, _out_T_4}; // @[CLBlut4N10Alu.scala 119:69]
  wire [31:0] out = _out_T_3 & _GEN_5; // @[CLBlut4N10Alu.scala 119:69]
  assign io_q = io_ctrl[2] ? out[31:16] : out[15:0]; // @[CLBlut4N10Alu.scala 121:14]
  assign io_ob32 = _out_T_3 & _GEN_5; // @[CLBlut4N10Alu.scala 119:69]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 28:20]
      i0FF <= 16'h0; // @[Reg.scala 28:20]
    end else if (_i0FF_T) begin // @[Reg.scala 29:18]
      i0FF <= io_i0; // @[Reg.scala 29:22]
    end
    if (reset) begin // @[Reg.scala 28:20]
      i1FF <= 16'h0; // @[Reg.scala 28:20]
    end else if (_i0FF_T) begin // @[Reg.scala 29:18]
      i1FF <= io_i1; // @[Reg.scala 29:22]
    end
    if (reset) begin // @[Reg.scala 28:20]
      ib32FF <= 32'h0; // @[Reg.scala 28:20]
    end else if (_i0FF_T) begin // @[Reg.scala 29:18]
      ib32FF <= io_ib32; // @[Reg.scala 29:22]
    end
    if (reset) begin // @[Reg.scala 28:20]
      accFF <= 32'sh0; // @[Reg.scala 28:20]
    end else if (_accFF_T_4) begin // @[Reg.scala 29:18]
      if (io_ctrl[0]) begin // @[CLBlut4N10Alu.scala 116:28]
        accFF <= 32'sh0;
      end else if (io_config[4]) begin // @[CLBlut4N10Alu.scala 113:20]
        accFF <= mulMux;
      end else begin
        accFF <= acc;
      end
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
  i0FF = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  i1FF = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  ib32FF = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  accFF = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
