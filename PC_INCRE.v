`timescale 1ns/1ps
`include "head.v"

module PC_INCRE (
    output reg[`DATA_WID - 1 : 0] valP,
    input [3:0] icode,
    input [`DATA_WID - 1 : 0] PC
);
    always@(*) begin
      case (icode)
      //halt : stop and increase 0
        `_HALT : valP = PC;
        `_NOP, `_RET : valP = PC + 1;
        `_RRMOV, `_OP, `_CMOVXX, `_PUSH, `_POP : valP = PC + 2;
        `_JXX, `_CALL : valP = 9;
        `_IRMOV, `_RMMOV, `_MRMOVQ : valP = PC + 10;
        default: 
            valP = PC;
      endcase
    end
endmodule
