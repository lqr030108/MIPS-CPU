module zeroext(
    input logic [15:0] a,
    output logic [31:0] y
    );
    // 零扩展，高位补16个0
    assign y = {16'b0, a};
endmodule
