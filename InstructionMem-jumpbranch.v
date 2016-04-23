module InstructionMem_jb (read_address, out, clk);
    reg [7:0] instructions [0:50]; //so no idea how long to really make this, so starting with 32 instructions
    input [5:0] read_address;
    output [31:0] out;
    input clk;

    wire clk;
    wire [31:0] out;
    reg [31:0] temp;

    assign out = temp;

    initial begin
        $readmemb ("jbTestinstr.txt",instructions);
    end

    always @(posedge clk )
    begin

    temp[31:24] <= instructions[read_address];
    temp[23:16] <= instructions[read_address + 1];
    temp[15:8] <= instructions[read_address + 2];
    temp[7:0] <= instructions[read_address + 3];

    end

endmodule

module InstructionTestbench ();
    reg [5:0] addr;
    wire [31:0] out;
    reg clk;
    InstructionMem t(addr, out, clk);

    initial begin
        addr <= 5'b0000;
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
