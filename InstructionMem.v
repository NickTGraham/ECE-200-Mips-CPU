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
        $readmemb ("lstest.txt",instructions);
    end

    always @(posedge clk )
    begin

    temp <= instructions[read_address];

    end

endmodule

module InstructionTestbench ();
    reg [4:0] addr;
    wire [31:0] out;
    reg clk;
    InstructionMem t(addr, out, clk);

    initial begin
        addr <= 4'b0000;
        clk <= 0;
    end

    always begin
        #100 clk <= !clk;
    end
    always @(posedge clk)
    begin
        $monitor ($time, "s %b", out);
        addr = addr + 1;
    end
endmodule
