`timescale 1ns/1ps
`include "../header/head.v"

module SRC_A(
    input [`ADDR_WID - 1: 0]rA,
    input [3:0] icode,
    output reg [3:0] OUT
);
    always@(*) begin
        case(icode)
            `_IRMOV, `_MRMOV, `_JXX, `_CALL:
                OUT = `NonReg_;
            `_POP, `_RET :
                OUT = `rsp_;
            default :
                OUT = rA;
        endcase
    end
endmodule

module SRC_B(
    input [`ADDR_WID - 1: 0] rB,
    input [3:0] icode,
    output reg [3:0] OUT
);
    always@(*) begin
        case (icode)
            `_RRMOV, `_IRMOV, `_JXX :
                OUT = `NonReg_;
            `_PUSH, `_POP, `_CALL, `_RET :
                OUT = `rsp_;
            default :
                OUT = rB;
        endcase
    end
endmodule

module DEST_E(
    input [`ADDR_WID - 1:0] rB,
    input [3:0] icode,
    input Cnd,
    output reg [3:0] OUT
);
    always@(*) begin
        case(icode)
            `_CMOVXX : begin
                if (Cnd) begin
                    OUT = rB;
                end else begin
                    OUT = `NonReg_;
                end
            end
            `_RMMOV, `_MRMOV, `_JXX :
                OUT = `NonReg_;
            `_PUSH, `_POP, `_CALL, `_RET :
                OUT = `rsp_;
            default :
                OUT = rB;
        endcase
    end
endmodule

module DEST_M(
    input [`ADDR_WID - 1: 0] rA,
    input [3:0] icode,
    output reg [3:0] OUT
);
    always@(*) begin
        case(icode)
            `_MRMOV, `_POP :
                OUT = rA;
            default :
                OUT = `NonReg_;
        endcase
    end
endmodule







