`timescale 1ns / 1ps


module SAP(
    input wire [7:0] INR,
    input wire INT,
    input wire rst,
    input wire clk,
    output wire [7:0] OUTR,
    output wire [7:0] PC,           // PC
    output wire [7:0] PCA,
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
    output wire [7:0] MemOut,
    output wire [7:0] MAR,
    output wire dstoe,
    output wire srcoe
);

wire [7:0] MBRA;  
wire [15:0] ROMDATA; 
//wire dstoe;
//wire srcoe;
wire [7:0] IRJUMP;
wire IRREF;
wire SELJUMP;
wire wr_en;
wire [7:0] MARQ;

ROMBasic U1 (PC, ROMDATA, clk, rst); 
// IRDECODER U2 (INT, ROMDATA[15:8], IRJUMP, IRREF, SELJUMP, aluopsel, pcopsel, seldst, selsrc, state, IR, dstoe, srcoe, clk, rst, wr_en);
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
    .dstoe(dstoe),
    .srcoe(srcoe),
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en)
);


//datapath U3 (INR,OUTR,PC,ALUREsult,seldst,selsrc,IRJUMP,IRREF,SELJUMP,dstoe,srcoe,clk,aluopsel,pcopsel,rst,AYE,BEE,CEE,MemOut,MAR,PCA,MBRA);
datapath U3 (INR, OUTR, PC, ALUREsult, seldst, selsrc, IRJUMP, IRREF, SELJUMP, dstoe, srcoe, clk, aluopsel, pcopsel, rst, AYE, BEE, CEE, MemOut, MARQ, MAR, MBRA);

// RAM (addr, data_in, data_out, wr_en, clk)
// This is ok i think maybe idk
// RAM U4 (MARQ, CEE, MBRA, wr_en, clk);
RAM U4 (ROMDATA[7:0], MemOut, MBRA, wr_en, clk, rst); 
    
//RAM U12(ROMDATA, MemOut, CEE, wr_en, clk);
   
            
endmodule