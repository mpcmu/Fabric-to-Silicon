`define KYBER_Q      16'd3329
`define QINV        -16'd3327

module fqmul (a_in_mul, b_in_mul, c_out_mul);

    input signed [15:0] a_in_mul, b_in_mul;
    output signed [15:0] c_out_mul;

    wire signed [31:0] prod;
    assign prod = a_in_mul * b_in_mul;

    wire signed [31:0] prod1;
    assign prod1 = prod[15:0] * `QINV;

    wire signed [15:0] t;
    assign t = prod1[15:0];

    wire signed [15:0] t1;
    assign t1 = `KYBER_Q;

    wire signed [31:0] prod2;
    assign prod2 = t * t1;

    wire signed [31:0] prod3;
    assign prod3 = prod - prod2;

    assign c_out_mul = prod3[31:16];

endmodule