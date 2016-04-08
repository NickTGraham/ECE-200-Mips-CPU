module Control(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    //TODO: Double check the Opcodes
    input[5:0] Opcode;
    output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    output[1:0] ALUOp;

    //Type      RegDst  ALUSrc  MemtoReg    RegWrite    MemRead     MemWrite    Branch      ALUOp
    //R-Type    1       0       0           1           0           0           0           10
    //lw        0       1       1           1           1           0           0           00
    //sw        X       1       X           0           0           1           0           00
    //beq       X       0       X           0           0           0           1           01

    always @(Opcode) begin
        if(Opcode == 6'b000000) begin //R-Type
            RegDst = 1;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
        end
        if(Opcode == 6'b100011) begin //lw
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
        if(Opcode == 6'b101011) begin //sw
            ALUSrc = 1;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00;
        end
        if(Opcode == 6'b000100) begin //beq
            ALUSrc = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01;
        end
    end
endmodule
