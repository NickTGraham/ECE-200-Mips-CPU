module ALU(inA, inB, control, result, overflow, zero);
    input [15:0] inA, inB;
    input [3:0] control;
    output reg [15:0] result;
    output reg overflow;
    output reg zero;

always @(inA, inB, control) begin
    case(control)
        4'b0000 : begin
                    result <= inA & inB;
                    zero = 0;
                  end
        4'b0001 : begin
                    result <= inA | inB;
                    zero = 0;
                  end
        4'b0010 : begin
                    result = inA + inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                    zero = 0;
                  end
        4'b0110 : begin
                    result = inA - inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                    zero = ~(result[0] | result[1] | result[2] | result[3] | result[4] | result[5] | result[6] | result[7] | result[8] | result[9] | result[10] | result[11] | result[12] | result[13] | result[14] | result[15]);
                  end
        4'b0111 : begin
                    result <= inA < inB ? 1:0;
                    zero = 0;
                  end
        4'b1100 : begin
                    result <= ~(inA | inB);
                    zero = 0;
                  end
        4'b1111 : begin
                  result <= (inA > 0);
                  zero = ~(inA > 0);
                  end
        default : begin
                    result <= 16'bX;
                    zero = 0;
                  end
    endcase
end
endmodule

module ALUTestbench ();
    reg clock;
    reg [15:0] inA,inB;
    reg [3:0] control;
    wire [15:0] result;

    ALU ok1(.inA(inA), .inB(inB), .control(control));

    initial
    begin
    clock = 0;
    end

    always
    begin
    #25 clock = ~clock;
    end

    initial begin

    inA=16'b0000000000010001;
    inB=16'b0000000000000010;
    control=4'b0000;
    #100;

    inA=16'b0000000000001100;
    inB=16'b0000000001000000;
    control=4'b0001;
    #100;

    inA=16'b0000000000000101;
    inB=16'b0000000000100010;
    control=4'b0010;
    #100;

    inA=16'b0000001000000000;
    inB=16'b0000000000001111;
    control=4'b0110;
    #100;

    inA=16'b0000000000010000;
    inB=16'b0000010000010000;
    control=4'b0111;
    #100;

    inA=16'b0000000100000000;
    inB=16'b0000000100000000;
    control=4'b1100;
    #100;
    $stop;
end
endmodule
