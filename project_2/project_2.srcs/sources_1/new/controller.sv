module controller(
    input logic clk, reset,
    input logic [5:0] op, func,
    input logic zero,
    output logic [2:0] alucontrol,
    output logic alusrca,
    output logic [1:0] alusrcb,
    output logic iord, irwrite, memtoreg, memwrite, pcen,
    output logic [1:0] pcsrc,
    output logic regdst, regwrite, brwr, extop
    );
    logic pcwr, pcwrcond, rtype, bne;
    logic [2:0] aluop;
    assign pcen = pcwr | (pcwrcond & zero) | (bne & (~zero));
    maindec md(clk, reset, op, pcwr, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, brwr, extop, pcwrcond, rtype, bne);
    aludec ad(func, aluop, rtype, alucontrol);
endmodule
