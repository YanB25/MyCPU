<<<<<<< HEAD
// edit by wyf
// 2017/6/17
`include "./header/head.v"
`define INS_LENGTH 2048
module top();
    reg CLK = 0;
    parameter period = 10;
    always begin
        #(period/2);
        CLK = ~CLK;
    end

    reg [`DATA_WID - 1 : 0] PC;
    // always@(PC) begin
    //     PC 
    // end


    INSTRU_MEN instru_men (
=======
`timescale 1ns/1ps
`include "header/head.v"
module CPU(
    //input CLK
);
    //below for debug
        reg CLK = 0;
        parameter period = 10;
        always begin
            #(period / 2);
            CLK = ~CLK;
        end
    //below end
            
    wire [`DATA_WID - 1:0]PC;
    wire [3:0] icode;
    wire Cnd;
    wire [`DATA_WID - 1:0] valC;
    wire [`DATA_WID - 1:0] valM;
    wire [`DATA_WID - 1:0] valP;
    PC_MODULE pc_module(
        .CLK(CLK),
        .icode(icode),
        .Cnd(Cnd),
        .valC(valC),
        .valM(valM),
        .valP(valP),
        .PC(PC)
    );

    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    INSTRU_MEM_MODULE instru_mem_module(
>>>>>>> YB
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );
<<<<<<< HEAD
    PC_INCRE pc_incre(
        .valP(valP),
        .icode(icode),
        .PC(PC)
    );

    wire [`ADDR_WID - 1:0] rA;
    wire [`ADDR_WID - 1:0] rB;
    wire [`ADDR_WID - 1:0] icode;
    wire [`ADDR_WID - 1:0] ifun;
    wire [`DATA_WID - 1:0] valC;
    wire [`DATA_WID - 1:0] valA;
    wire [`DATA_WID - 1:0] valB;
    wire [`DATA_WID - 1:0] valP;
    wire [`DATA_WID - 1:0] valM;

    

    REGISTER_FILE_ALL register_file(
        .CLK(CLK),
        .rA(rA),
        .rB(rB),
        .icode(icode),

        .Cnd(Cnd),
        .valA(valA),
        .valB(valB),
        .valM(valM),
        .valE(valE),
);
    wire Cnd;

    ALU_ALL alu(
=======


    wire [`DATA_WID - 1:0] valE;
    wire [`DATA_WID - 1:0] valA;
    wire [`DATA_WID - 1:0] valB;
    REGISTER_FILE_MODULE register_file_module(
        .rA(rA),
        .rB(rB),
        .CLK(CLK),
        .icode(icode),
        .Cnd(Cnd),
        .valE(valE),
        .valM(valM),
        .valA(valA),
        .valB(valB)
    );

    ALU_MODULE alu_module(
        .CLK(CLK),
>>>>>>> YB
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),
<<<<<<< HEAD

        .valE(valE),
        .OUTCond(Cnd)
);
    wire [`ADDR_WID - 1:0] stat;

    MEMORY_ALL memory(
        .icode(icode),
        .valA(valA),
        .valP(valP),
        .valE(valE),
        .instr_valid(1),
        .imem_error(0),

        .valM(valM),
        .stat(stat)

);

    PC pc(
        .CLK(CLK),
        .NEW_PC(PC),
        .icode(icode),
        .Cnd(Cnd),
        .valC(valC),
        .valM(valM),
        .valP(valP)
    );
endmodule


    
=======
        .Cnd(Cnd),
        .valE(valE)
    );

    wire instr_valid = 1; // TODO
    wire imem_error = 0; //TODO
    wire [3:0] stat; // TODO
    
    MEMORY_MODULE memory_module(
        .CLK(CLK),
        .valP(valP),
        .valA(valA),
        .valE(valE),
        .icode(icode),
        .instr_valid(instr_valid),
        .imem_error(imem_error),
        .stat(stat),
        .valM(valM)
    );
endmodule
>>>>>>> YB
