`timescale 1ns/1ps
`include "head.v"
module REGISTER_FILE_MODULE(
    input [`ADDR_WID - 1:0] rA,
    input [`ADDR_WID - 1:0] rB,
    input CLK,
    input [3:0] icode,
    input Cnd,
    output [`DATA_WID - 1:0] valA,
    output [`DATA_WID - 1:0] valB,
    input [`DATA_WID - 1:0] valE,
    input [`DATA_WID - 1:0] valM
);

    wire [3:0]OUTA;
    wire [3:0]OUTB;
    wire [3:0]OUTE;
    wire [3:0]OUTM;

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

