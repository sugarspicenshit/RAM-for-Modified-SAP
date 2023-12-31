`timescale 1ns / 1ps


module SAP(
    input wire [7:0] INR,
    input wire [3:0] INT,
    input wire rst,
    input wire clk,
    output wire [7:0] OUTR_1, 
    output wire [7:0] OUTR_2,  
    output wire [7:0] OUTR_3,  
    output wire [7:0] PC,           // PC
    output wire [3:0] state,
    output wire [7:0] IR,
    output wire [3:0] aluopsel,
    output wire [2:0] pcopsel,
    output wire [3:0] seldst,
    output wire [3:0] selsrc,
    output wire [7:0] ALUREsult,   // Primitive Chipscope
    output wire [7:0] AYE,
    output wire [7:0] BEE,
    output wire [7:0] CEE,
    output wire [7:0] LIT,
    output wire [7:0] MemOut,
    output wire [7:0] MAR,
    output wire [7:0] ACCAGP,
    output wire [7:0] STACK,
    output wire [7:0] RAMOUT,
    output wire wr_en,
    output wire zf
);

wire [7:0] MBRA;  
wire [15:0] ROMDATA;
wire [7:0] IRJUMP;
wire IRREF;
wire SELJUMP;
//wire wr_en;
//wire zf;

assign LIT = ROMDATA[7:0];
assign RAMOUT = MBRA;

ROMBasic U1 (
    .ADDR(PC), 
    .DATA(ROMDATA)
); 

IRDECODER U2 (
    .INT(INT),
    .OPCODE(ROMDATA[15:8]),
    .IRJUMP(IRJUMP),
    .IRREF(IRREF),
    .SELJUMP(SELJUMP),
    .aluopsel(aluopsel),
    .pcopsel(pcopsel),
    .seldst(seldst),
    .selsrc(selsrc),
    .state(state),
    .IR(IR),
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .zf(zf)
);

datapath U3 (
    .PortIN(INR), 
    .PortOUT_1(OUTR_1), 
    .PortOUT_2(OUTR_2), 
    .PortOUT_3(OUTR_3), 
    .PCOUT(PC), 
    .ALUREsult(ALUREsult), 
    .seldst(seldst), 
    .selsrc(selsrc), 
    .IRJUMP(IRJUMP), 
    .IRREF(IRREF), 
    .SELJUMP(SELJUMP), 
    .dsten(dstoe), 
    .srcen(srcoe), 
    .clk(clk), 
    .op(aluopsel), 
    .pcopsel(pcopsel), 
    .rst(rst), 
    .AYEQ(AYE), 
    .BEEQ(BEE), 
    .CEEQ(CEE), 
    .MemOut(MemOut), 
    .MARQ(MAR), 
    .ACCAGP(ACCAGP), 
    .MBRA(MBRA),
    .LIT(ROMDATA[7:0]),
    .zf(zf),
    .STACK(STACK)
);

RAM U4 (
    .addr(ROMDATA[7:0]), 
    .data_in(MemOut), 
    .data_out(MBRA), 
    .wr_en(wr_en), 
    .clk(clk), 
    .rst(rst)
); 
   
            
endmodule