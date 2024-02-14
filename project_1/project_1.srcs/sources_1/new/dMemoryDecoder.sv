module dMemoryDecoder(
    input logic clk,
    input logic writeEN,
    input logic [7:0] addr,
    input logic [31:0] writeData,
    output logic [31:0] readData,
    input logic reset,
    input logic btnL,
    input logic btnR,
    input logic [15:0] switch,
    output logic [7:0] an,
    output logic [6:0] a2g
    );
    logic pRead, pWrite, mWrite;
    // Whether reading from IO is enabled.
    assign pRead = (addr[7] == 1'b1) ? 1 : 0; // 0x80
    // Whether writing to IO is enabled.
    assign pWrite = (addr[7] == 1'b1) ? writeEN : 0;
    // 写入数据存储器的开关
    assign mWrite = writeEN & (addr[7] == 1'b0);
    logic [11:0]led;
    logic [31:0] readData1, readData2;
    assign readData = (addr[7] == 1'b1) ? readData2 : readData1;
    dMemory dmem(.clk(clk),
                 .we(mWrite),
                 .aluout(addr),
                 .writedata(writeData),
                 .readdata(readData1)
                 );
    IO io(.clk(clk),
          .reset(reset),
          .pRead(pRead),
          .pWrite(pWrite),
          .addr(addr[3:2]),
          .pWriteData(writeData[11:0]),
          .pReadData(readData2),
          .buttonL(btnL),
          .buttonR(btnR),
          .switch(switch),
          .led(led)
          );
    mux7seg m7seg(.clk(clk),
                  .reset(reset),
                  .digit({switch, 5'b10000, led}),
                  .AN(an),
                  .A2G(a2g)
                  );
endmodule
