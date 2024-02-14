module top(
    input logic clk, reset,
    output logic [31:0] writedata, aluout,
    output logic memwrite
);
    logic [31:0] instr, readdata;
    logic [31:0] pc;
    
    always_ff @(negedge clk)
        if (reset) pc <= 0;
        
    // instantiate processor and memories
    mips mips(clk, reset, instr, readdata, pc, memwrite, aluout, writedata);
    imem imem(pc[7:2], instr); // ȡָ��ֽ�Ѱַ������00����
    dmem dmem(clk, memwrite, aluout, writedata, readdata);
endmodule
