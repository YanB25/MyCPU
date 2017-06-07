// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "head.v"

module MEMORY(
    input wire ['ADDR_WID - 1 : 0] valA;
    input wire ['ADDR_WID - 1 : 0] valB;
    input wire ['ADDR_WID - 1 : 0] valE;
    input wire ['ADDR_WID - 1 : 0] icode;

    output wire ['ADDR_WID - 1 : 0] valM ;
);



endmodule // memory