//WARNING: valB op valA.
//when apply to sub, it is valB minus valA
//but when apply to greater, like jg %rA, %rB, it means jump if %rB-%rA > 0,
    //or if rB > rA
`timescale 1ns/1ps
`define BIT_WID 64 // bitwises for input/output
`include "head.v"


module ALU(
    output reg [BIT_WID - 1:0]valE, //value after execute
    output reg [3:0]CC, //condition code
    input [1:0]ALUfun, //determine ALU function
    input [BIT_WID - 1:0]ALUA, //input A
    input [BIT_WID - 1:0]ALUB, //input B
    input set_cond
)
    always@(*) begin
        case(ALUfun)
            _Add : begin
                valE = ALUB + ALUA;
            end
            _Sub : begin
                valE = ALUB - ALUA;
            end
            _And : begin
                valE = ALUB & ALUA;
            end
            _Or : begin
                valE = ALUB | ALUA;
            end
        endcase
        if (set_cond) begin
            CC[ZF] = valE == 0;
            CC[SF] = valE[BIT_WID - 1] == 1;
            // signed overflow iff ALUA and ALUB have the same sign
            // but their result has a different sign
            CC[OF] = (ALUB[BIT_WID - 1] == ALUA[BIT_WID - 1]) && (ALUB[BIT_WID - 1] != valE[BIT_WID - 1]);
            // unsigned overflow iff result less than one of operand
            CC[CF] = valE < valA;
        end
    end
endmodule

