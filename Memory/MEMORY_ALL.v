// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "./../header/head.v"


module MEMORY_ALL(
    input wire CLK,
    input reg [`DATA_WID - 1 : 0] valP,// input
    input reg [`DATA_WID - 1 : 0] valA,// input
    input reg [`DATA_WID - 1 : 0] valE,// input
    input reg [`ADDR_WID - 1 : 0] icode,// input
    input wire instr_valid ,//input
    input wire imem_error , //input

    output wire [`ADDR_WID - 1 : 0] stat,// output
    output wire [`DATA_WID - 1 : 0] valM// output
);



wire [`DATA_WID - 1 : 0] output_data;// wire
wire [`DATA_WID - 1 : 0] output_addr;// wire
wire write_flag;// wire
wire read_flag; // wire
wire dmem_error; // wire

assign instr_valid = 1;
assign imem_error = 0;

MEM_ADDR mem_addr1(
    .valE(valE),
    .valA(valA),
    .icode(icode),
    .OUT(output_addr)
);


MEM_DATA mem_data1(
    .valP(valP),
    .valA(valA),
    .icode(icode),
    .OUT(output_data)
);


MEM_READ mem_read1(
    .icode(icode),
    .read(read_flag)
);

MEM_WRITE mem_write1(
    .icode(icode),
    .write(write_flag)
);

MEMORY memory1(
    .CLK(CLK),
    .write_data(output_data),
    .addr(output_addr),
    .write_flag(write_flag),
    .read_flag(read_flag),

    .valM(valM),
    .dmem_error(dmem_error)
);

STAT stat1(
    .instr_valid(instr_valid),
    .imem_error(imem_error),
    .icode(icode),
    .dmem_error(dmem_error),
    .stat(stat)
);


endmodule // MEMORY_TB



