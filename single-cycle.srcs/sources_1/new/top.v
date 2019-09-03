`timescale 1ns / 1ps
`include "instr_head.v"

module top(
    input wire clk,
    input wire rst
    );

    // 控制信号声明
    wire[1:0] pcs_ctrl; 
    wire dm_we_ctrl;
    wire[1:0] alu_op_ctrl;
    wire[1:0] alu_src_b_ctrl; 
    wire[2:0] rf_wdata_ctrl;
    wire slti_ctrl;
    wire rf_we_ctrl;
    wire[1:0] rf_wad_ctrl;

    wire[31:0] npc;
    wire[31:0] pc;
    wire[31:0] pc_plus_4; 
    wire[31:0] pc_j;
    wire[31:0] pc_beq_go;
    wire[31:0] instr;
    wire[4:0] rs;
    wire[4:0] rt;
    wire[4:0] rd; 
    wire[15:0] imm16;
    wire[25:0] imm26;
    wire[5:0] opcode;
    wire[5:0] funct;

    // wire[4:0] rf_r1_address;
    // wire[4:0] rf_r2_address;
    wire[4:0] rf_w_address;
    wire[31:0] rf_w_data;
    wire[31:0] rf_r1_data;
    wire[31:0] rf_r2_data;
    // wire[31:0] alu_src_a;
    wire[31:0] alu_src_b;
    wire alu_zero_signal, alu_less_signal;
    wire[31:0] alu_result;
    // wire[31:0] dm_address_32;
    // wire[31:0] dm_w_data;
    wire[31:0] dm_r_data;
    wire[31:0] lui_value;
    wire[31:0] slti_value;
    wire[31:0] imm16_sign_extend;

    //部件实例化
    // PC 模块, .pc 是输出
    pc mPC(.rst(rst), .clk(clk), .npc(npc), .pc(pc));

    // NPC 模块，npc 是输出
    npc mNPC(.pcs_ctrl(pcs_ctrl), .pc_plus_4(pc_plus_4), .pc_j(pc_j), .pc_beq_go(pc_beq_go), .npc(npc));

    // IM 模块
    im mIM(.pc(pc), .instr(instr));

    // IR 模块
    ir mIR(.instr(instr), .rs(rs), .rt(rt), .rd(rd), .imm16(imm16), .imm26(imm26), .opcode(opcode), .funct(funct));

    // CU 模块
    cu mCU(.funct(funct), .opcode(opcode), .zero(alu_zero_signal), .less(alu_less_signal), .pcs_ctrl(pcs_ctrl), .dm_we_ctrl(dm_we_ctrl), .alu_op_ctrl(alu_op_ctrl), .alu_src_b_ctrl(alu_src_b_ctrl), .rf_wdata_ctrl(rf_wdata_ctrl), .slti_ctrl(slti_ctrl), .rf_we_ctrl(rf_we_ctrl), .rf_wad_ctrl(rf_wad_ctrl));

    // RF 模块
    rf mRF(.rf_r1_address(rs), .rf_r2_address(rt), .rf_w_address(rf_w_address), .rf_w_data(rf_w_data), .rf_we(rf_we_ctrl), .clk(clk), .rf_r1_data(rf_r1_data), .rf_r2_data(rf_r2_data));

    // ALU 模块
    alu mALU(.alu_src_a(rf_r1_data), .alu_src_b(alu_src_b), .alu_op_ctrl(alu_op_ctrl), .alu_zero_signal(alu_zero_signal), .alu_less_signal(alu_less_signal), .alu_result(alu_result));

    // DM 模块 
    dm mDM(.dm_address_32(alu_result), .dm_w_data(rf_r2_data), .dm_we(dm_we_ctrl), .clk(clk), .dm_r_data(dm_r_data));

    // 各 MUX 模块
    mux_wad mMUX_WAD(.rf_wad_ctrl(rf_wad_ctrl), .rt(rt), .rd(rd), .rf_w_address(rf_w_address)); 
    mux_wdata mMUX_WDATA(.rf_wdata_ctrl(rf_wdata_ctrl), .lui_value(lui_value), .slti_value(slti_value), .dm_r_value(dm_r_data), .alu_result_value(alu_result), .rf_w_data(rf_w_data));
    mux_src_b mMUX_SRC_B(.alu_src_b_ctrl(alu_src_b_ctrl), .rf_r2_data(rf_r2_data), .imm16_sign_extend(imm16_sign_extend), .alu_src_b(alu_src_b));
    mux_stli mMUX_STLI(.slti_ctrl(slti_ctrl), .slti_value(slti_value));

    // LUI MODULE
    assign lui_value = {imm16, 16'b0};

    // SIGN - EXTEND
    assign imm16_sign_extend = {{16{imm16[15]}}, imm16};

    // J MODULE
    assign pc_j = {pc[31:28], imm26, 2'b0};

    // PC_BEQ_GO
    assign pc_beq_go = {{14{imm16[15]}}, imm16, 2'b0} + pc_plus_4;
    
    // PC_PLUS_4 
    assign pc_plus_4 = pc + 32'h0000_0004;
endmodule
