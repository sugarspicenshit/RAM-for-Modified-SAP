`timescale 1ns / 1ps


module sourcemuxINT_tb;

// Inputs
reg [7:0] A, B, C, INna, ALUOUT, MBR, PC;
reg [3:0] sel;
reg clk, srcoe;

// Outputs
wire [7:0] outna;

// Other variables
integer i;

// Instantiate UUT
sourcemux UUT (
    .A(A),
    .B(B),
    .C(C),
    .INna(INna),
    .ALUOUT(ALUOUT),
    .MBR(MBR),
    .PC(PC),
    .sel(sel),
    .clk(clk),
    .outna(outna),
    .srcoe(srcoe)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize input values (data in values are random)
    A = 8'h00;
    B = 8'h11;
    C = 8'h22;
    INna = 8'h33;
    ALUOUT = 8'h44;
    MBR = 8'h55;
    PC = 8'h66;
    sel = 4'h0;
    clk = 1'h0;
    srcoe = 1'h1;
    
    // Iterate through selector values
    for (i = 0; i < 16; i = i + 1) begin
        sel = i;
        
        // Run for 1 clock cycle and disable the MUX
        #2 srcoe = 1'h0;
        
        // Run for 2 clock cycles and reeanble the MUX
        #4 srcoe = 1'h1;
    end
end

endmodule
