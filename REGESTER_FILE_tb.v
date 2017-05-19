`timescale 1ns/1ps

`include "head.v"
module REGISTER_FILE_TB(
);
    reg [`DATA_WID - 1:0] valA, valB, valE, valM;
    reg [`ADDR_WID - 1:0] srcA, srcB, destE, destM;
    reg [3:0]i;
    reg [3:0]j;
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
    initial begin
        for (i = 4'b0000; i <= 4'b0011; ++i) begin
            valA = 10 + 5 * i;
            srcA = i;
            #5;
        end
        for (j = 4'b1111; j >= 4'b0100; --j) begin
            valB = 10 + 5 * j;
            srcB = j;
            #5;
        end
    end

    initial begin
        #100;
        for (k = 4'b0000; k <= 4'b1111; k++) begin
            destE = k;
            destM = 15 - k;
            #1;
        end
    end
endmodule

