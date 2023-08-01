`timescale 1ns / 1ps


module SAP_TB2;

// Inputs
reg [7:0] INR;
reg [3:0] INT;
reg rst, clk;

// Outputs
wire [7:0] OUTR_1, OUTR_2, OUTR_3, PC, IR, ALUREsult, AYE, BEE, CEE, MemOut, MAR, LIT, ACCAGP, STACK, RAMOUT;
wire [3:0] state, aluopsel, seldst, selsrc;
wire [1:0] pcopsel;
wire wr_en, zf;

// Instantiate UUT
SAP UUT (
    .INR(INR),
    .INT(INT),
    .rst(rst),
    .clk(clk),
    .OUTR_1(OUTR_1),
    .OUTR_2(OUTR_2),
    .OUTR_3(OUTR_3),
    .PC(PC),
    .state(state),
    .IR(IR),
    .aluopsel(aluopsel),
    .pcopsel(pcopsel),
    .seldst(seldst),
    .selsrc(selsrc),
    .ALUREsult(ALUREsult),
    .AYE(AYE),
    .BEE(BEE),
    .CEE(CEE),
    .LIT(LIT),
    .MemOut(MemOut),
    .MAR(MAR),
    .ACCAGP(ACCAGP),
    .STACK(STACK),
    .RAMOUT(RAMOUT),
    .wr_en(wr_en),
    .zf(zf)
);

// Clock generation
always #1
    clk = ~clk;

// Testing process
initial
begin
    // Initialize the values
    rst = 1'h0;     // Reset the computer
    clk = 1'h1;     // High leading edge
    INR = 8'h56;    // Set the input port value 
    INT = 1'h0;     // Disable the interrupt flag
    #4 rst = 1'h1;  // After reset
end

endmodule