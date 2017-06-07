`timescale 1ns/1ps
`include "head.v"
module INSTRU_MEN_tb (
);
    reg [`DATA_WID - 1: 0]PC;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire[3:0] rA;
    wire[3:0] rB;
    wire [`DATA_WID - 1:0]valC;
    
    initial begin
        PC = 0;
    end
    
    always begin
        #5;
        if (PC == 0)
            PC = 10;
        else
            PC = 0;
    end
    INSTRU_MEN instru_men (
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );
endmodule
