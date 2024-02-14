module mem(
    input logic we,
    input logic [31:0] writedata, dataadr,
    output logic [31:0] readdata
    );
    logic [31:0] RAM [127:0]; //32¡Á128 RAM 2^7=128
    initial
        begin
        // initialize memory
        $readmemh("TestMIPS.dat", RAM);
        end
    
    always_comb
        begin
            readdata <= RAM[dataadr[8:2]]; // word aligned
            if (we)
                RAM[dataadr[8:2]] <= writedata;
        end
endmodule
