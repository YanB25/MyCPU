`timescale 1ns/1ps
`include  "../header/head.v"
module PC_MODULE(
    input CLK,
    output [`DATA_WID - 1:0]valP,
    output [`DATA_WID - 1:0]PC,
    input [3:0]icode,
    input Cnd,
    input [`DATA_WID - 1:0] valC,
    input [`DATA_WID - 1:0] valM

);
    
    PC_INCRE pc_incre(
        .valP(valP),
        .icode(icode),
        .PC(PC)
    );

    PC pc(
        .CLK(CLK),
        .NEW_PC(PC),
        .icode(icode),
        .Cnd(Cnd),
        .valC(valC),
        .valM(valM),
        .valP(valP)
    );

endmodule
