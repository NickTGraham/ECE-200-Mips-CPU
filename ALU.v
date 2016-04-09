module ALU(inA, inB, control, result, overflow);
    input [15:0] inA, inB;
    input [3:0] control;
    output reg [15:0] result;
    output reg overflow;

always @(inA, inB, control, overflow) begin
    case(control)
        4'b0000 : result <= inA & inB;
        4'b0001 : result <= inA | inB;
        4'b0010 : begin
                    result = inA + inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                  end
        4'b0110 : begin
                    result = inA - inB;
                    overflow = (inA[15] == inB[15]) ? (result[15] != inA[15]) : 0;
                  end
        4'b0111 : result <= inA < inB ? 1:0;
        4'b1100 : result <= ~(inA | inB);
        default : result <= 16'bX;
    endcase
end
endmodule

module ALUTestbench ();
    reg clock;
    reg [15:0] inA,inB;
    reg [3:0] control;
    wire [15:0] result;

    ALU ok1(.inA(inA), .inB(inB), .control(control);

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

