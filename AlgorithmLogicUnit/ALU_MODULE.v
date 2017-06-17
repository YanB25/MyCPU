`timescale 1ns/1ps
`include "../header/head.v"

module ALU_MODULE(
    input CLK,
    input [3:0] icode,
    input [3:0] ifun,
    input [`DATA_WID - 1:0]valA,
    input [`DATA_WID - 1:0]valB,
    input [`DATA_WID - 1:0]valC,
    output Cnd,
    output [`DATA_WID - 1:0]valE
);
    wire [`DATA_WID - 1:0]OUTA;
    wire [`DATA_WID - 1:0]OUTB;
    wire [1:0]OUTALUFun;
    wire OUTSet_cc;
    wire OUTCond;
    wire [3:0]CC;

    assign Cnd = OUTCond;

    ALUA alua(
        .valA(valA),
        .valC(valC),
        .icode(icode),
        .OUT(OUTA)
    );

    ALUB alub(
        .valB(valB),
        .valC(valC),
        .icode(icode),
        .OUT(OUTB)
    );

    ALUFUN alufun(
        .icode(icode),
        .ifun(ifun),
        .OUT(OUTALUFun)
    );


    SET_CC set_cc(
        .icode(icode),
        .OUT(OUTSet_cc)
    );
    
    COND cond(
        .ifun(ifun),
        .CC(CC),
        .OUT(OUTCond)
    );

    ALU alu(
        .CLK(CLK),
        .valE(valE),
        .CC(CC),
        .ALUfun(OUTALUFun),
        .ALUA(OUTA),
        .ALUB(OUTB),
        .set_cond(OUTSet_cc)
    );
endmodule
    
