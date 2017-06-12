`timescale 1ns/1ps
`include "head.v"
module PC_tb(
);

    reg CLK;
    reg valP;
    reg icode;
    reg Cnd;
    reg valC;
    reg valM;

    wire PC;
    
    initial begin
        CLK = 0;
    end
    always begin
        #(10 / 2);
        CLK = ~CLK;
    end

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

    initial begin
        //statement here
    end
endmodule
