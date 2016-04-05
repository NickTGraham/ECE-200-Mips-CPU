module regfile (read_address_one, read_address_two, write_address, write_enable, write_data, A, B, clk);
    input [4:0] read_address_one, read_address_two, write_address;
    input write_enable, clk;
    input [16:0] write_data;

    output [15:0] A, B;
    wire [15:0] A, B;
    reg [15:0] tempA, tempB;

    assign A = tempA;
    assign B = tempB;

    wire clk;

    reg [15:0] data [0:15];

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

module RegTestbench ();
    reg [4:0] addr_one, addr_two, write_addr;
    wire [15:0] A, B;
    reg clk, we;
    reg [16:0] wd;
    regfile t(addr_one, addr_two, write_addr, we, wd, A, B, clk);
    initial begin
        addr_one <= 4'b0000;
        addr_two <= 4'b0000;
        write_addr <= 4'b0000;
        wd = 8;
        clk <= 0;
        we <= 1;
    end

    always begin
        #100 clk <= !clk;
    end
    always @(posedge clk)
    begin
        if(addr_one < 20) begin
            $monitor ($time, "s %b %b", A, B);
            addr_one = addr_one + 1;
            addr_two = addr_two + 1;
            write_addr = write_addr + 1;
        end
        else begin
            we = 0;
            addr_one = 4'b0000;
            addr_two = 4'b0000;
        end

    end
endmodule
