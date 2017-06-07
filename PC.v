`timescale 1ns/1ps
`include "head.v"
module PC (
    input CLK,
    output reg [`DATA_WID - 1 : 0] NEW_PC,
    input [3:0]icode,
    input Cnd,
    input [`DATA_WID - 1 : 0] valC,
    input [`DATA_WID - 1 : 0] valM,
    input [`DATA_WID - 1: 0] valP
);
    initial begin
        NEW_PC = 0;
    end

    always @(posedge CLK) begin
        if (icode == `_CALL) begin
            NEW_PC = valC;
        end else if ((icode == `_JXX) && Cnd) begin
            NEW_PC = valC;
        end else if (icode == `_RET) begin
            NEW_PC = valM;
        end else begin
            NEW_PC = valP;
        end
    end
endmodule
