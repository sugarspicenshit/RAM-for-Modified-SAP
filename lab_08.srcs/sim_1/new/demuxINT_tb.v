`timescale 1ns / 1ps


module demuxINT_tb;

// Inputs
reg [7:0] busfin;
reg [3:0] sel;
reg clk, busin;

// Outputs
wire [7:0] A, B, C, Mem, outbuf, pcjmp, MAR;

// Other variables
integer i;

// Innstantiate UUT
demux UUT (
    .A(A),
    .B(B),
    .C(C),
    .Mem(Mem),
    .outbuf(outbuf),
    .pcjmp(pcjmp),
    .MAR(MAR),
    .sel(sel),
    .clk(clk),
    .busfin(busfin),
    .busin(busin)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize inputs
    busfin = 8'h8f; // Set input word value randomnly
    clk = 1'h1;     // Leading edge = 1     
    busin = 1'h1;
    
    // Iterate through all selectors
    for (i = 0; i < 16; i = i + 1) begin
        sel = i;
        #2 busfin = 8'h99;
        #2 busin = 1'h0;
        #4 busin = 1'h1;
        busfin = 8'h8f;
    end
end

endmodule
