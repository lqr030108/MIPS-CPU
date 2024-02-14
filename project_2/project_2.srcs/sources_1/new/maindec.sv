module maindec(
    input logic clk,
    input logic reset,
    input logic [5:0] op,
    output logic pcwrite, memwrite, irwrite, regwrite,
    output logic alusrca, iord, memtoreg, regdst,
    output logic [1:0] alusrcb, pcsrc,
    output logic [2:0] aluop,
    output logic brwr, extop,
    output logic pcwrcond, rtype, bne
    );
    localparam FETCH = 4'b0000; // State 0
    localparam DECODE = 4'b0001; // State 1
    localparam MEMADR = 4'b0010; // State 2
    localparam MEMRD = 4'b0011; // State 3
    localparam MEMWB = 4'b0100; // State 4
    localparam MEMWR = 4'b0101; // State 5
    localparam RTYPEEX = 4'b0110; // State 6
    localparam RTYPEWB = 4'b0111; // State 7
    localparam BEQEX = 4'b1000; //State 8
    localparam ADDIEX = 4'b1001; // State 9
    localparam ADDIWB = 4'b1010; // State 10
    localparam JEX = 4'b1011; // State 11
    localparam BNEEX = 4'b1100; // State 12
    localparam ANDIEX = 4'b1101; // State 13
    localparam ORIEX = 4'b1110; // State 14
    localparam SLTIEX = 4'b1111; // State 15
    
    localparam LW = 6'b100011; // Opcode for lw
    localparam SW = 6'b101011; // Opcode for sw
    localparam RTYPE = 6'b000000; // Opcode for R-type
    localparam BEQ = 6'b000100; // Opcode for beq
    localparam ADDI = 6'b001000; // Opcode for addi
    localparam ANDI = 6'b001100; // Opcode for andi
    localparam ORI = 6'b001101; // Opcode for ori
    localparam SLTI = 6'b001010; // Opcode for slti
    localparam J = 6'b000010; // Opcode for j
    localparam BNE = 6'b000101; // Opcode for bne
    
    logic [3:0] state, nextstate;
    logic [19:0] controls;
    
    // state register
    always_ff @(negedge clk)
        if (reset) state <= FETCH;
        else state <= nextstate;
    // next state logic
    always_comb
        case (state)
            FETCH: nextstate = DECODE;
            DECODE: case(op)
                        LW: nextstate = MEMADR;
                        SW: nextstate = MEMADR;
                        RTYPE: nextstate = RTYPEEX;
                        BEQ: nextstate = BEQEX;
                        ADDI: nextstate = ADDIEX;
                        J: nextstate = JEX;
                        BNE: nextstate = BNEEX;
                        ANDI: nextstate = ANDIEX;
                        ORI: nextstate = ORIEX;
                        SLTI: nextstate = SLTIEX;
                        default: nextstate = 4'bxxxx; // never happen
                    endcase
            MEMADR: case(op)
                        LW: nextstate = MEMRD;
                        SW: nextstate = MEMWR;
                        default: nextstate = 4'bxxxx;
                    endcase
            MEMRD: nextstate = MEMWB;
            MEMWB: nextstate = FETCH;
            MEMWR: nextstate = FETCH;
            RTYPEEX: nextstate = RTYPEWB;
            RTYPEWB: nextstate = FETCH;
            BEQEX: nextstate = FETCH;
            BNEEX: nextstate = FETCH;
            ADDIEX: nextstate = ADDIWB;
            ANDIEX: nextstate = ADDIWB;
            ORIEX: nextstate = ADDIWB;
            SLTIEX: nextstate = ADDIWB;
            ADDIWB: nextstate = FETCH;
            JEX: nextstate = FETCH;
            default: nextstate = 4'bxxxx; // never happen
        endcase

    // output logic
    assign {pcwrite, memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, brwr, extop, pcwrcond, rtype, bne} = controls;
    
    always_comb
        case (state)
            FETCH:   controls = 20'b101000xx01010000xx00;
            DECODE:  controls = 20'b000000xx11xx00011000;
            MEMADR:  controls = 20'b000011xx10xx00001000;
            MEMRD:   controls = 20'b0000111010xx00001000;
            MEMWB:   controls = 20'b0001111010xx00001000;
            MEMWR:   controls = 20'b010011xx10xx00001000;
            RTYPEEX: controls = 20'b00001x0100xxxxx0x010;
            RTYPEWB: controls = 20'b0001100100xxxxx0x010;
            BEQEX:   controls = 20'b000010xx00100010x100;
            ADDIEX:  controls = 20'b00001x0010xx00001000;
            ADDIWB:  controls = 20'b0001100010xxxxx00000;
            JEX:     controls = 20'b1000xxxxxx00xxx0xx00;
            BNEEX:   controls = 20'b000010xx00100010x001;
            ANDIEX:  controls = 20'b00001x0010xx10000000;
            ORIEX:   controls = 20'b00001x0010xx01100000;
            SLTIEX:  controls = 20'b00001x0010xx10101000;
            default: controls = 20'bxxxxxxxxxxxxxxxxxxxx; // never happen
        endcase
    
endmodule
