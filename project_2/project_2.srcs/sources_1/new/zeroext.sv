module zeroext(
    input logic [15:0] a,
    output logic [31:0] y
    );
    // ����չ����λ��16��0
    assign y = {16'b0, a};
endmodule
