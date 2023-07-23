`timescale 1ns / 1ps


module SAP_TB2;

// Inputs
reg [7:0] INR;
reg INT, rst, clk;

// Outputs
wire [7:0] OUTR, PC, PCA, IR, ALUREsult, AYE, BEE, CEE, MemOut, MAR;
wire [3:0] state, aluopsel, seldst, selsrc;
wire [1:0] pcopsel;

// Instantiate UUT
SAP UUT (
    .INR(INR),
    .INT(INT),
    .rst(rst),
    .clk(clk),
    .OUTR(OUTR),
    .PC(PC),
    .PCA(PCA),
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
    .MemOut(MemOut),
    .MAR(MAR)
);

// Clock generation
always #1
    clk = ~clk;

// Testing process
initial
begin
    rst=1'b0; 
    clk=1'b1; 
    INR=8'h56; 
    INT=1'b0;
    #4 rst=1'b1;
end

endmodule