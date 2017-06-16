`timescale 1ns/1ps
`include  "../header/head.v"
module PC_ALL(
    input CLK,
    input reg [3:0]icode,
    input reg Cnd,
    input reg [`DATA_WID - 1:0]valC,
    input reg [`DATA_WID - 1:0]valM,
    input wire [`DATA_WID - 1:0]valP,

    output wire [`DATA_WID - 1:0]PC
);

    
    // initial begin
    //     CLK = 0;
    // end
    // always begin
    //     #(10 / 2);
    //     CLK = ~CLK;
    // end

    // PC_INCRE pc_incre(
    //     .valP(valP),
    //     .icode(icode),
    //     .PC(PC)
    // );

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
