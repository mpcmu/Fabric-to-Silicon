module AluMul(
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
  wire  _i0FF_T = ~io_clkEnb; // @[CLBlut4N10Mul.scala 100:44]
  reg [15:0] i0FF; // @[Reg.scala 28:20]
  reg [15:0] i1FF; // @[Reg.scala 28:20]
  reg [31:0] ib32FF; // @[Reg.scala 28:20]
  wire [15:0] in0 = io_config[0] ? io_i0 : i0FF; // @[CLBlut4N10Mul.scala 104:44]
  wire [15:0] in1 = io_config[1] ? io_i1 : i1FF; // @[CLBlut4N10Mul.scala 105:44]
  wire [31:0] ib32 = io_config[2] ? io_ib32 : ib32FF; // @[CLBlut4N10Mul.scala 106:49]
  wire [15:0] _add_T_2 = $signed(in0) + $signed(in1); // @[CLBlut4N10Mul.scala 108:17]
  wire [31:0] _GEN_4 = {{16{_add_T_2[15]}},_add_T_2}; // @[CLBlut4N10Mul.scala 108:23]
  wire [31:0] add = $signed(_GEN_4) + $signed(ib32); // @[CLBlut4N10Mul.scala 108:23]
  wire [31:0] mul16 = $signed(in0) * $signed(in1); // @[CLBlut4N10Mul.scala 110:16]
  wire [15:0] mux_lo = io_ctrl[3] ? $signed(in1) : $signed(in0); // @[Cat.scala 31:58]
  wire [31:0] mux = {16'h0,mux_lo}; // @[CLBlut4N10Mul.scala 111:60]
  wire [1:0] _accVal_T_2 = {io_config[4],io_config[3]}; // @[Cat.scala 31:58]
  reg [31:0] accFF_r; // @[Reg.scala 28:20]
  wire [31:0] accVal = _accVal_T_2 == 2'h2 ? $signed(accFF_r) : $signed(32'sh0); // @[CLBlut4N10Mul.scala 113:19]
  wire [31:0] _mac_T_2 = $signed(mul16) + $signed(ib32); // @[CLBlut4N10Mul.scala 114:19]
  wire [31:0] mac = $signed(_mac_T_2) + $signed(accVal); // @[CLBlut4N10Mul.scala 114:26]
  wire [31:0] _combOut_T_4 = 2'h1 == _accVal_T_2 ? $signed(mul16) : $signed(add); // @[Mux.scala 81:58]
  wire [31:0] _combOut_T_6 = 2'h2 == _accVal_T_2 ? $signed(mac) : $signed(_combOut_T_4); // @[Mux.scala 81:58]
  wire [31:0] combOut = 2'h3 == _accVal_T_2 ? $signed(mux) : $signed(_combOut_T_6); // @[Mux.scala 81:58]
  wire  _accFF_T_4 = io_ctrl[1] & _i0FF_T; // @[CLBlut4N10Mul.scala 117:69]
  wire [31:0] _out_T_3 = io_config[7] | io_loopBreak ? $signed(accFF_r) : $signed(combOut); // @[CLBlut4N10Mul.scala 120:83]
  wire [31:0] out = io_gndOuts ? 32'h0 : _out_T_3; // @[CLBlut4N10Mul.scala 120:16]
  assign io_q = io_ctrl[2] ? out[31:16] : out[15:0]; // @[CLBlut4N10Mul.scala 122:14]
  assign io_ob32 = io_gndOuts ? 32'h0 : _out_T_3; // @[CLBlut4N10Mul.scala 120:16]
  always @(pose


  dge clock) begin
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
      accFF_r <= 32'sh0; // @[Reg.scala 28:20]
    end else if (_accFF_T_4) begin // @[Reg.scala 29:18]
      if (io_ctrl[0]) begin // @[CLBlut4N10Mul.scala 117:25]
        accFF_r <= 32'sh0;
      end else if (2'h3 == _accVal_T_2) begin // @[Mux.scala 81:58]
        accFF_r <= mux;
      end else begin
        accFF_r <= _combOut_T_6;
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
  accFF_r = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
