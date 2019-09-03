`timescale 1ns / 1ps

// R 型指令，R 指令 opcode 相同都为 6‘b000000，不同于 function 部分
`define INSTR_TYPE_R     6'b000000  // opcode
`define INSTR_SLL        6'b000000  // 以下为不同的 function字段
`define INSTR_ADD        6'b100000 
`define INSTR_SUB        6'b100010 
`define INSTR_AND        6'b100100 

// I 型指令，不同于 opcode 
`define INSTR_ADDIU      6'b001001 
`define INSTR_LW         6'b100011 
`define INSTR_SW         6'b101011 
`define INSTR_LUI        6'b001111 
`define INSTR_ORI        6'b001101
`define INSTR_BEQ        6'b000100
`define INSTR_SLTI       6'b001010

// J 型指令，不同于 opcode
`define INSTR_J           6'b000010
`define INSTR_JAL         6'b000011 


//定义部件操作信号
// PCS NPC 选择
`define PCS_DEFAULT       2'b00
`define PCS_BEQ_GO        2'b01
`define PCS_J             2'b10

// DM 写使能
`define DM_WR_ENABLE      1'b1
`define DM_WR_DISABLE     1'b0

// ALU 操作
`define ALU_OP_DEFALUT    2'b00
`define ALU_OP_ADD        2'b01
`define ALU_OP_SUB        2'b10

// ALU B 源选择
`define ALU_SRC_B_DEFALUT 2'b00
`define ALU_SRC_B_RT      2'b01
`define ALU_SRC_B_IMM16_SE 2'b10

// RFW 数据源选择
`define RF_WDATA_DEFALUT  3'b000
`define RF_WDATA_LUIM     3'b001
`define RF_WDATA_SLTIM    3'b010
`define RF_WDATA_DM       3'b011
`define RF_WDATA_ALU      3'b100

// SLTI 数据选择
`define SLTI_ZERO         1'b0
`define SLTI_ONE          1'b1

// RF 写使能
`define RF_WR_DISABLE     1'b0
`define RF_WR_ENABLE      1'b1

// RF 写入地址选择
`define RF_WAD_DEFAULT    2'b00
`define RF_WAD_RD         2'b01
`define RF_WAD_RT         2'b10

// 定义 ALU 中产生的 ZERO 信号和 SLTI 信号
`define ALU_ZERO_TRUE     1'b1
`define ALU_ZERO_FALSE    1'b0
`define ALU_LESS_TRUE     1'b1
`define ALU_LESS_FALSE    1'b0