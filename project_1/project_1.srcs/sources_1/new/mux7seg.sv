module mux7seg(
    input logic clk,
    input logic reset,
    input logic [32:0] digit,
    output logic [7:0] AN,
    output logic [6:0] A2G
    );
    logic [2:0] s;     //选择哪个数码管
    logic [4:0] data;
    logic [19:0] clkdiv;
    assign s = clkdiv[19:17];// count every 10.4ms    
    //8个数码管 8选1 (MUX44)
    always_comb
        case(s)
            0:  data = digit[3:0];
            1:  data = digit[7:4];
            2:  data = digit[11:8];
            3:  data = digit[16:12];
            4:  data = digit[20:17];
            5:  data = digit[24:21];
            6:  data = digit[28:25];
            7:  data = digit[32:29];
            default: data = 5'b00000;
        endcase
    //8个数码管的使能
    always_comb
        case(s)
            0:  AN = 8'b11111110;
            1:  AN = 8'b11111101;
            2:  AN = 8'b11111011;
            3:  AN = 8'b11110111;
            4:  AN = 8'b11101111;
            5:  AN = 8'b11011111;
            6:  AN = 8'b10111111;
            7:  AN = 8'b01111111;
            default: AN = 8'b11111110;
        endcase
    // 时钟分频器（20位二进制计数器）    
    always @(posedge clk, posedge reset)
      if(reset == 1) clkdiv <= 0;
      else         clkdiv <= clkdiv + 1;
    //实例化 7段数码管
    Hex7Seg s7(.x(data), .a2g(A2G));
endmodule
