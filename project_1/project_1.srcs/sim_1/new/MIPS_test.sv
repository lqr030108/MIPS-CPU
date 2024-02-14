`timescale 1ns / 100ps
module MIPS_test(

    );
    logic clk;
    logic reset;
    logic [31:0] writedata, dataadr;
    logic memwrite;
    
    // instantiate device to be tested
    top dut(clk, reset, writedata, dataadr, memwrite);
    
    // initialize test
    initial begin
        reset <= 1;
        clk <= 0;
        writedata <= 0;
        dataadr <= 5;
        memwrite <= 0;
        # 30;
        reset <= 0;
    end
    
    //ÉèÖÃÊ±ÖÓ
    parameter PERIOD = 20;
    always begin
        clk = 1'b0;
        #(PERIOD / 2) clk = 1'b1;
        #(PERIOD / 2);
    end
    
    // check that 1 gets written to address 80
    always @(negedge clk)
        begin
            if (memwrite)
                begin
                    if (dataadr === 80 & writedata === 1)
                        begin
                            $display("Simulation succeeded");
                            $stop;
                        end
                    else if (dataadr !== 84)
                        begin
                            $display("Simulation failed");
                            $stop;
                        end
                end
        end
endmodule
