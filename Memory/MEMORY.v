// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "./../header/head.v"
`define SIZE_OF_MEMORY 96

module MEMORY(
    input wire CLK,
    input wire [`DATA_WID - 1 : 0] write_data,
    input wire [`DATA_WID - 1  : 0] addr,
    input wire write_flag,
    input wire read_flag,

    output reg [`DATA_WID - 1  : 0] valM,
    output wire dmem_error
);

reg [8 - 1 :0] data[`SIZE_OF_MEMORY : 0];

assign dmem_error = (addr > `SIZE_OF_MEMORY)?1:0;


always@(posedge CLK) begin 
    if (write_flag == 1) begin
        data[addr+7] = write_data[63:56];
        data[addr+6] = write_data[55:48];
        data[addr+5] = write_data[47:40];
        data[addr+4] = write_data[39:32];
        data[addr+3] = write_data[31:24];
        data[addr+2] = write_data[23:16];
        data[addr+1] = write_data[15:8];
        data[addr] = write_data[7:0];
    end
    else begin
        data[addr] = data[addr];
    end

end

always@(*) begin
    if (read_flag == 1) begin
        valM = data[addr];//
        valM[63:56] = data[addr+7]; 
        valM[55:48] = data[addr+6]; 
        valM[47:40] = data[addr+5]; 
        valM[39:32] = data[addr+4]; 
        valM[31:24] = data[addr+3]; 
        valM[23:16] = data[addr+2]; 
        valM[15:8] = data[addr+1]; 
        valM[7:0] = data[addr  ]; 
    end
    else begin
        valM = valM;
    end
end



endmodule // memory