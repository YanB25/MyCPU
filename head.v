//below defines some codes for registers
`ifndef _REG_CODE_
    `define _REG_CODE_ 0
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
`endif
