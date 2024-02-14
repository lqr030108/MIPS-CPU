`timescale 1ns / 100ps
module test_regFile(

    );
    logic clk;
    logic regWriteEn; //д��ʹ��
    logic [4:0] regWriteAddr;
    logic [31:0] regWriteData; //1��д��Ĵ���
    logic [4:0] RsAddr;
    logic [4:0] RtAddr;
    logic [31:0] RsData; //Rs�Ĵ���
    logic [31:0] RtData; //Rt�Ĵ���
    //ʵ����
    regfile MUT(clk, regWriteEn, RsAddr, RtAddr, regWriteAddr, regWriteData, RsData, RtData);
    //��ʼ��
    initial begin
        clk = 0;
        regWriteEn = 0;
        regWriteAddr = 0;
        regWriteData = 0;
        RsAddr = 0;
        RtAddr = 0;
        //Wait 100ns
        #100;
        //��Ӽ����ź�
        regWriteEn = 1;
        regWriteData = 32'h1234abcd;
    end
    //����ʱ��
    parameter PERIOD = 20;
    always begin
        clk = 1'b0;
        #(PERIOD / 2) clk = 1'b1;
        #(PERIOD / 2);
    end
    //�����ź�
    always begin
        regWriteAddr = 8;
        RsAddr = 8;
        #PERIOD;
    end

endmodule
