module maindec(input logic [5:0] op,
               output logic memtoreg, memwrite,
               output logic branch, alusrc,
               output logic regdst, regwrite,
               output logic jump,
               output logic extop,
               output logic branch_bne,
               output logic [2:0] aluop
               );
               
    logic [11:0] controls;
    
    assign {branch, jump, regdst, alusrc, memtoreg, regwrite, memwrite, extop, branch_bne, aluop} = controls;
    
    always_comb
        case (op)
            6'b000000: controls <= 12'b0010010x0010; // Rtype£¬nop
            6'b100011: controls <= 12'b000111010000;// lw
            6'b101011: controls <= 12'b00x1x0110000;// sw
            6'b000100: controls <= 12'b10x0x00x0001;// beq
            6'b001000: controls <= 12'b000101010000;// addi
            6'b001100: controls <= 12'b000101010100;// andi
            6'b001101: controls <= 12'b000101010011;// ori
            6'b001010: controls <= 12'b000101000101;// slti
            6'b000010: controls <= 12'b01xxx00x0xxx;// j
            6'b000101: controls <= 12'b10x0x00x1001;// bne
            default:   controls <= 121'bxxxxxxxxxxx; // ???
        endcase
endmodule
