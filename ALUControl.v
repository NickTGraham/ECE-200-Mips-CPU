module ALUControl(ALUOp, funct, cntrl);
    input [1:0] ALUOp;
    input [5:0] funct;
    output [3:0] cntrl;

    reg [3:0] cntrl;

    always @(ALUOp or funct) begin
        if(ALUOp == 2'b00) begin
            cntrl <= 4'b0010;
        end
        else if (ALUOp[0] == 1) begin
            cntrl <= 4'b0110;
        end
        else if(funct[3:0] == 4'b0000) begin
            cntrl <= 4'b0010;
        end
        else if(funct[3:0] == 4'b0010) begin
            cntrl <= 4'b0110;
        end
        else if(funct[3:0] == 4'b0100) begin
            cntrl <= 4'b0000;
        end
        else if(funct[3:0] == 4'b0101) begin
            cntrl <= 4'b0001;
        end
        else if(funct[3:0] == 4'b1010) begin
            cntrl <= 4'b0111;
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