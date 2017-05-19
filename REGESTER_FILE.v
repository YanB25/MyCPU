// combinational circuit when read data
// sequential circuit when write data
`include "head.v"

module REGESTER_FILE (
    input CLK,
    // for read data from srcA and srcB
    output [DATA_WID - 1:0]valA,
    output [DATA_WID - 1:0]valB,
    input [ADDR_WID - 1:0]srcA,
    input [ADDR_WID - 1:0]srcB,
    // for write data to register destE and destM
    input [DATA_WID - 1:0]valE,
    input [DATA_WID - 1:0]valM,
    input [ADDR_WID - 1:0]destE,
    input [ADDR_WID - 1:0]destM

);
    // TODO: maybe bug, can not initial reg data
    reg [DATA_WID - 1:0]data[NUM_OF_REG - 1:0];
    always@(*) begin
        valA = data[srcA];
        valB = data[srcB];
    end
    always@(posedge CLK) begin
        data[destE] = valE;
        data[destM] = valM;
    end
endmodule
