`timescale 1ns / 1ps


module ALUINT_tb;

// Inputs
reg [7:0] ACC, BREG, Cval;
reg [3:0] OP;
reg clk;

// Outputs
wire [7:0] ALUOUT, ALUSHOW;

// Other variables
integer i;

// Instantiate UUT
ALU UUT (
    .ACC(ACC),
    .BREG(BREG),
    .Cval(Cval),
    .OP(OP),
    .ALUOUT(ALUOUT),
    .ALUSHOW(ALUSHOW),
    .clk(clk)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize values
    clk = 1'h1;
    ACC = 8'h2a; // Assign random value
    BREG = 8'h11; // Assign random value
    Cval = 8'h00;
    OP = 4'h0; // Initialize operation to none

    // Test all ALU operations
    for (i = 0; i <= 7; i = i + 1) begin
        OP = i; 
        #2;
    end 
end

endmodule
