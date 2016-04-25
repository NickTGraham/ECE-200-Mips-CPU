module ALU(inA, inB, control, shamt, result, Hi, Lo, jr, overflow, zero, jump);
    input signed [15:0] inA, inB;
    input [4:0] control;
    input [4:0] shamt;
    output reg [15:0] result;
    output reg signed [15:0] Hi, Lo, jr;
    output reg overflow;
    output reg zero, jump;
    reg signed [31:0] temp;

always @(inA, inB, control) begin
    case(control)
        5'b00000 : begin
                    result <= inA & inB;
                    zero = 0;
                  end
        5'b00001 : begin
                    result <= inA | inB;
                    zero = 0;
                  end
        5'b00010 : begin
                    result = inA + inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                    zero = 0;
                  end
        5'b00110 : begin
                    result = inA - inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                    zero = ~(result[0] | result[1] | result[2] | result[3] | result[4] | result[5] | result[6] | result[7] | result[8] | result[9] | result[10] | result[11] | result[12] | result[13] | result[14] | result[15]);
                  end
        5'b00111 : begin
                    result <= inA < inB ? 1:0;
                    zero = 0;
                  end
        5'b01100 : begin
                    result <= ~(inA | inB);
                    zero = 0;
                  end
        5'b01111 : begin
                  result <= (inA > 0);
                  zero = ~(inA > 0);
                  end
        5'b10000 : begin
                  temp = (inA*inB);
                  result = 0;
                  Hi = temp[31:16];
                  Lo = temp[15:0];
                  zero = 0;
                  end
        5'b10001 : begin
                  temp = inA/inB;
                  result = 0;
                  Hi = temp[31:16];
                  Lo = temp[15:0];
                  zero = 0;
                  end
        5'b10010 : begin //High
                  result = Hi;
                  zero = 0;
                  end
        5'b10011 : begin //Low
                  result = Lo;
                  zero = 0;
                  end
        5'b10100 : begin //sll
                  result = inB << shamt;
                  zero = 0;
                  end
        5'b10101 : begin //srl
                  result = inB >> shamt;
                  zero = 0;
                  end
        5'b10111 : begin //jr
                  result = 0;
                  zero = 0;
                  jump = 1;
                  jr = inA;
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
    reg [4:0] control;
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
