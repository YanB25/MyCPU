//ADDR_WID means address width
// the length of index for _REG_CODE_
`define DATA_WID 64
`define ADDR_WID 4
//below defines some codes for registers
`ifndef _REG_CODE_
    `define _REG_CODE_ 0
    `define NUM_OF_REG 16
    `define rax_  4'b0000
    `define rcx_ 4'b0001
    `define rdx_ 4'b0010
    `define rbx_ 4'b0011
    `define rsp_ 4'b0100
    `define rbp_ 4'b0101
    `define rsi_ 4'b0110
    `define rdi_ 4'b0111
    `define r8_ 4'b1000
    `define r9_ 4'b1001
    `define r10_ 4'b1010
    `define r11_ 4'b1011
    `define r12_ 4'b1100
    `define r13_ 4'b1101
    `define r14_ 4'b1110
    `define NonReg_ 4'b1111
`endif

//below defines some codes for flags
`ifndef _CONST_FLAG_
    `define _CONST_FLAG_ 0
    `define _HALT 4'b0000
    `define _NOP 4'b0001
    `define _RRMOV 4'b0010
    `define _IRMOV 4'b0011
    `define _RMMOV 4'b0100
    `define _MRMOV 4'b0101
    `define _OP 4'b0110
    `define _JXX 4'b0111
    `define _CALL 4'b1000
    `define _RET 4'b1001
    `define _PUSH 4'b1010
    `define _POP 4'b1011
    `define _NONE 4'b0000
    `define _RSP 4'b0100
    `define _REGNONE 4'b1111
    `define _OK 1
    `define _ADR 2
    `define _INS 3
    `define _HLT 4
    `define _CMOVXX 4'b0010
`endif

`ifndef ALU_FUN_CODE
    `define ALU_FUN_CODE 0
    `define _Add 2'b00
    `define _Sub 2'b01
    `define _And 2'b10
    `define _Or 2'b11
`endif

`ifndef REL_CODE
    `define REL_CODE 0
    `define NonCond 0
    `define REL_LE 1
    `define REL_L 2
    `define REL_E 3
    `define REL_NE 4
    `define REL_GE 5
    `define REL_G 6
`endif

`ifndef _CONDITION_CODE_
    `define _CONDITION_CODE_ 0
    // both used in [1:0]CC as index
    // ZF for zero flag: whether the operation results in a zero
    // SF for sign flag: whether get a negetive result
    // OF for overflow flag: whether signed numbers cause an overflow
    // CF for carry flag: whether unsigned numbers cause an overflow
    `define ZF 0 
    `define SF 1
    `define OF 2
    `define CF 3
`endif
