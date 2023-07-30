`timescale 1ns / 1ps


module ALUINT_tb;

// Inputs
reg [7:0] ACC, BREG, Cval;
reg [3:0] OP;

// Outputs
wire [7:0] ALUOUT, ALUSHOW;
wire zf;

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
    .zf(zf)
);
    
// Testing process
initial begin
    // Initialize values
    ACC = 8'h2a; // Assign random value
    BREG = 8'h11; // Assign random value
    Cval = 8'h00;
    OP = 4'h0; // Initialize operation to none

    // Test all ALU operations
    for (i = 0; i <= 6; i = i + 1) begin
        OP = i; 
        #2;
    end 
    
    // Test A == B operation
    #2 ACC = 8'h2a;
    BREG = 8'h2a;
    #2 OP = 4'h7;
end

endmodule
