// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "./../header/head.v"
`define SIZE_OF_MEMORY 10

module MEMORY(
    input wire CLK,
    input wire [`DATA_WID - 1 : 0] write_data,
    input wire [`DATA_WID - 1  : 0] addr,
    input wire write_flag,
    input wire read_flag,

    output reg [`DATA_WID - 1  : 0] valM,
    output wire dmem_error
);

reg [`DATA_WID - 1 :0] data[`SIZE_OF_MEMORY : 0];

assign dmem_error = (addr > `SIZE_OF_MEMORY)?1:0;


always@(posedge CLK) begin 
    if (write_flag == 1) begin
        data[addr] = write_data;
    end
    else begin
        data[addr] = data[addr];
    end

end

always@(*) begin
    if (read_flag == 1) begin
        valM = data[addr];
    end
    else begin
        valM = valM;
    end
end



endmodule // memory