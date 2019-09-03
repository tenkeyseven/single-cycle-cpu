`timescale 1ns / 1ps


module rf(
    input wire[4:0] rf_r1_address,
    input wire[4:0] rf_r2_address,
    input wire[4:0] rf_w_address,
    input wire[31:0] rf_w_data,
    input wire rf_we,
    input wire clk,

    output wire[31:0] rf_r1_data,
    output wire[31:0] rf_r2_data
    );

    // 用 reg 模拟一个通用寄存器堆
    reg[31:0] gpr[31:0];
    
    //零号寄存器值始终为零
    assign rf_r1_data = (rf_r1_address == 0) ? 32'h0000_0000 : gpr[rf_r1_address];
    assign rf_r2_data = (rf_r2_address == 0) ? 32'h0000_0000 : gpr[rf_r2_address];

    // Zan:"写操作需要同步，故在时钟上升沿同时写"
    always @ (posedge clk) begin
        if (rf_we) begin
            gpr[rf_w_address] <= rf_w_data;
        end
    end
endmodule
