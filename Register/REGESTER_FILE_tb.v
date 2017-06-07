`timescale 1ns/1ps
`include "head.v"
module REGISTER_FILE_TB(
);

    wire [`DATA_WID - 1:0] valA;
    wire [`DATA_WID - 1:0] valB;
    reg [`DATA_WID - 1:0] valE = 0;
    reg [`DATA_WID - 1:0] valM = 0;
    reg CLK = 0;
    wire [3:0]OUTA;
    wire [3:0]OUTB;
    wire [3:0]OUTE;
    wire [3:0]OUTM;
    reg [`ADDR_WID - 1:0] rA;
    reg [`ADDR_WID - 1:0] rB;
    reg [3:0] icode;
    reg Cnd;
    parameter period = 10;
    always begin
        #(period/2);
        CLK = ~CLK;
    end

    SRC_A src_a(
        .rA(rA),
        .icode(icode),
        .OUT(OUTA)
    );
    SRC_B src_b(
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
        //irmovq $(3) %rax
        icode = `_IRMOV;
        rA = `rdx_; //F
        rB = `rax_; //F
        valE = 3;
        valM = 4; //
        #10;
        //rrmovq %rax %rcx
        Cnd = 1;
        icode = `_RRMOV;
        rA = `rax_; //%rax
        rB = `rcx_; //F
        valE = 7; //
        valM = 15; //

        /*#10;
        //call $(35)
        icode = `_CALL;
        rA = `rcx_; //F
        rB = `NonReg_; //%rsp
        valE = 56;
        valM = 6; //
        
        #10;
        icode = `_PUSH;
        rA = `rax_;
        rB = `r11_; // ignore
        valE = 48;
        valM = 19;
        
        #10;
        icode = `_POP;
        rA = `rsi_;
        rB = `r10_;
        valE = 56;
        valM = 21;
        
     */   
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

