`timescale 1ns / 1ps


module IRDECODERINT_tb;

// Inputs
reg [7:0] OPCODE;
reg clk, rst, INT;

// Outputs
wire [7:0] IRJUMP, IR;
wire [3:0] aluopsel, seldst, selsrc, state;
wire [2:0] pcopsel;
wire IRREF, SELJUMP, dstoe, srcoe, wr_en;

// Other variables
integer i;

// Instantiate UUT
IRDECODER UUT (
    .INT(INT),
    .OPCODE(OPCODE),
    .IRJUMP(IRJUMP),
    .IRREF(IRREF),
    .SELJUMP(SELJUMP),
    .aluopsel(aluopsel),
    .pcopsel(pcopsel),
    .seldst(seldst),
    .selsrc(selsrc),
    .state(state),
    .IR(IR),
    .dstoe(dstoe),
    .srcoe(srcoe),
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en)
);

// Clock generation
always #1
    clk = ~clk;
    
// Testing process
initial begin
    // Initialize inputs
    clk = 1'h1;
    INT = 1'h0;
    OPCODE = 8'h00;
    
    // Reset the decoder
    rst = 1'h0;
    #2 rst = 1'h1;
    
// Inputs
//reg [7:0] OPCODE;
//reg clk, rst, INT;
    // Test the interrupt
    #2 INT = 1'h1;
    #10 INT = 1'h0;
    
    // Iterate through all opcodes
    for (i = 0; i < 255; i = i + 1) begin
        #22 OPCODE = i;
    end
    
end

endmodule
