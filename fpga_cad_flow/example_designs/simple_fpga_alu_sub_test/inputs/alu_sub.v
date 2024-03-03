module alu_sub(IN, OUT, clk);
	// FPGA IOs (for standard test IO harness)
    input [127:0] IN;
	output reg [127:0] OUT;
    input clk;

    // Test circut IO wires
    wire [15:0] A, B;
	wire [15:0] O;
    reg R0, R0_1;

    // Assign to FPGA IO
    assign A = IN[15:0];
    assign B = IN[31:16];
    always @(*) begin
        //OUT = 0;
        OUT[47:32] = O;
        OUT[0] = R0_1;
        OUT[1] = R0;
    end
    
	always @(posedge clk) begin
			R0_1 <= A[0];
            R0 <= R0_1;
	end

    clbalu #(
        .MODE_ALU(1)
    ) alu (
        .CTRL (8'h00          ), //i
        .I0   (A[15:0]   ), //i
        .I1   (B[15:0]  ), //i
        .Q    (O              ), //o
        .C    (clk            ) //i
 
    );


endmodule




