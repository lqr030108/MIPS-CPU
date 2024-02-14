module mips(input logic clk, reset,
            input logic [31:0] instr,
            input logic [31:0] readdata,
            output logic [31:0] pc,
            output logic memwrite, // Ð´Ê¹ÄÜ
            output logic [31:0] aluout, writedata
            );
            
    logic memtoreg, branch, zero, alusrc, regdst, regwrite, jump, extop;
    logic [2:0] alucontrol;
    logic branch_bne;
    logic pcsrc;
    assign pcsrc = branch & (((! zero) & branch_bne) | (zero & (! branch_bne))); 

    controller c(instr[31:26], instr[5:0], memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, extop, branch_bne, alucontrol);
    
    datapath dp(clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, extop, alucontrol, instr, readdata, zero, pc, aluout, writedata);
    
endmodule
