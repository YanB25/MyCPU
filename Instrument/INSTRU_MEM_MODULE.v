`timescale 1ns/1ps
`include "./../header/head.v"
module INSTRU_MEM_MODULE (
    input [`DATA_WID - 1: 0]PC,
    output [3:0] icode,
    output [3:0] ifun,
    output [3:0] rA,
    output [3:0] rB,
    output [`DATA_WID - 1:0]valC
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
