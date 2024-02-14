module Top(
    input logic clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic memwrite
    );
    logic [31:0] readdata;
    mips M1(clk, reset, readdata, memwrite, writedata, dataadr);
    mem M2(memwrite, writedata, dataadr, readdata);
endmodule
