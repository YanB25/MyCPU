`timescale 1ns/1ps
`include "head.v"

module ALU_tb(
);
    reg [DATA_WID - 1:0] valE;
    reg [3:0]CC;
    reg [1:0]ALUfun;
    reg [DATA_WID - 1:0]ALUA;
    reg [DATA_WID - 1:0]ALUB;

    ALU alu(
        .valE(vale),
        .CC(CC),
        .ALUfun(ALUfun),
        .ALUA(ALUA),
        .ALUB(ALUB)
    );

    initial begin
        for (ALUfun = 2'b00; ALUfun <= 2'b11; ++ALUfun) begin
            for (ALUA = 2'b00; ALUA < 2'b11; ++ALUA) begin
                for (ALUB = 2'b00; ALUB < 2'b11; ++ALUB) begin
                    #5;
                end
            end
        end
    end
endmodule
    
