module CPU_ex();

    wire clk, RegDst, Branch, MemtoReg, RegWrite, overflow, zero, jump, ALUSrc, Jal, jump2;
    wire [1:0] ALUOp, MemRead, MemWrite;
    wire [4:0] ALUcntrl;
    wire [31:0] InstructionWire;
    wire [15:0] ImmediateData;
    wire [15:0] RegA, RegB, ALUA, ALUResult, ReadData, WriteData, ALUMEM;
    wire [4:0] write_address, tempWA;

    reg [31:0] progCountin, progCountout;
    reg [31:0] PCp4, JAdd, BranchCalc, BranchShift;
    reg [28:0] JShift;
    reg [15:0] ALUB, pcSaver;
    wire [15:0] Hi, Lo, jr;

    reg [5:0] i;

    initial begin
        i = 0;
        progCountin = 0;
        progCountout = 0;
    end

    always @(negedge clk) begin
        if(Jal) begin
            pcSaver = progCountin[15:0] + 4;
        end
        #5 i = i + 1;
        progCountout = progCountin + 4; //need to change back to 4!!!
        JAdd [31:28] = progCountout[31:28];
        JShift = (InstructionWire[25:0] << 2); //need to change back to 2
        JAdd [28:0] = JShift;
        BranchShift = InstructionWire[15:0] << 2; //need to change back to 0
        BranchCalc = BranchShift + progCountout;
        if(jump) begin
            progCountout = JAdd;
        end
        if(zero & Branch) begin
            progCountout = BranchCalc;
        end
        if(jump2) begin
            #5 progCountout = jr;
        end
        $display("PC %d, instruction %b, next PC %d, ALU Result %b, number %d", progCountin[5:0], InstructionWire, progCountout[5:0], ALUResult, i, $time);
        #5 progCountin <= progCountout;
    end

    always @(RegB or InstructionWire or ALUSrc) begin
        if (ALUSrc == 0) begin
            ALUB = RegB;
        end
        else begin
            ALUB = InstructionWire[15:0];
        end
    end

    clock mclk(clk);
    InstructionMem_ex IM(progCountin[6:0], InstructionWire, clk);
    mux25 wr(InstructionWire[20:16], InstructionWire[15:11], RegDst, tempWA);
    mux25 wr2(tempWA, 5'b01111, Jal, write_address);
    regfile RF(InstructionWire[25:21], InstructionWire[20:16], write_address, RegWrite, WriteData, RegA, RegB, clk);
    ALU Math(RegA, ALUB, ALUcntrl, InstructionWire[10:6], ALUResult, Hi, Lo, jr, overflow, zero, jump2);
    DataMem DM(ALUResult, MemWrite, MemRead, ReadData, RegB, clk);
    mux216 RES (ALUResult, ReadData, MemtoReg, ALUMEM);
    mux216 RES2 (ALUMEM, pcSaver, Jal, WriteData);
    Control MC(InstructionWire[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, jump, Jal);
    ALUControl AC(ALUOp, InstructionWire[5:0], InstructionWire[31:26], ALUcntrl);

endmodule

module clock(clk);
    output clk;
    reg clk;
    initial begin
        clk = 1;
    end
    always begin
        #100 clk <= !clk;
    end
endmodule

module mux25(A, B, sel, out);
    input [4:0] A, B;
    input sel;

    output reg [4:0] out;

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

    output reg [15:0] out;

    always @(A or B or sel) begin
        if(sel == 0)
            out<=A;
        else
            out<=B;
    end
endmodule

module mux232(A, B, sel, out);
    input [31:0] A, B;
    input sel;

    output reg [31:0] out;

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

    initial begin
        out = 0;
    end
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
endmodule

module pCUpdatePath(PC, JumpAmmount, BranchAmmount, JumpSelect, BranchZero, PCUpdated, clk);
    input [31:0] PC;
    input clk;
    input [15:0] BranchAmmount;
    input [25:0] JumpAmmount;
    input JumpSelect, BranchZero;

    output reg [31:0] PCUpdated;

    reg [31:0] PCp4, JAdd, BranchCalc, BranchShift;
    reg [28:0] JShift;

    wire [31:0] mux1, mux2;

    mux232 br(PCp4, BranchCalc, BranchZero, mux1);
    mux232 jmp(mux1, JAdd, JumpSelect, mux2);

    always @(negedge clk) begin
        PCp4 = PC + 4;
        JAdd [31:28] = PCp4[31:28];
        JShift = (JumpAmmount << 2);
        JAdd [28:0] = JShift;
        BranchShift = BranchAmmount << 2;
        BranchCalc = BranchAmmount + 4;
        #10 PCUpdated = mux2;
    end
endmodule
