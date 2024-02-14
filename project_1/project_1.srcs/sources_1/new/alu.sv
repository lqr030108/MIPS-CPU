module alu(input  logic [31:0] a, b,
           input logic [2:0] alucontrol,
           output logic [31:0] result,
           output logic zero
           );

    always_comb
    begin
        case (alucontrol)
            3'b000: result <= a & b;
            3'b001: result <= a | b;
            3'b010: result <= a + b;
            3'b110: result <= a - b;
            3'b111: result <= (a < b) ? 1 : 0;
            3'b011: result <= 0;
            default: result <= 0;
        endcase
        if (result == 0) zero <= 1;
        else zero <= 0;
    end
endmodule
