module InstructionMem (address, write_enable, out, in, clk);
    input [65535:0] data[0:7]; //so no idea how long to really make this, so starting with max
    input [15:0] address, in;

    output [15:0] out;


    wire clk;
    wire [15:0] out;
    reg [15:0] temp;

    assign out = temp;

    initial begin
        $readmemb ("data.txt",instructions);
    end

    always @(posedge clk )
    begin
        if(write_enable == 1)
            data[address] = in[15:8];
            data[address + 1] = in[7:0];
        else
            temp[15:8] <= data[address];
            temp[7:0] <= data[address+1]

    end

endmodule
