`timescale 1ns/1ps
`include "./../header/head.v"
`define INS_LENGTH 2048
module INSTRU_MEN (
    input [`DATA_WID - 1: 0]PC,
    output reg[3:0]icode,
    output reg[3:0]ifun,
    output reg[3:0]rA,
    output reg[3:0]rB,
    output reg[`DATA_WID - 1: 0]valC
);
    reg [7:0]INSTRUCTION;
    reg [7:0]REGISTER;
    //parameter [7:0] lsfr_taps [0 : 1024]   = '{8'd9, 8'd5, 8'd3, 8'h21, 8'd9, 8'd9, 8'd5, 8'd9};
    reg [7:0]INSTRUCTION_MEM[0:`INS_LENGTH - 1];
    initial begin
        $readmemh("F:/code/MyCPU/Instrument/instrument_input.mem", INSTRUCTION_MEM);
        $display("%h %h %h %h", INSTRUCTION_MEM[0], INSTRUCTION_MEM[1], INSTRUCTION_MEM[2], INSTRUCTION_MEM[3]);
    end
    always@(*) begin
        $display("PC %h", PC[3:0]);
        INSTRUCTION = INSTRUCTION_MEM[PC];
        //$display("IN %h %h", INSTRUCTION, PC);
        REGISTER = INSTRUCTION_MEM[PC + 1];
        //$display("RE %h", REGISTER);
        
        // TODO: bug
        if (icode == `_JXX || icode == `_CALL) begin
            valC[7:0] = INSTRUCTION_MEM[PC + 1];
            valC[15:8] = INSTRUCTION_MEM[PC + 2];
            valC[23:16] = INSTRUCTION_MEM[PC + 3];
            valC[31:24] = INSTRUCTION_MEM[PC + 4];
            valC[39:32] = INSTRUCTION_MEM[PC + 5];
            valC[47:40] = INSTRUCTION_MEM[PC + 6];
            valC[55:48] = INSTRUCTION_MEM[PC + 7];
            valC[63:56] = INSTRUCTION_MEM[PC + 8];
        end else begin
            valC[7:0] = INSTRUCTION_MEM[PC + 2];
            valC[15:8] = INSTRUCTION_MEM[PC + 3];
            valC[23:16] = INSTRUCTION_MEM[PC + 4];
            valC[31:24] = INSTRUCTION_MEM[PC + 5];
            valC[39:32] = INSTRUCTION_MEM[PC + 6];
            valC[47:40] = INSTRUCTION_MEM[PC + 7];
            valC[55:48] = INSTRUCTION_MEM[PC + 8];
            valC[63:56] = INSTRUCTION_MEM[PC + 9];
        end
        //
        ifun = INSTRUCTION[3:0];
        icode = INSTRUCTION[7:4];
        rB = REGISTER[3:0];
        rA = REGISTER[7:4];
    end
endmodule
