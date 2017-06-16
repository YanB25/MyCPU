`timescale 1ns/1ps
`include "./../header/head.v"
module INSTRU_MEM_ALL (
    output wire [3:0] icode;
    output wire [3:0] ifun;
    output wire[3:0] rA;
    output wire[3:0] rB;
    output wire [`DATA_WID - 1:0]valC;
    output wire Instr_valid;
    output wire imem_error,
);
    reg [`DATA_WID - 1: 0]PC,
    
    PC_INCRE pc_incre(
        .valP(valP),
        .icode(icode),
        .PC(PC)
    );
    
    INSTRU_MEN instru_men (
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );
endmodule
