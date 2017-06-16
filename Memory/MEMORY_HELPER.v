// edit by wyf
// 2017/6/7 22:10

`timescale 1ns/1ps
`include "./../header/head.v"

module MEM_ADDR(
    input wire [`DATA_WID - 1 : 0] valE,
    input wire [`DATA_WID - 1 : 0] valA,
    input wire [`ADDR_WID - 1 : 0] icode,

    output reg [`DATA_WID - 1 : 0 ] OUT
);

    always@(*) begin
        case (icode) 
            `_RMMOV, `_PUSH, `_CALL, `_MRMOV : 
                OUT = valE;
            `_POP, `_RET:
                OUT = valA;
             default : 
                 OUT = OUT;
            // TODO: if it don't need the address.
        endcase
    end

endmodule // 

module MEM_DATA(
    input wire [`DATA_WID - 1 : 0] valP,
    input wire [`DATA_WID - 1 : 0] valA,
    input wire [`ADDR_WID - 1 : 0] icode,

    output reg [`DATA_WID - 1 : 0] OUT
);

    always@(*) begin 
        case(icode)
            `_RMMOV, `_PUSH:
                OUT = valA;
            `_CALL:
                OUT = valP;
            // `_MRMOV, `_RET, `_POP:
             default:
                OUT = OUT;
                // TODO: if it don't write data.
        endcase
    end
endmodule // MEM_DATA


module MEM_READ(
    input wire [`ADDR_WID - 1 : 0] icode,
    output reg read
  
);
    always@(*) begin 
        case(icode)
            `_MRMOV, `_RET, `_POP:
                read = 1;
            default:
                read = 0;
        endcase
    end
endmodule // MEM_READ   


module MEM_WRITE(
    input wire [`ADDR_WID - 1 : 0] icode,
    output reg write
);

    always@(*) begin 
        case(icode)
            `_RMMOV, `_PUSH, `_CALL:
                write = 1;
            default:
                write = 0;
        endcase
    end
endmodule // MEM_WRITE


module STAT(
    input wire instr_valid,
    input wire imem_error,
    input wire [`ADDR_WID - 1 : 0] icode,
    input wire dmem_error,
    output reg [`ADDR_WID - 1 : 0] stat
);
    // `OK  `ADR  `INS  `HLT 
    // TODO: output the state.
    //  How to decide the state.
    initial begin
        stat = 4'b0001;
    end
    always@(*) begin
        // case (icode)
        //     `HALT:
        //         stat = `HLT;
        
        // endcase
       
    end
endmodule // STAT