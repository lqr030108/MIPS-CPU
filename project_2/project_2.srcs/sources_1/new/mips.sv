module mips(
    input logic clk, reset,
    input logic [31:0] readdata,
    output logic memwrite,
    output logic [31:0] writedata, dataadr
    );
    logic [5:0] op, func;
    logic zero;
    logic [2:0] alucontrol;
    logic alusrca;
    logic [1:0] alusrcb;
    logic iord, irwrite, memtoreg, pcen;
    logic [1:0] pcsrc;
    logic regdst, regwrite;
    logic brwr;
    logic extop;
    controller c(clk, reset, op, func, zero, alucontrol, alusrca, alusrcb, iord, irwrite, memtoreg, memwrite, pcen, pcsrc, regdst, regwrite, brwr, extop);

    datapath dp(clk, reset, alucontrol, alusrca, alusrcb, iord, irwrite, memtoreg, pcen, pcsrc, readdata, regdst, regwrite, brwr, extop, dataadr, func, op, writedata, zero);
endmodule
