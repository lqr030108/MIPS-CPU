`timescale 1ns / 100ps
module test_regFile(

    );
    logic clk;
    logic regWriteEn; //写入使能
    logic [4:0] regWriteAddr;
    logic [31:0] regWriteData; //1个写入寄存器
    logic [4:0] RsAddr;
    logic [4:0] RtAddr;
    logic [31:0] RsData; //Rs寄存器
    logic [31:0] RtData; //Rt寄存器
    //实例化
    regfile MUT(clk, regWriteEn, RsAddr, RtAddr, regWriteAddr, regWriteData, RsData, RtData);
    //初始化
    initial begin
        clk = 0;
        regWriteEn = 0;
        regWriteAddr = 0;
        regWriteData = 0;
        RsAddr = 0;
        RtAddr = 0;
        //Wait 100ns
        #100;
        //添加激励信号
        regWriteEn = 1;
        regWriteData = 32'h1234abcd;
    end
    //设置时钟
    parameter PERIOD = 20;
    always begin
        clk = 1'b0;
        #(PERIOD / 2) clk = 1'b1;
        #(PERIOD / 2);
    end
    //激励信号
    always begin
        regWriteAddr = 8;
        RsAddr = 8;
        #PERIOD;
    end

endmodule
