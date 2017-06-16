//ADDR_WID means address width
// the length of index for _REG_CODE_
`define DATA_WID 64
`define ADDR_WID 4
//below defines some codes for registers
`ifndef _REG_CODE_
    `define _REG_CODE_ 0
    `define NUM_OF_REG 16
    `define rax_  0
    `define rcx_ 1
    `define rdx_ 2
    `define rbx_ 3
    `define rsp_ 4
    `define rbp_ 5
    `define rsi_ 6
    `define rdi_ 7
    `define r8_ 8
    `define r9_ 9
    `define r10_ 10
    `define r11_ 11
    `define r12_ 12
    `define r13_ 13
    `define r14_ 14
    `define NonReg_ 15
`endif

//below defines some codes for flags
`ifndef _CONST_FLAG_
    `define _CONST_FLAG_ 0
    `define _HALT 0
    `define _NOP 1
    `define _RRMOV 2
    `define _IRMOV 3
    `define _RMMOV 4
    `define _MRMOV 5
    `define _OP 6
    `define _JXX 7
    `define _CALL 8
    `define _RET 9
    `define _PUSH 10
    `define _POP 11
    `define _NONE 0
    `define _RSP 4
    `define _REGNONE 15
    `define _OK 1
    `define _ADR 2
    `define _INS 3
    `define _HLT 4
    `define _CMOVXX 2
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
