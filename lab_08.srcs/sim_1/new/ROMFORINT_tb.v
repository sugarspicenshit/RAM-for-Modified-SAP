`timescale 1ns / 1ps


module ROMFORINT_tb;

// Inputs
reg [7:0] ADDR;
reg clk, rst;

// Outputs
wire [7:0] DATA;

// Other variables
integer i;

// Instantiate UUT
ROM UUT ( 
    .ADDR(ADDR),
    .DATA(DATA),
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
    ADDR = 8'h00;
    
    // Reset the ROM
    rst = 1'h0;
    #2 rst = 1'h1;
    
    // Read and write an all memory locations
    for (i = 0; i < 255; i = i + 1) begin
        #2 ADDR = i;
    end
    
end

endmodule
