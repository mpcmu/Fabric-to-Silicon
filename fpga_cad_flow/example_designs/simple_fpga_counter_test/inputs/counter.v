module counter(IN, OUT, clk);
	// FPGA IOs (for standard test IO harness)
    input [127:0] IN;
	output reg [127:0] OUT;
    input clk;

    // Test circut IO wires
    wire rst, up_down;
	wire [7:0] O;
    reg [3:0] count;

    // Assign to FPGA IO
    assign rst = IN[0];
    assign up_down = IN[1];

    //assign B = IN[15:8];
    always @(*) begin
        //OUT = 0;
        OUT[35:32] = count;
    end
    
	always @(posedge clk) begin
        if(rst)
            count <= 4'b0;
        else if (up_down)
            count <= count - 1;
        else
            count <= count + 1;
	end


endmodule




