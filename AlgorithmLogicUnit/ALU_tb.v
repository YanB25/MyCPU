`timescale 1ns/1ps
`include "../header/head.v"

module ALU_tb(
);
    reg [3:0] icode;
    reg [3:0] ifun;
    reg [`DATA_WID - 1:0]valA;
    reg [`DATA_WID - 1:0]valB;
    reg [`DATA_WID - 1:0]valC;
    wire [`DATA_WID - 1:0]OUTA;
    ALUA alua(
        .valA(valA),
        .valC(valC),
        .icode(icode),
        .OUT(OUTA)
    );

    wire [`DATA_WID - 1:0]OUTB;
    ALUB alub(
        .valB(valB),
        .valC(valC),
        .icode(icode),
        .OUT(OUTB)
    );

    wire [1:0]OUTALUFun;
    ALUFUN alufun(
        .icode(icode),
        .ifun(ifun),
        .OUT(OUTALUFun)
    );


    wire OUTSet_cc;
    SET_CC set_cc(
        .icode(icode),
        .OUT(OUTSet_cc)
    );
    
    wire OUTCond;
    wire [3:0]CC;
    COND cond(
        .ifun(ifun),
        .CC(CC),
        .OUT(OUTCond)
    );

    wire [`DATA_WID - 1:0]valE;
    ALU alu(
        .valE(valE),
        .CC(CC),
        .ALUfun(OUTALUFun),
        .ALUA(OUTA),
        .ALUB(OUTB),
        .set_cond(OUTSet_cc)
    );

    initial begin
        // for (ALUfun = 2'b00; ALUfun <= 2'b11; ++ALUfun) begin
        //     for (ALUA = 2'b00; ALUA < 2'b11; ++ALUA) begin
        //         for (ALUB = 2'b00; ALUB < 2'b11; ++ALUB) begin
        //             #5;
        //         end
        //     end
        // end
        valC = 0;

        icode = `_OP;
        ifun = `_Add;
        valA = 3;
        valB = 5;

#5;
        icode = `_OP;
        ifun = `_Sub;
        valB = 10;
        valA = 4;

#5;
        //maybe BUG test minus
        icode = `_OP;
        ifun = `_Sub;
        valB = 4;
        valA = 10;

#5;
        icode = `_OP;
        ifun = `_And;
        valA = 1;
        valB = 2;

#5;
        icode = `_PUSH;
        ifun = 0;
        valA = 3; //ignore
        valB = 64; //suppose to -8

#5;
        icode = `_POP;
        ifun = 0;
        valA = 5; //ignore
        valB = 32; // suppose to +8;

#5;
        icode = `_IRMOV;
        ifun = 0;
        valA = 1; //ig
        valB = 2; //ig
        valC = 16;

        //below are more complex test
#5;
        icode = `_OP;
        ifun = `_Sub;
        valA = 5;
        valB = 4;
#5;
        icode = `_CMOVXX;
        ifun = `REL_E;
        valA = 2;
        valB = 4; //ig

#5;
        icode = `_CMOVXX;
        ifun = `REL_L;
        valA = 4;
        valB = 8; //ig

#5;
        icode = `_JXX;
        ifun = `NonCond;

#5;
        icode = `_JXX;
        ifun = `REL_GE;
      
    end
endmodule
    
