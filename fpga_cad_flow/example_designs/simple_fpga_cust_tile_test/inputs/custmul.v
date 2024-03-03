module custmuleg(IN, OUT, clk);
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
    assign B = IN[32+15:32];
    always @(*) begin
        OUT[0] = R0_1;
        OUT[1] = R0;
        OUT[127:112] = O;
    end
    
    // Logic
    custmul #(
        .MODE_CUSTMUL(1)
    ) cmul (
        .I0   (A[15:0]  ), //i
        .I1   (B[15:0]  ), //i
        .Q    (O        ), //o
        .C    (clk      ) //i
    );
    
	always @(posedge clk) begin
			R0_1 <= A[0];
            R0 <= R0_1;
	end
    


endmodule




