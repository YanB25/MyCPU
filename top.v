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
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC)
    );
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
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),

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


    