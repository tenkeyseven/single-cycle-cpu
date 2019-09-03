`timescale 1ns / 1ps
`include "instr_head.v"

module mux_wad(
    input wire[1:0] rf_wad_ctrl,
    input wire[4:0] rt,
    input wire[4:0] rd,

    output wire[4:0] rf_w_address
    );

    // 默认 rd
    assign rf_w_address = (rf_wad_ctrl == `RF_WAD_RT) ? rt :
                          (rf_wad_ctrl == `RF_WAD_RD) ? rd : rd;
endmodule

module mux_wdata(
    input wire[2:0] rf_wdata_ctrl,
    input wire[31:0] lui_value,
    input wire[31:0] slti_value,
    input wire[31:0] dm_r_value,
    input wire[31:0] alu_result_value,

    output wire[31:0] rf_w_data
    );

    // 默认 alu_result
    assign rf_w_data = (rf_wdata_ctrl == `RF_WDATA_LUIM) ? lui_value :
                       (rf_wdata_ctrl == `RF_WDATA_SLTIM) ? slti_value :
                       (rf_wdata_ctrl == `RF_WDATA_DM) ? dm_r_value :
                       (rf_wdata_ctrl == `RF_WDATA_ALU) ? alu_result_value : alu_result_value;
endmodule

module mux_src_b(
    input wire[1:0] alu_src_b_ctrl,
    input wire[31:0] rf_r2_data,
    input wire[31:0] imm16_sign_extend,

    output wire[31:0] alu_src_b
    );

    // 默认 imm16_sign_extend
    assign alu_src_b = (alu_src_b_ctrl == `ALU_SRC_B_RT) ? rf_r2_data :
                       (alu_src_b_ctrl == `ALU_SRC_B_IMM16_SE) ? imm16_sign_extend : imm16_sign_extend;
endmodule

module mux_stli(
    input wire slti_ctrl,

    output wire[31:0] slti_value
    );

    // 默认 1
    assign slti_value = (slti_ctrl == `SLTI_ZERO) ? 32'h0000_0000 :
                        (slti_ctrl == `SLTI_ONE) ? 32'h0000_0001 : 32'h0000_0001;
endmodule
