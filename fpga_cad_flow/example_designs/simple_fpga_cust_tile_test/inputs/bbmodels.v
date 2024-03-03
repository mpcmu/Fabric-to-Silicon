module clbalu(
    input [15:0] I1,
    input [15:0] I0,
    input [7:0] CTRL,
    input R,
    input CIN,
    input C,
    output COUT,
    output [15:0] Q);

    parameter MODE_ALU = 0;

    // MODE 0 - 32-bit pass through mode
    // MODE 1 - add/sub

endmodule

module custmul(
    input [15:0] I1,
    input [15:0] I0,
    input C,
    output [15:0] Q);

    parameter MODE_CUSTMUL = 7;

endmodule
