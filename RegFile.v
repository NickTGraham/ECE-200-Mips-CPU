module regfile (read_address_one, read_address_two, write_address, write_enable, write_data, A, B, clk);
    input [4:0] read_address_one, read_address_two, write_address;
    input write_enable;
    input [16:0] write_data;

    output [15:0] A, B;
    wire [15:0] A, B;
    reg [15:0] tempA, tempB;

    assign A = tempA;
    assign B = tempB;

    wire clk;

    reg [16:0] data[0:16];

    initial begin
        $readmemb ("registers.txt",data);
    end

    always @(posedge clk )
    begin

    tempA <= data[read_address_one];
    tempB <= data[read_address_two];

    end

    always @(negedge clk )
    begin
    if(write_enable == 1)
        data[read_address_one] <= write_data;
    end

endmodule
