module controller(input logic [5:0] op, func,
                  output logic memtoreg, memwrite,
                  output logic branch, alusrc,
                  output logic regdst, regwrite,
                  output logic jump,
                  output logic extop,
                  output logic branch_bne,
                  output logic [2:0] alucontrol
                  );
                  
    logic [2:0] aluop;
    
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, extop, branch_bne, aluop);
    
    aludec ad(func, aluop, alucontrol);

endmodule
