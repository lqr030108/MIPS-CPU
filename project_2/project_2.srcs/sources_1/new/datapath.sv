module datapath(
    input logic clk, reset,
    input logic [2:0] alucontrol,
    input logic alusrca,
    input logic [1:0] alusrcb,
    input logic iord, irwrite, memtoreg, pcen,
    input logic [1:0] pcsrc,
    input logic [31:0] readdata,
    input logic regdst,
    input logic regwrite,
    input logic brwr,extop,
    output logic [31:0] dataadr,
    output logic [5:0] func, op,
    output logic [31:0] writedata,
    output logic zero
    );
    logic [31:0] pc, pcnext, aluout, instr, wd3, rd1, rd2, signimm, zeroimm, imm, immh, dataA, dataB, srca, srcb, pcjump, branchadr;
    logic [4:0] wa3;
    logic [31:0] plus4;
    assign plus4 = 32'b0100;
    assign op = instr[31:26];
    assign func = instr[5:0];
    assign writedata = dataB;

    flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc);
    mux2 #(32) getiord(pc, aluout, iord, dataadr);
    mux2 #(32) getwritedata(aluout, readdata, memtoreg, wd3);
    flopenr #(32) getinstr(clk, reset, irwrite, readdata, instr);
    mux2 #(5) getwriteadr(instr[20:16], instr[15:11], regdst, wa3);
    regfile rf(regwrite, instr[25:21], instr[20:16], wa3, wd3, rd1, rd2);
    signext se(instr[15:0], signimm);
    zeroext ze(instr[15:0], zeroimm);
    mux2 #(32) ext(zeroimm, signimm, extop, imm);
    sl2 immsh(imm, immh);
    smallreg regA(clk, reset, rd1, dataA);
    smallreg regB(clk, reset, rd2, dataB);
    mux2 #(32) getsrca(pc, dataA, alusrca, srca);
    mux4 #(32) getsrcb(dataB, plus4, imm, immh, alusrcb, srcb);
    alu alu(srca, srcb, alucontrol, aluout, zero);
    sl2 jumppc(instr, pcjump);
    flopenr #(32) ba(clk, reset, brwr, aluout, branchadr);
    mux3 pcmux({pc[31:28], pcjump[27:0]}, aluout, branchadr, pcsrc, pcnext);
endmodule
