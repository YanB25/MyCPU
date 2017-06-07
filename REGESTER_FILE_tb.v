`timescale 1ns/1ps

`include "head.v"
module REGISTER_FILE_TB(
);

    wire [`DATA_WID - 1:0] valA = 0;
    wire [`DATA_WID - 1:0] valB = 0;
    reg [`DATA_WID - 1:0] valE = 0;
    reg [`DATA_WID - 1:0] valM = 0;
    reg [`ADDR_WID - 1:0] srcA = 0;
    reg [`ADDR_WID - 1:0] srcB = 0;
    reg [`ADDR_WID - 1:0] destE = 0;
    reg [`ADDR_WID - 1:0] destM = 0;
    reg [3:0]i = 0;
    reg [3:0]j = 0;
    reg [3:0]k = 0;
    reg CLK = 0;
    wire [3:0]OUTA;
    wire [3:0]OUTB;
    wire [3:0]OUTE;
    wire [3:0]OUTM;
    reg [`ADDR_WID - 1:0] rA;
    reg [`ADDR_WID - 1:0] rB;
    reg [3:0] icode;
    
    always begin
        #5;
        CLK = ~CLK;
    end

    SRC_A src_a(
        .rA(rA),
        .icode(icode),
        .OUT(OUTA)
    );
    SCR_B src_b(
        .rB(rB),
        .icode(icode),
        .OUT(OUTB)
    );
    DEST_E dest_e(
        .rB(rB),
        .icode(icode),
        .Cnd(Cnd),
        .OUT(OUTE)
    );
    DEST_M dest_m(
        .rA(rA),
        .icode(icode),
        .OUT(OUTM)
    );
    REGESTER_FILE regester_file(
        .CLK(CLK),
        .valA(valA),
        .valB(valB),
        .srcA(OUTA),
        .srcB(OUTB),
        .valE(valE),
        .valM(valM),
        .destE(OUTE),
        .destM(OUTM)
    );
    initial begin
        //irmovq $(10) %rax
        icode = `_IRMOV;
        scrA = 'rdx_; //F
        scrB = 'rsp_; //F
        destE = 'rax_; //%rax
        destM = 'rbx_; //F
        valE = 10;
        valM = 20; //not this

        #5;
        //rrmovq %rax %rcx
        icode = `_RRMOVQ;
        scrA = `rax_; //%rax
        srcB = `rcx_; //F
        destE = `rcx_; //%rcx
        destM = `rsi_; //F
        valE = 7; //
        valM = 9; //

        #5;
        //call $(35)
        icode = `_CALL;
        scrA = `rcx_; //F
        scrB = `NonReg_; //%rsp
        destE = `rsi_; //%rsp
        destM = `rax_; //F
        valE = 35;
        valM = 10; //
    end




    //integer number = 0;
    //initial begin
    //    #200;
    //  for (i = 4'b0000; i <= 4'b0011; i = i + 1) begin
    //        srcA = i;
    //        #5;
    //  for (j = 4'b1111; j >= 4'b0100; j = j - 1) begin
    //        srcB = j;
    //        #5;
    //    end
    //end

    //initial begin
//  //      #100;
    //  for (k = 4'b0000; k <= 4'b1111; k = k + 1) begin
    //        destE = k;
    //        destM = 15 - k;
    //        number = 10 * k;
    //        #1;
    //    end
    //end
    //assign valA = number;
    //assign valB = number;
endmodule

