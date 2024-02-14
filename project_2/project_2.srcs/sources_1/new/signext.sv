module signext(
    input logic [15:0] a,
    output logic [31:0] y
    );
    // 将a的最高位直接复制到前16位
    assign y = {{16{a[15]}}, a};
endmodule
