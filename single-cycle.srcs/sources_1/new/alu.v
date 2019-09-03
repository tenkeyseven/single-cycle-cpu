`timescale 1ns / 1ps
`include "instr_head.v"

module alu(
    input wire[31:0] alu_src_a,
    input wire[31:0] alu_src_b,
    input wire[1:0] alu_op_ctrl,

    output wire alu_zero_signal,
    output wire alu_less_signal,
    output wire[31:0] alu_result
    );

    // 33 位数，后续符号检测时可以使用到
    wire[32:0] alu_temp;
    // 描述块部分中语句同时进行
    assign alu_result = alu_temp[31:0];

    assign alu_temp = (alu_op_ctrl == `ALU_OP_ADD) ? {alu_src_a[31], alu_src_a} + {alu_src_b[31], alu_src_b} :
                      (alu_op_ctrl == `ALU_OP_SUB) ? {alu_src_a[31], alu_src_a} - {alu_src_b[31], alu_src_b} : {alu_src_b[31], alu_src_b};
    assign alu_zero_signal = (alu_temp == 0) ? `ALU_ZERO_TRUE : `ALU_ZERO_FALSE;
    assign alu_less_signal = (alu_temp[31] == 1) ? `ALU_LESS_TRUE : `ALU_LESS_FALSE;
endmodule
