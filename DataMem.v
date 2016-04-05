module DataMem (address, write_enable, write, read, clk);
    reg [7:0] data [0:20]; //so no idea how long to really make this, so starting with max
    input [15:0] address, read;
    input write_enable, clk;
    output [15:0] write;


    wire clk;
    wire [15:0] write;
    reg [15:0] temp;

    assign write = temp;

    initial begin
        $readmemb ("./data.txt",data);
    end

    always @(posedge clk )
    begin
        if(write_enable == 1) begin
            data[address] = read[15:8];
            data[address + 1] = read[7:0];
          end
        else begin
            temp[15:8] <= data[address];
            temp[7:0] <= data[address+1];
          end

    end

endmodule

module DataTestbench ();
    reg [15:0] addr, read;
    wire [15:0] write;
    reg clk, we;
    DataMem t(addr, we, write, read, clk);

    initial begin
        addr <= 4'h0000;
        read <= 2048;
        clk <= 0;
        we <= 1;
    end

    always begin
        #100 clk <= !clk;
    end
    always @(posedge clk)
    begin
        if(addr < 20) begin
            $monitor ($time, "s %b", write);
            addr = addr + 2;
        end
        else begin
            we = 0;
            addr = 4'h0000;
        end

    end
endmodule
