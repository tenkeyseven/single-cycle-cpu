`timescale 1ns / 1ps


module im(
    input wire[31:0]        pc,

    output wire[31:0]       instr
    );

    // 设定 im 中可存至多 1024 条指令
    reg[31:0]               im[1023:0];

    wire[9:0] im_ad;
    assign im_ad = pc[11:2];

    // 根据地址将 im 中指令取出
    assign instr = im[im_ad];

endmodule
