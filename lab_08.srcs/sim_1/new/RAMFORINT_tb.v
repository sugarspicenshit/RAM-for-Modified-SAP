`timescale 1ns / 1ps


module RAMFORINT_tb;

// Inputs
reg [7:0] addr, data_in;
reg clk, rst, wr_en;

// Outputs
wire [7:0] data_out;

// Other variables
integer i;

// Instantiate UUT
RAM UUT ( 
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .wr_en(wr_en),
    .clk(clk),
    .rst(rst)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize inputs
    clk = 1'h1;
    addr = 8'h00;
    data_in = 8'h00;
    wr_en = 1'h1;
    
    // Reset the RAM
    rst = 1'h0;
    #2 rst = 1'h1;
    
    // Read and write an all memory locations
    for (i = 0; i < 255; i = i + 1) begin
        addr = i;
        data_in = i;
        #2 wr_en = 1'h0;
        #2 wr_en = 1'h1;
    end
    
end

endmodule
