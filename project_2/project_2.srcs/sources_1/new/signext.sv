module signext(
    input logic [15:0] a,
    output logic [31:0] y
    );
    // ��a�����λֱ�Ӹ��Ƶ�ǰ16λ
    assign y = {{16{a[15]}}, a};
endmodule
