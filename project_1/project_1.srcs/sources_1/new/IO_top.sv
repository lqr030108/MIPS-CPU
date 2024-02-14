module IO_top(
    input logic CLK100MHZ,
    input logic BTNC, // reset
    input logic BTNL, // SW input data
    input logic BTNR, // 七段数码管显示
    input logic [15:0] SW, // a:SW[15:8], b:SW[7:0]
    output logic [7:0] AN,
    output logic [6:0] A2G
    );
    logic [31:0] pc, instr;

    iMemory imem (.pc(pc[7:2]),
                  .instr(instr)); // output
    logic Write; // 写信号：可能是memWrite，也可能是ioWrite
    logic [31:0] dataAdr, writeData, readData;
    
    mips mips(.clk(CLK100MHZ),
              .reset(BTNC),
              .pc(pc), // output
              .instr(instr),
              .memwrite(Write), // output
              .aluout(dataAdr), // output
              .writedata(writeData), // output
              .readdata(readData)
              );
    dMemoryDecoder dmd(.clk(CLK100MHZ),
                       .writeEN(Write),
                       .addr(dataAdr[7:0]),
                       .writeData(writeData), // output
                       .readData(readData), // output
                       .reset(BTNC),
                       .btnL(BTNL),
                       .btnR(BTNR),
                       .switch(SW),
                       .an(AN), // output
                       .a2g(A2G) // output
                       );
endmodule
