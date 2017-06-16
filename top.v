// edit by wyf
// 2017/6/17
`include "./../header/head.v"
`define INS_LENGTH 2048
module cpu();

    reg [7:0]INSTRUCTION_MEM[0:`INS_LENGTH - 1];
    initial begin
        $readmemh("F:/code/MyCPU/Instrument/instrument_input.mem", INSTRUCTION_MEM);
        // $display("%h %h %h %h", INSTRUCTION_MEM[0], INSTRUCTION_MEM[1], INSTRUCTION_MEM[2], INSTRUCTION_MEM[3]);
    end

    INSTRU_MEN instru_men (
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );


    