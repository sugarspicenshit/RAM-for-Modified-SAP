`timescale 1ns / 1ps


module RAM(addr, data_in, data_out, wr_en, clk, rst);

input [7:0] addr;
input [7:0] data_in;
output reg [7:0] data_out;
input wire wr_en, clk, rst;

reg [7:0] Mem [0:255];
reg [7:0] internal_bus;

integer i;

initial internal_bus = Mem[addr];       // initialize what's at the output

always @addr internal_bus = Mem[addr];  // update what's at the output

always @(posedge clk)
    if (!rst)
        for (i = 0; i < 256; i = i + 1)
            Mem[i] = 8'h00;             // flush all memory locations at reset
        

always @(posedge clk)
    if (rst)       
        if (wr_en == 1) 
        begin
            Mem[addr] = data_in;        // load value into memory
            internal_bus = Mem[addr]; 	// update what's at the output
        end
    
always @(posedge clk)
    if (rst)
        if(!wr_en)
        begin
            data_out = internal_bus;
        end

endmodule

