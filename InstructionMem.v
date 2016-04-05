module InstructionMem (read_address, out, clk);
    reg [31:0] instructions [0:31]; //so no idea how long to really make this, so starting with 32 instructions
    input [4:0] read_address;
    output [31:0] out;
    input clk;

    wire clk;
    wire [31:0] out;
    reg [31:0] temp;

    assign out = temp;

    initial begin
        $readmemb ("instructions.txt",instructions);
    end

    always @(posedge clk )
    begin

    temp <= instructions[read_address];

    end

endmodule
