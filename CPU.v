module CPU();

    wire clk, RegDst, Branch, MemRead, MemtoReg, MemWrite, RegWrite, overflow;
    wire [1:0] ALUOp;
    wire [3:0] ALUcntrl;
    wire [31:0] InstructionWire, ImmediateData;
    wire [15:0] RegA, RegB, ALUB, ALUA, ALUResult, ReadData, WriteData;

    reg [31:0] PCin, PCout;

    PC progCount(PCin, PCout, clk);
    InstructionMem IM(PC, InstructionWire, clk);
    mux25 wr(InstructionWire[20:16], InstructionWire[15:11], RegDst, write_address);
    regfile RF(InstructionWire[25:21], InstructionWire[20:16], write_address, RegWrite, WriteData, RegA, RegB, clk);
    signextend1632 ID(InstructionWire[15:0], ImmediateData);
    mux216 BV(RegB, ImmediateData, ALUSrc, ALUB);
    ALU Math(ALUA, ALUB, ALUcntrl, ALUResult, overflow);
    DataMem DM(ALUResult, MemWrite, MemRead, ALUB, ReadData, clk);
    mux216 RES (ALUResult, ReadData, MemtoReg, WriteData);
    Control MC(InstructionWire[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    ALUControl AC(ALUOp, InstructionWire[5:0], ALUcntrl);

    always @(negedge clk) begin
        PCin <= PCin + 4;
    end
endmodule

module clock(clk);
    output clk;
    reg clk;

    always begin
        #100 clk <= !clk;
    end
endmodule

module mux25(A, B, sel, out);
    input [4:0] A, B;
    input sel;

    output [4:0] out;

    always @(A or B or sel) begin
        if(sel == 0)
            out<=A;
        else
            out<=B;
    end
endmodule

module mux216(A, B, sel, out);
    input [15:0] A, B;
    input sel;

    output [15:0] out;

    always @(A or B or sel) begin
        if(sel == 0)
            out<=A;
        else
            out<=B;
    end
endmodule

module PC(in, out, clk);
    input [31:0] in;
    input clk;
    output [31:0] out;

    reg [31:0] out;

    always @(posedge clk) begin
        out <= in;
    end
endmodule

module signextend1632(in, out);
    input [15:0] in;
    output [31:0] out;

    reg [31:0] out;

    always @(in) begin
        out[31] <= in[15];
        out[30] <= in[15];
        out[29] <= in[15];
        out[28] <= in[15];
        out[27] <= in[15];
        out[26] <= in[15];
        out[25] <= in[15];
        out[24] <= in[15];
        out[23] <= in[15];
        out[22] <= in[15];
        out[21] <= in[15];
        out[20] <= in[15];
        out[19] <= in[15];
        out[18] <= in[15];
        out[17] <= in[15];
        out[16] <= in[15];
        out[15:0] <= in;
    end
end module;
