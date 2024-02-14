//���ݴ洢������ALU�ļ�����Ϊ��ֵȡ���ݻ��ߴ����ݣ�
//lw����sw��ȡ���ݻ���ص��Ĵ�����������ʱ������Դ��rt�ֶδӼĴ����ж�ȡ�����ݡ�
module dmem(input  logic clk, we,
            input  logic [31:0] aluout, writedata,
            output logic [31:0] readdata);

    logic [31:0] RAM [63:0];
    
    assign readdata = RAM[aluout[7:2]]; // word aligned
    
    always_ff @(negedge clk)
        if (we)
            RAM[aluout[7:2]] <= writedata;
endmodule
