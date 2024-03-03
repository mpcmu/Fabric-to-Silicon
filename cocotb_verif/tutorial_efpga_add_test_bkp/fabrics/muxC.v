module Mux2C (in,sel,o);
	// cadence inline
	input [1:0] in;
	input sel;
	output o;
	assign o = in[sel];
endmodule

module Mux4C (in,sel,o);
	// cadence inline
	input [3:0] in;
	input [1:0] sel;
	output o;
	assign o = in[sel];
endmodule


module Mux8C (in,sel,o);
	// cadence inline
  	input [7:0] in;
   	input [2:0] sel;
	output o;
	assign o = in[sel];
endmodule


module Mux16C (in,sel,o);
	// cadence inline
   	input [15:0] in;
   	input [3:0] sel;
	output o;
	wire [1:0] oi;
	Mux8C m81(.in(in[15:8]), .sel(sel[2:0]), .o(oi[1]));
	Mux8C m82(.in(in[7:0]), .sel(sel[2:0]), .o(oi[0]));
	assign o = sel[3]? oi[1] : oi[0];
endmodule

module Mux32C (in,sel,o);
	// cadence inline
   	input [31:0] in;
   	input [4:0] sel;
	output o;
	wire [1:0] oi;
	Mux16C m16_1(.in(in[31:16]), .sel(sel[3:0]), .o(oi[1]));
	Mux16C m16_2(.in(in[15:0]), .sel(sel[3:0]), .o(oi[0]));
	assign o = sel[4]? oi[1] : oi[0];
endmodule
