module ALUControl(ALUOp, funct, Opcode, cntrl);
    input [1:0] ALUOp;
    input [5:0] funct;
    input [5:0] Opcode;
    output [4:0] cntrl;

    reg [4:0] cntrl;

    always @(ALUOp or funct) begin
        if(ALUOp == 2'b00) begin
            cntrl <= 5'b00010;
        end
        else if (ALUOp == 2'b01) begin
            cntrl <= 5'b00110;
        end
        else if (ALUOp == 2'b11) begin //handle the immediate instructions, since they have no funct and there are too many, using Opcode
            if(Opcode == 6'b001000) begin //addi
                cntrl <= 5'b00010;
            end
            if(Opcode == 6'b001101) begin //ori
                cntrl <= 5'b00001;
            end
            if(Opcode == 6'b001100) begin //andi
                cntrl <= 5'b00000;
            end
            if(Opcode == 6'b001010) begin //slti
                cntrl <= 5'b00111;
            end
            if(Opcode == 6'b000001) begin //slti
                cntrl <= 5'b01111;
            end
        end
        else if(funct == 6'b100000) begin
            cntrl <= 5'b00010;
        end
        else if(funct == 6'b100010) begin
            cntrl <= 5'b00110;
        end
        else if(funct == 6'b100100) begin
            cntrl <= 5'b00000;
        end
        else if(funct == 6'b100101) begin
            cntrl <= 5'b00001;
        end
        else if(funct == 6'b101010) begin
            cntrl <= 5'b00111;
        end
        else if(funct == 6'b100111) begin
            cntrl <= 5'b01100;
        end
        else if(funct == 6'b011000) begin //mul
            cntrl <= 5'b10000;
        end
        else if(funct == 6'b011010) begin //div
            cntrl <= 5'b10001;
        end
        else if(funct == 6'b010000) begin //mfi
            cntrl <= 5'b10010;
        end
        else if(funct == 6'b010010) begin //mlo
            cntrl <= 5'b10011;
        end
        else if(funct == 6'b000000) begin //sll
            cntrl <= 5'b10100;
        end
        else if(funct == 6'b000010) begin //srl
            cntrl <= 5'b10101;
        end
        else if(funct == 6'b001000) begin //jr
            cntrl <= 5'b10111;
        end
    end

endmodule

module ALUControlTestbench ();
    reg [1:0] ALUOp;
    reg [5:0] funct;
    wire [3:0] cntrl;

    initial begin
        ALUOp = 0;
        funct = 0;
    end

    ALUControl t(ALUOp, funct, cntrl);

    always begin
        while (ALUOp < 3) begin
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b000000;
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b000010;
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b000100;
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b000101;
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b001010;
            #10 $monitor ($time, "s %b %b %b", ALUOp, funct, cntrl);
            funct <= 6'b111111;
            #10 ALUOp = ALUOp + 1;
        end
        $finish;
    end
endmodule
