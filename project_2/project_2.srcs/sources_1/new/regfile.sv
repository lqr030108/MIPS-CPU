module regfile(
    input logic regwrite,
    input logic [4:0] ra1, ra2,
    input logic [4:0] wa3,
    input logic [31:0] wd3,
    output logic [31:0] rd1, rd2
        );
    logic [31:0] rf [31:0];
    
    always_comb
        if (regwrite) rf[wa3] <= wd3;
    
    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
