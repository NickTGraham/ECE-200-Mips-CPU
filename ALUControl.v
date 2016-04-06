module ALUControl(ALUOp, funct, cntrl);
    input [1:0] ALUOp;
    input [5:0] funct;
    output [3:0] cntrl;

    always begin
        if(ALUOp == 2'b00) begin
            cntrl <= 4'b0010;
        end
        else if (ALUOp[0] == 1) begin
            cntrl <= 4'b0110;
        end
        else if(ALUOp[3:0] == 4'b0000) begin
            cntrl <= 4'b0010;
        end
        else if(ALUOp[3:0] == 4'b0010) begin
            cntrl <= 4'b0110;
        end
        else if(ALUOp[3:0] == 4'b0100) begin
            cntrl <= 4'b0000;
        end
        else if(ALUOp[3:0] == 4'b0101) begin
            cntrl <= 4'b0001;
        end
        else if(ALUOp[3:0] == 4'b1010) begin
            cntrl <= 4'b0111;
        end
    end

endmodule
