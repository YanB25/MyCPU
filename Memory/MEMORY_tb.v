// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "head.v"


module MEMORY_TB();

reg [`DATA_WID - 1 : 0] valP;// input
reg [`DATA_WID - 1 : 0] valA;// input
reg [`DATA_WID - 1 : 0] valE;// input
reg [`ADDR_WID - 1 : 0] icode;// input
wire instr_valid ;//input
wire imem_error ; //input

wire [`ADDR_WID - 1 : 0] stat;// output
wire [`DATA_WID - 1 : 0] valM;// output


wire [`DATA_WID - 1 : 0] output_data;// wire
wire [`DATA_WID - 1 : 0] output_addr;// wire
wire write_flag;// wire
wire read_flag; // wire
wire dmem_error; // wire


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

assign instr_valid = 1;
assign imem_error = 0;

initial begin
        icode = 4'h4;
        valE = 8'h00;
        valA = 8'h00;
        valP = 8'h20;
    #10;     
        icode = 4'h4;
        valE = 8'h01;
        valA = 8'h11;
        valP = 8'h20;
    #10;
        icode = 4'h4;
        valE = 8'h02;
        valA = 8'h22;
        valP = 8'h20;
    #10;
        icode = 4'h4;
        valE = 8'h03;
        valA = 8'h33;
        valP = 8'h20;
    #10;
        icode = 4'h4;
        valE = 8'h04;
        valA = 8'h44;
        valP = 8'h20;
    #10;
        icode = 4'h4;
        valE = 8'h05;
        valA = 8'h55;
        valP = 8'h20;
    #10;
        icode = 4'h4;
        valE = 8'h06;
        valA = 8'h66;
        valP = 8'h20;
    #10;
        icode = 4'h4;//rmmov
        valE = 8'h07;
        valA = 8'h77;
        valP = 8'h20;
    #10;
// initialize memory from  01 to 07
 
        icode = 4'h5;//mrmov
        valE = 8'h03;
        valA = 8'h30;
        valP = 8'h20;
    #10;
        icode = 4'hA;//push
        valE = 8'h08;
        valA = 8'h30;
        valP = 8'h20;
    #10;
        icode = 4'hB;//pop
        valE = 8'h40;
        valA = 8'h08;
        valP = 8'h20;
    #10;
        icode = 4'h8;//call
        valE = 8'h09;
        valA = 8'h30;
        valP = 8'h99;
    #10;
        icode = 4'h9;//ret
        valE = 8'h09;
        valA = 8'h09;
        valP = 8'h20;
    #10;

end 

endmodule // MEMORY_TB



