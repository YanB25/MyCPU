// combinational circuit when read data
// sequential circuit when write data
`timescale 1ns/1ps
`include "../header/head.v"

module REGESTER_FILE (
    input CLK,
    // for read data from srcA and srcB
    output reg[`DATA_WID - 1:0]valA,
    output reg[`DATA_WID - 1:0]valB,
    input [`ADDR_WID - 1:0]srcA,
    input [`ADDR_WID - 1:0]srcB,
    // for write data to register destE and destM
    input [`DATA_WID - 1:0]valE,
    input [`DATA_WID - 1:0]valM,
    input [`ADDR_WID - 1:0]destE,
    input [`ADDR_WID - 1:0]destM

);
    // TODO: maybe bug, can not initial reg data
    initial begin
        //TODO: change the number
        data[`rsp_] = 64;
    end
    reg [`DATA_WID - 1:0]data[`NUM_OF_REG - 1 : 0];
    always@(posedge CLK) begin
        data[destE] = valE;
        data[destM] = valM;
        //$display("abc: %h %h %h %h %0t", destE, destM, valE, valM, $time);
    end
    always@(*) begin
        valA = data[srcA];
        valB = data[srcB];
        //$display("combination: %h %h %h %h", srcA, srcB, valA, valB);
    end

endmodule
