/* Generated by Yosys 0.33+34 (git sha1 b84ed5d3a, clang 10.0.0-4ubuntu1 -fPIC -Os) */

(* top =  1  *)
(* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:1.1-29.10" *)
module mul(IN, OUT, clk);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:3.19-3.21" *)
  input [127:0] IN;
  wire [127:0] IN;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:4.21-4.24" *)
  output [127:0] OUT;
  wire [127:0] OUT;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:10.9-10.11" *)
  reg R0;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:10.13-10.17" *)
  reg R0_1;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:5.11-5.14" *)
  input clk;
  wire clk;
  assign OUT[32] = 4'h8 >> { IN[4], IN[0] };
  assign OUT[33] = 16'h7888 >> { IN[1], IN[4], IN[5], IN[0] };
  assign OUT[34] = 16'h8778 >> { _01_, _00_, IN[6], IN[0] };
  assign _00_ = 8'h80 >> { IN[5], IN[1], OUT[32] };
  assign _01_ = 16'h7888 >> { IN[5], IN[1], IN[2], IN[4] };
  assign OUT[35] = 4'h6 >> { _03_, _02_ };
  assign _02_ = 8'h60 >> { _00_, _01_, IN[6] };
  assign _03_ = 16'h7887 >> { _06_, _04_, IN[7], IN[0] };
  assign _04_ = 16'h007f >> { _05_, IN[0], _01_, IN[6] };
  assign _05_ = 16'h8000 >> { IN[5], IN[2:1], IN[4] };
  assign _06_ = 4'h6 >> { _08_, _07_ };
  assign _07_ = 4'h8 >> { IN[6], IN[1] };
  assign _08_ = 16'h7888 >> { IN[5], IN[2], IN[3], IN[4] };
  assign OUT[36] = 8'h69 >> { _11_, _10_, _09_ };
  assign _09_ = 4'h8 >> { _03_, _02_ };
  assign _10_ = 16'h2bbb >> { IN[7], IN[0], _06_, _04_ };
  assign _11_ = 8'h78 >> { _12_, IN[7], IN[1] };
  assign _12_ = 16'h3c5a >> { _08_, _14_, _07_, _13_ };
  assign _13_ = 4'h8 >> { IN[5], IN[2] };
  assign _14_ = 16'h7888 >> { IN[5], IN[3], IN[6], IN[2] };
  assign OUT[37] = 16'h4db2 >> { _15_, _11_, _10_, _09_ };
  assign _15_ = 4'h9 >> { _17_, _16_ };
  assign _16_ = 16'h770f >> { _12_, _14_, IN[1], IN[7] };
  assign _17_ = 16'hb444 >> { IN[7], IN[2], _18_, _13_ };
  assign _18_ = 4'h8 >> { IN[6], IN[3] };
  assign OUT[38] = 16'h7887 >> { _20_, _19_, IN[7], IN[3] };
  assign _19_ = 16'h7150 >> { _11_, _17_, _10_, _16_ };
  assign _20_ = 16'h1fff >> { IN[2], _18_, IN[5], IN[7] };
  assign OUT[39] = 16'hb222 >> { IN[7], IN[3], _20_, _19_ };
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:22.2-25.5" *)
  always @(posedge clk)
    R0 <= R0_1;
  (* src = "/home/kmgroup/projects/tutorial/fpga_cad_flow/example_designs/simple_fpga_mul_test/inputs/mul.v:22.2-25.5" *)
  always @(posedge clk)
    R0_1 <= IN[0];
  assign { OUT[127:40], OUT[31:0] } = { 118'hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx, R0, R0_1 };
endmodule
