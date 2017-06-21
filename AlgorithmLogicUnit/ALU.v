//WARNING: valB op valA.
//when apply to sub, it is valB minus valA
//but when apply to greater, like jg %rA, %rB, it means jump if %rB-%rA > 0,
    //or if rB > rA
`timescale 1ns/1ps
`include "../header/head.v"


module ALU(
<<<<<<< HEAD
=======
    input CLK,
>>>>>>> YB
    output reg [`DATA_WID - 1:0]valE, //value after execute
    output reg [3:0]CC, //condition code
    input [1:0]ALUfun, //determine ALU function
    input [`DATA_WID - 1:0]ALUA, //input A
    input [`DATA_WID - 1:0]ALUB, //input B
    input set_cond
);
<<<<<<< HEAD
=======
/*
>>>>>>> YB
    always@(*) begin
        case(ALUfun)
            `_Add : begin
                valE = ALUB + ALUA;
            end
            `_Sub : begin
                valE = ALUB - ALUA;
<<<<<<< HEAD
=======

            end
            `_And : begin
                valE = ALUB & ALUA;
            end
            `_Or : begin
                valE = ALUB | ALUA;
            end
        endcase

        if (set_cond) begin
            CC[`ZF] = valE == 0;
            CC[`SF] = valE[`DATA_WID - 1] == 1;
            // signed overflow iff ALUA and ALUB have the same sign
            // but their result has a different sign
            CC[`OF] = ((ALUB[`DATA_WID - 1]^(ALUfun == `_Sub)) == ALUA[`DATA_WID - 1]) && (ALUB[`DATA_WID - 1] != valE[`DATA_WID - 1]);
            // unsigned overflow iff result less than one of operand
            CC[`CF] = (valE < ALUA);
        end
    end
    */

     always@(*) begin
        case(ALUfun)
            `_Add : begin
                valE = ALUB + ALUA;
            end
            `_Sub : begin
                valE = ALUB - ALUA;

>>>>>>> YB
            end
            `_And : begin
                valE = ALUB & ALUA;
            end
            `_Or : begin
                valE = ALUB | ALUA;
            end
        endcase
<<<<<<< HEAD
=======
    end
    always@(posedge CLK) begin
>>>>>>> YB
        if (set_cond) begin
            CC[`ZF] = valE == 0;
            CC[`SF] = valE[`DATA_WID - 1] == 1;
            // signed overflow iff ALUA and ALUB have the same sign
            // but their result has a different sign
            CC[`OF] = ((ALUB[`DATA_WID - 1]^(ALUfun == `_Sub)) == ALUA[`DATA_WID - 1]) && (ALUB[`DATA_WID - 1] != valE[`DATA_WID - 1]);
            // unsigned overflow iff result less than one of operand
            CC[`CF] = (valE < ALUA);
        end
    end
<<<<<<< HEAD
=======

>>>>>>> YB
endmodule

