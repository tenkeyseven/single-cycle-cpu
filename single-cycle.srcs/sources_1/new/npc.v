`timescale 1ns / 1ps
`include "instr_head.v"

module npc(
    input wire[1:0] pcs_ctrl,
    input wire[31:0] pc_plus_4,
    input wire[31:0] pc_j,
    input wire[31:0] pc_beq_go,

    output wire[31:0] npc
    );

    assign npc = (pcs_ctrl == `PCS_BEQ_GO) ? pc_beq_go :
                 (pcs_ctrl == `PCS_J) ? pc_j :
                pc_plus_4; 

endmodule
