//数据存储器：以ALU的计算结果为地值取数据或者存数据，
//lw或者sw，取数据会加载到寄存器，存数据时数据来源于rt字段从寄存器中读取的数据。
module dmem(input  logic clk, we,
            input  logic [31:0] aluout, writedata,
            output logic [31:0] readdata);

    logic [31:0] RAM [63:0];
    
    assign readdata = RAM[aluout[7:2]]; // word aligned
    
    always_ff @(negedge clk)
        if (we)
            RAM[aluout[7:2]] <= writedata;
endmodule
