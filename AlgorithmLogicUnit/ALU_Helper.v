`timescale 1ns/1ps
`include "../header/head.v"

module ALUA(
    input [`DATA_WID - 1:0]valA,
    input [`DATA_WID - 1:0]valC,
    input [3:0]icode,
    output reg [`DATA_WID - 1:0]OUT
);
    always@(*) begin
        case(icode)
            `_OP, `_RRMOV, `_CMOVXX : OUT = valA;
            `_RMMOV, `_IRMOV, `_MRMOV : OUT = valC;
            `_PUSH, `_POP, `_CALL, `_RET : OUT = 8;
            default : OUT = 0;// JXX
        endcase
    end
endmodule

module ALUB(
    input [`DATA_WID - 1:0] valB,
    input [`DATA_WID - 1:0] valC,
    input [3:0]icode,
    output reg[`DATA_WID - 1:0]OUT
);

    always@(*) begin
        case(icode)
            `_OP, `_RMMOV, `_MRMOV, `_PUSH, `_POP, `_CALL, `_RET : OUT = valB;
            default : OUT = 0;
        endcase
    end
endmodule

module ALUFUN(
    input [3:0]icode,
    input [3:0]ifun,
    output reg [1:0]OUT
);
    always@(*) begin
        case(icode)
            `_RRMOV, `_RMMOV, `_IRMOV, `_MRMOV, `_POP, `_RET, `_CMOVXX : OUT = `_Add;
            `_PUSH, `_CALL : OUT = `_Sub;
            default : OUT = ifun; //Jxx come here
        endcase
    end
endmodule

module SET_CC(
    input [3:0]icode,
    //input [3:0]ifun,
    output reg OUT
);
    always@(*) begin
        OUT = (icode == `_OP);
    end
endmodule

module COND(
    //input [3:0]icode,
    input [3:0]ifun,
    input [3:0]CC,
    output reg OUT
);
    wire [6:0]Rels; //NonCond always true
    assign Rels[`NonCond] = 1;
    assign Rels[`REL_E] = CC[`ZF];
    assign Rels[`REL_NE] = ~CC[`ZF];
    assign Rels[`REL_L] = CC[`SF] ^ CC[`OF]; // xor
    assign Rels[`REL_GE] = ~Rels[`REL_L];
    assign Rels[`REL_G] = Rels[`REL_GE] & (~CC[`ZF]);
    assign Rels[`REL_LE] = Rels[`REL_L] | CC[`ZF];
    
    always@(*) begin
        OUT = Rels[ifun];
    end
endmodule
            
