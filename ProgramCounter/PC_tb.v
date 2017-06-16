`timescale 1ns/1ps
`include  "../header/head.v"
module PC_tb(
);

    reg CLK;
    wire [`DATA_WID - 1:0]valP;
    reg [3:0]icode;
    reg Cnd;
    reg [`DATA_WID - 1:0]valC;
    reg [`DATA_WID - 1:0]valM;

    wire [`DATA_WID - 1:0]PC;
    
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
        /*
        icode = `_RMMOV;
        #10;
        icode = `_IRMOV;
        #10;
        icode = `_OP;
        #10;
        */
        
        /*icode = `_JXX;
        Cnd = 1;
        valC = 64;
        #10;
        icode = `_JXX;
        Cnd = 0;
        valC = 80;
        #10;
        */
        icode = `_CALL;
        valC = 8;
        #10;
        icode = `_RET;
        valM = 16;
        #10;
        icode = `_HALT;
    end
endmodule
