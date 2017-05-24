`include "head.v"
`define INS_LENGTH 2048
module INSTRU_MEN (
    input [`DATA_WID - 1: 0]PC,
    output [3:0]icode,
    output [3:0]ifun,
    output [3:0]rA,
    output [3:0]rB,
    output [`DATA_WID - 1: 0]valC
);
    wire [7:0]INSTRUCTION;
    wire [7:0]REGISTER;
    reg [7:0]INSTRUCTION_MEM[0:`INS_LENGTH - 1];
    initial begin
        $readmemh("instrument_input", INSTRUCTION_MEM);
    end
    always@(*) begin
        INSTRUCTION = INSTRUCTION_MEM[PC];
        REGISTER = INSTRUCTION_MEM[PC + 1];
        valC = INSTRUCTION_MEM[PC + 2:PC + 9];
        ifun = INSTRUCTION[3:0];
        icode = INSTRUCTION[7:4];
        rB = REGISTER[3:0];
        rA = REGISTER[7:4];
    end
endmodule
