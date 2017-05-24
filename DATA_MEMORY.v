`timescale 1ns/1ps
`include "head.v"
module DATA_MEMORY(
    input CLK,

    input MemRead,
    input MemWrite,

    input [DATA_WID - 1:0]MemAddr,
    input [DATA_WID - 1:0]MemData,

    output [DATA_WID - 1:0]valM
);
