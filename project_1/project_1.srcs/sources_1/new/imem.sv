//64 x 32λָ��洢��
module imem(input logic [5:0] pc,
            output logic [31:0] instr
            );
    logic [31:0] RAM[63:0]; //32��64 RAM 2^6=64
    
    initial
        begin
        // initialize memory
        $readmemh("TestMIPS.dat", RAM);
        end
        
    assign instr = RAM[pc]; // word aligned
endmodule
