module Control(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);
    //TODO: Double check the Opcodes
    input[5:0] Opcode;
    output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
    output[1:0] ALUOp;

    reg RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
    reg[1:0] ALUOp;

    //Type      RegDst  ALUSrc  MemtoReg    RegWrite    MemRead     MemWrite    Branch      ALUOp   Jump
    //R-Type    1       0       0           1           0           0           0           10      0
    //lw        0       1       1           1           1           0           0           00      0
    //sw        X       1       X           0           0           1           0           00      0
    //beq       X       0       X           0           0           0           1           01      0
    //Jump      X       0       0           0           0           0           0           00      1
    //addi      0       1       0           1           0           0           0           11      0
    //andi      0       1       0           1           0           0           0           11      0
    //ori       0       1       0           1           0           0           0           11      0
    //slti      0       1       0           1           0           0           0           11      0
    //lui (its just ori man...)

    always @(Opcode) begin
        if(Opcode == 6'b000000) begin //R-Type
            RegDst <= 1;
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 2;
            Jump <= 0;
        end
        else if(Opcode == 6'b100011) begin //lw
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 0;
            Jump <= 0;
        end
        else if(Opcode == 6'b101011) begin //sw
            ALUSrc <= 1;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Branch <= 0;
            ALUOp <= 0;
            Jump <= 0;
        end
        else if(Opcode == 6'b000100) begin //beq
            ALUSrc <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 1;
            ALUOp <= 1;
            Jump <= 0;
        end
        else if(Opcode == 6'b000010) begin //j
            ALUSrc <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 0;
            Jump <= 1;
        end
        else if(Opcode == 6'b001000) begin //addi
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 3;
            Jump <= 0;
        end
        else if(Opcode == 6'b001101) begin //ori
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 3;
            Jump <= 0;
        end
        else if(Opcode == 6'b001100) begin //andi
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 3;
            Jump <= 0;
        end
        else if(Opcode == 6'b001010) begin //slti
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 3;
            Jump <= 0;
        end
        else if(Opcode == 6'b100000) begin //lb
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 00;
            Jump <= 0;
        end
        else if(Opcode == 6'b100001) begin //lh
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 00;
            Jump <= 0;
        end
        else if(Opcode == 6'b101000) begin //sb
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Branch <= 0;
            ALUOp <= 00;
            Jump <= 0;
        end
        else if(Opcode == 6'b101001) begin //sh
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Branch <= 0;
            ALUOp <= 00;
            Jump <= 0;
        end
    end
endmodule

module ControlTestBench();
    reg [5:0] OpCode;
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
    wire[1:0] ALUOp;

    Control t(OpCode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);
    initial begin
        #10 OpCode <= 6'b000000;
        #10 OpCode <= 6'b100011;
        #10 OpCode <= 6'b101011;
        #10 OpCode <= 6'b000100;
        #10 OpCode <= 6'b000010;
    end

    initial begin
        #3 $monitor($time, "s RegDst %b, Branch %b, MemRead %b, MemtoReg %b, MemWrite %b, ALUSrc %b, RegWrite %b, ALUOp %h Jump %b", RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, Jump);
    end

endmodule
