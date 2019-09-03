`timescale 1ns / 1ps


// 从 IM 中取出一条指令，分发出具体的内容
module ir(
    input wire[31:0] instr,

    output wire[4:0] rs,
    output wire[4:0] rt,
    output wire[4:0] rd,
    output wire[15:0] imm16,
    output wire[25:0] imm26,
    output wire[5:0] opcode,
    output wire[5:0] funct 
    );

    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign imm16 = instr[15:0];
    assign imm26 = instr[25:0];
    assign opcode = instr[31:26];
    assign funct = instr[5:0];

endmodule
