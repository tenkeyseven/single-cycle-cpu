`timescale 1ns / 1ps

module simulation();
       
       reg clk,rst;

       top mTOP(.clk(clk), .rst(rst));

       initial begin
           $readmemh ("D:/VIVADO2017.2/repos/single-cycle/single-cycle.srcs/sim_1/new/instructions.txt", mTOP.mIM.im); // 从文件中读出指令集给 IM
           $readmemh ("D:/VIVADO2017.2/repos/single-cycle/single-cycle.srcs/sim_1/new/register_file.txt", mTOP.mRF.gpr); // 从文件中读出指令集给 RF
           $readmemh ("D:/VIVADO2017.2/repos/single-cycle/single-cycle.srcs/sim_1/new/data_memory.txt", mTOP.mDM.dm); // 从文件中读出指令集给 RF
           rst = 1;
           clk = 0;
           #10 rst = 0;
       end

       always begin
           #20 clk = ~clk;
       end

endmodule
