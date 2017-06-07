`timescale 1ns/1ps

`include "head.v"
module REGISTER_FILE_TB(
);
//    wire [`DATA_WID - 1:0] valA ;
//    wire [`DATA_WID - 1:0] valB ;
//    reg [`DATA_WID - 1:0] valE ;
//    reg [`DATA_WID - 1:0] valM ;
//    reg [`ADDR_WID - 1:0] srcA ;
//    reg [`ADDR_WID - 1:0] srcB ;
//    reg [`ADDR_WID - 1:0] destE ;
//    reg [`ADDR_WID - 1:0] destM ;
//    reg CLK;
////    reg [3:0]i = 0;
////    reg [3:0]j = 0;
////    reg [3:0]k = 0;

    
    
//    always begin
//        #5;
//        CLK = ~CLK;
//    end
    
//    REGESTER_FILE regester_file(
//        .CLK(CLK),
//        .valA(valA),
//        .valB(valB),
//        .srcA(srcA),
//        .srcB(srcB),
//        .valE(valE),
//        .valM(valM),
//        .destE(destE),
//        .destM(destM)
//    );
//    initial begin
//        CLK = 0;
//        destE = 0;
//        valE = 0;
//        destM = 0;
//        valM = 0;
//        #200; srcA = 2;
//        #200; srcB = 5;
//    end
//    integer index = 0;
//    initial begin
//        for(index = 0; index < 16; index = index + 1) begin
//            if (index == 0) begin
//                 #10;
//            end
//            else begin
//                destE = destE + 1;
//                valE = valE + 1;
//                #10;
//             end
//        end
//    end



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
    always begin
        #5;
        CLK = ~CLK;
    end
    REGESTER_FILE regester_file(
        .CLK(CLK),
        .valA(valA),
        .valB(valB),
        .srcA(srcA),
        .srcB(srcB),
        .valE(valE),
        .valM(valM),
        .destE(destE),
        .destM(destM)
    );
    integer number = 0;
    initial begin
        #200;
      for (i = 4'b0000; i <= 4'b0011; i = i + 1) begin
            srcA = i;
            #5;
        end
      for (j = 4'b1111; j >= 4'b0100; j = j - 1) begin
            srcB = j;
            #5;
        end
    end

    initial begin
//        #100;
      for (k = 4'b0000; k <= 4'b1111; k = k + 1) begin
            destE = k;
            destM = 15 - k;
            number = 10 * k;
            #1;
        end
    end
    assign valA = number;
    assign valB = number;
endmodule

