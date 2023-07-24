`timescale 1ns / 1ps


module regbasicINT_tb;

// Inputs
reg [7:0] D;
reg rst, clk;

// Outputs
wire [7:0] Q;

// Other variables
integer i;

// Instantiate UUT
regbasic UUT (
    .Q(Q),
    .D(D),
    .rst(rst),
    .clk(clk)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize values
    clk = 1'h1;
    rst = 1'h0;  // Reset
    D = 8'h00;
    #2 rst = 1'h1;  // After reset
   
    // Write values on the register
    for (i = 0; i <= 5; i = i + 1) begin
        D = i;
        #2;
    end 
end

endmodule
