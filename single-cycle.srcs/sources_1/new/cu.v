`timescale 1ns / 1ps
`include "instr_head.v"

// zero 是 beq 指令会产生的信号，less 是 slti 指令产生的信号
module cu(
    input wire[5:0] funct,
    input wire[5:0] opcode,
    input wire zero,
    input wire less, 

    output wire[1:0] pcs_ctrl,
    output wire dm_we_ctrl,
    output wire[1:0] alu_op_ctrl,
    output wire[1:0] alu_src_b_ctrl,
    output wire[2:0] rf_wdata_ctrl,
    output wire slti_ctrl,
    output wire rf_we_ctrl,
    output wire[1:0] rf_wad_ctrl
    );

    // 来判断传入是哪个信号？这些信号怎么控制那些多选一器件
    // 一、指令信号决定
    wire is_add, is_addiu, is_lui, is_lw, is_sw, is_j, is_beq, is_slti;
    
    // R type
    assign is_add = (opcode == `INSTR_TYPE_R && funct == `INSTR_ADD) ? 1 : 0;

    // I type
    assign is_addiu = (opcode == `INSTR_ADDIU) ? 1 : 0;
    assign is_lui = (opcode == `INSTR_LUI) ? 1 : 0;
    assign is_lw = (opcode == `INSTR_LW) ? 1 : 0;
    assign is_sw = (opcode == `INSTR_SW) ? 1 : 0;
    assign is_beq = (opcode == `INSTR_BEQ) ? 1 : 0;
    assign is_slti = (opcode == `INSTR_SLTI) ? 1 : 0;

    // J type
    assign is_j = (opcode == `INSTR_J) ? 1 : 0;

    // 二、部件控制信号决定
    // PCS_DEFAULT 包含正常跳转和 BEQ 判断后的正常跳转
    assign pcs_ctrl = (is_beq && zero) ? `PCS_BEQ_GO :
                      (is_j) ? `PCS_J : `PCS_DEFAULT;
    assign dm_we_ctrl = (is_sw) ? `DM_WR_ENABLE : `DM_WR_DISABLE;
    assign alu_op_ctrl = (is_add || is_addiu || is_lw || is_sw) ? `ALU_OP_ADD :
                         (is_beq || is_slti) ? `ALU_OP_SUB : `ALU_OP_DEFALUT;
    assign alu_src_b_ctrl = (is_add || is_beq || is_slti) ? `ALU_SRC_B_RT :
                            (is_addiu || is_lw || is_sw) ? `ALU_SRC_B_IMM16_SE : `ALU_SRC_B_DEFALUT;
    assign rf_wdata_ctrl = (is_lui) ? `RF_WDATA_LUIM :
                           (is_slti) ? `RF_WDATA_SLTIM :
                           (is_lw) ? `RF_WDATA_DM : 
                           (is_add || is_addiu) ? `RF_WDATA_ALU : `RF_WDATA_DEFALUT;
    assign slti_ctrl = (less) ? `SLTI_ONE : `SLTI_ZERO;
    assign rf_we_ctrl = (is_lui || is_slti || is_lw || is_add || is_addiu) ?  `RF_WR_ENABLE : `RF_WR_DISABLE;
    assign rf_wad_ctrl = (is_add) ? `RF_WAD_RD :
                         (is_lui || is_slti || is_lw || is_addiu) ? `RF_WAD_RT : `RF_WAD_DEFAULT;



endmodule
