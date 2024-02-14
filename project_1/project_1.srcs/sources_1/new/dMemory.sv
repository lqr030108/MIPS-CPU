module dMemory(
    input  logic clk, we,
    input  logic [7:0] aluout,
    input  logic [31:0] writedata,
    output logic [31:0] readdata
    );
    logic [31:0] RAM [255:0]; // 8λ[0-FF]��ַ�ռ�
    
    assign readdata = RAM[aluout[7:2]]; // word aligned
    
    always_ff @(negedge clk)
        if (we)
            RAM[aluout[7:2]] <= writedata;
endmodule
