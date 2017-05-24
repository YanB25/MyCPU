`include "head.v"
module INSTRU_MEN_tb {
);
    wire PC;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire[3:0] rA;
    wire[3:0] rB;
    wire [`DATA_WID - 1:0]valc;
    
    assign PC = 0;
    INSTRU_MEN instru_men (
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );
endmodule
