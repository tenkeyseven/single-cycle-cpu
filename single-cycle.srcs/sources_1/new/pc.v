`timescale 1ns / 1ps


module pc(
    input wire          rst,
    input wire          clk,
    input wire[31:0]    npc,
    
    output reg[31:0]    pc
    );

    //当处于时钟信号的上升沿或者复位信号的上升沿执行
    //若是复位信号，则将 32 位 pc 值置为零
    always @ (posedge rst or posedge clk) begin
        if (rst) begin
            pc <= 32'h00000000;
        end else begin
            pc <= npc;
        end
    end

endmodule
