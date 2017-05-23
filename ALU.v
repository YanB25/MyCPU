//WARNING: valB op valA.
//when apply to sub, it is valB minus valA
`timescale 1ns/1ps
`define BIT_WID 64 // bitwises for input/output

`define _Add 2'b00
`define _Sub 2'b01
`define _And 2'b10
`define _Or 2'b11

// both used in [1:0]CC as index
// ZF for zero flag: whether the operation results in a zero
// SF for sign flag: whether get a negetive result
// OF for overflow flag: whether signed numbers cause an overflow
// CF for carry flag: whether unsigned numbers cause an overflow
`define ZF 0 
`define SF 1
`define OF 2
`define CF 3

module ALU(
    output wire [BIT_WID - 1:0]valE, //value after execute
    output wire [3:0]CC, //condition code
    input [1:0]ALUfun, //determine ALU function
    input [BIT_WID - 1:0]ALUA, //input A
    input [BIT_WID - 1:0]ALUB //input B
)
    always@(*) begin
        case(ALUfun) begin
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
    CC[ZF] = valE == 0;
    CC[SF] = valE[BIT_WID - 1] == 1;
    // signed overflow iff ALUA and ALUB have the same sign
    // but their result has a different sign
    CC[OF] = (ALUB[BIT_WID - 1] == ALUA[BIT_WID - 1]) && (ALUB[BIT_WID - 1] != valE[BIT_WID - 1]);
    // unsigned overflow iff result less than one of operand
    CC[CF] = valE < valA;
    end
endmodule

