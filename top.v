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
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );


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
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),
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
