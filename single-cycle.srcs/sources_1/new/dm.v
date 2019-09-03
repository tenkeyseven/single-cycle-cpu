`timescale 1ns / 1ps


module dm(
    input wire[31:0] dm_address_32,
    input wire[31:0] dm_w_data,
    input wire dm_we,
    input wire clk,

    output wire[31:0] dm_r_data
    );

    //暂时只需要 1024 个 dm 就够了
    reg[31:0] dm[1023:0];
    wire[9:0] dm_address_10;

    assign dm_address_10 = dm_address_32[11:2];
    assign dm_r_data = dm[dm_address_10];

    always @ (posedge clk) begin
        if (dm_we) begin
            dm[dm_address_10] <= dm_w_data;
        end
    end


endmodule
