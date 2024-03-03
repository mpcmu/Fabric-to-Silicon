module clbram(
    input [9:0] RA,
    input [9:0] WA,
    input [15:0] WD,
    input [1:0] WM,
    input  WE,
    input  RE,
    input C,
    output [15:0] Q);

    parameter MODE_RAM = 0;
endmodule

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

module clbalum(
    input [15:0] I1,
    input [15:0] I0,
    input [7:0] CTRL,
    input [31:0] IB32T,
    input [31:0] IB32R,
    input C,
    output [31:0] OB32,
    output [31:0] OB32R,
    output [15:0] Q);

    parameter MODE_ALU = 7;

    // MODE 0 - 32-bit pass through mode
    // MODE 1 - add/sub

endmodule
