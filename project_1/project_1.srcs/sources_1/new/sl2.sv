module sl2(
    input logic [31:0] signimm, 
    output logic [31:0] signimmsh
    );
    assign signimmsh = signimm * 4;
endmodule
