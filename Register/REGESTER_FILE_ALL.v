`timescale 1ns/1ps
`include "head.v"
module REGISTER_FILE_ALL(
    input reg [`ADDR_WID - 1:0] rA;
    input reg [`ADDR_WID - 1:0] rB;
    input reg [3:0] icode;
    input reg Cnd;

    output wire [`DATA_WID - 1:0] valA;
    output wire [`DATA_WID - 1:0] valB;
    output reg [`DATA_WID - 1:0] valE = 0;
    output reg [`DATA_WID - 1:0] valM = 0;
);

    wire [3:0]OUTA;
    wire [3:0]OUTB;
    wire [3:0]OUTE;
    wire [3:0]OUTM;

    reg CLK = 0;
    parameter period = 10;
    always begin
        #(period/2);
        CLK = ~CLK;
    end


    SRC_A src_a(
        .rA(rA),
        .icode(icode),
        .OUT(OUTA)
    );
    SRC_B src_b(
        .rB(rB),
        .icode(icode),
        .OUT(OUTB)
    );
    DEST_E dest_e(
        .rB(rB),
        .icode(icode),
        .Cnd(Cnd),
        .OUT(OUTE)
    );
    DEST_M dest_m(
        .rA(rA),
        .icode(icode),
        .OUT(OUTM)
    );
    REGESTER_FILE regester_file(
        .CLK(CLK),
        .valA(valA),
        .valB(valB),
        .srcA(OUTA),
        .srcB(OUTB),
        .valE(valE),
        .valM(valM),
        .destE(OUTE),
        .destM(OUTM)
    );
    
endmodule

