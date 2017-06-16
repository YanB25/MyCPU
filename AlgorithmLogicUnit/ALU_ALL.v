`timescale 1ns/1ps
`include "../header/head.v"

module ALU_ALL(
    input reg [3:0] icode,
    input reg [3:0] ifun,
    input reg [`DATA_WID - 1:0]valA,
    input reg [`DATA_WID - 1:0]valB,
    input reg [`DATA_WID - 1:0]valC,

    output wire [`DATA_WID - 1:0]valE,
    output wire OUTCond
);

    wire [`DATA_WID - 1:0]OUTA;

    ALUA alua(
        .valA(valA),
        .valC(valC),
        .icode(icode),
        .OUT(OUTA)
    );

    wire [`DATA_WID - 1:0]OUTB;
    ALUB alub(
        .valB(valB),
        .valC(valC),
        .icode(icode),
        .OUT(OUTB)
    );

    wire [1:0]OUTALUFun;
    ALUFUN alufun(
        .icode(icode),
        .ifun(ifun),
        .OUT(OUTALUFun)
    );


    wire OUTSet_cc;
    SET_CC set_cc(
        .icode(icode),
        .OUT(OUTSet_cc)
    );
    

    wire [3:0]CC;
    COND cond(
        .ifun(ifun),
        .CC(CC),
        .OUT(OUTCond)
    );


    ALU alu(
        .valE(valE),
        .CC(CC),
        .ALUfun(OUTALUFun),
        .ALUA(OUTA),
        .ALUB(OUTB),
        .set_cond(OUTSet_cc)
    );
endmodule
    
