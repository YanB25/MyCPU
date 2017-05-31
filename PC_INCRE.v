`timescale 1ns/1ps
`include "head.v"

module PC_INCRE (
    output reg[`DATA_WID - 1 : 0] valP,
    input [3:0] icode
);
    always@(*) begin
      case (icode)
      //halt : stop and increase 0
        `_HALT : valP = 0;
        `_NOP, `_RET : valP = 1;
        `_RRMOV, `_OP, `_CMOVXX, `_PUSH, `_POP : valP = 2;
        `_JXX, `_CALL : valP = 9;
        `_IRMOV, `_RMMOV, `_MRMOVQ : valP = 10;
        default: 
            valP = 0;
      endcase
    end
endmodule
