// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "head.v"
`define SIZE_OF_MEMORY 100

module MEMORY(
    input wire [`DATA_WID - 1 : 0] write_data,
    input wire [`DATA_WID - 1  : 0] addr,
    input wire write_flag,
    input wire read_flag,

    output reg [`DATA_WID - 1  : 0] valM,
    output wire dmem_error
);

reg [`DATA_WID - 1 :0] data[`SIZE_OF_MEMORY : 0];

assign dmem_error = (addr > `SIZE_OF_MEMORY)?1:0;

always@(*) begin 
    case ( {write_flag, read_flag} )
        2'b01://read
            valM = data[addr];
        2'b10://write
            data[addr] = write_data;
        default://00 11 TODO: how to solve this situation?
            valM = valM;
    endcase
end



endmodule // memory