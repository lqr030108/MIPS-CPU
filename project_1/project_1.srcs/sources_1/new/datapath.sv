module datapath(input logic clk, reset,
                input logic memtoreg, pcsrc,
                input logic alusrc, regdst,
                input logic regwrite, jump, extop,
                input logic [2:0] alucontrol,
                input logic [31:0] instr,
                input logic [31:0] readdata,
                output logic zero,
                output logic [31:0] pc,
                output logic [31:0] aluout, writedata
                );

        logic [4:0] writereg;
        logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
        logic [31:0] signimm, signimmsh;
        logic [31:0] srca, srcb;
        logic [31:0] result;
        logic [31:0] zeroimm, imm;
        
        // next PC logic
        flopr #(32) pcreg(clk, reset, pcnext, pc);
        adder       pcaddl(pc, 32'b100, pcplus4);
        sl2         immsh(signimm, signimmsh);
        adder       pcadd2(pcplus4, signimmsh, pcbranch);
        mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
        mux2 #(32)  pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
        // register file logic
        regfile     rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
        mux2 #(5)   wrmux(instr[20:16], instr[15:11], regdst, writereg);
        mux2 #(32)  resmux(aluout, readdata, memtoreg, result);
        signext     se(instr[15:0], signimm);
        zeroext     ze(instr[15:0], zeroimm);
        mux2 #(32)  srcimmmux(zeroimm, signimm, extop, imm);
        mux2 #(32)  srcbmux(writedata, imm, alusrc, srcb);
        alu         alu(srca, srcb, alucontrol, aluout, zero);
endmodule
