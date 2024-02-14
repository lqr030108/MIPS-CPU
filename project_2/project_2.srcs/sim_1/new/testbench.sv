module testbench(

    );
    logic clk, reset, memwrite;
    logic [31:0] writedata, dataadr;
    
    // instantiate device to be tested
    Top dut(clk, reset, writedata, dataadr, memwrite);
    
    initial // initialize test
        begin
            reset <= 1;
            # 22;
            reset <= 0;
        end
    
    always
        begin
            clk <= 1;
            # 5;
            clk <= 0;
            # 5;
        end
    
    always @(negedge clk) // check results
        begin
            if (memwrite)
                begin
                    if (dataadr === 88 & writedata === 1)
//                    if (dataadr === 84 & writedata === 7)
                        begin
                            $display ("Simulation succeeded");
                            $stop;
                        end
                    else if (dataadr !== 84)
//                    else if (dataadr !== 80)
                        begin
                            $display ("Simulation failed");
                            $stop;
                        end
                end
        end
    
endmodule
