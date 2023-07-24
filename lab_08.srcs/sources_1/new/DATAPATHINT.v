`timescale 1ns / 1ps


module datapath(
    input wire [7:0] PortIN,        // INR
    output wire [7:0] PortOUT,      // OUTR
    output wire [7:0] PCOUT,        // PC
    output wire [7:0] ALUREsult,    // Primitive Chipscope
    input wire [3:0] seldst,        // demux control
    input wire [3:0] selsrc,        // sourcemux control
    input wire [7:0] IRJUMP,
    input wire IRREF,
    input wire SELJUMP,
    input wire dsten,               // on or off demux
    input wire srcen,               // on or off mux
    input wire clk,                 // clock
    input wire [3:0] op,            // alu operations selector
    input wire [2:0] pcopsel,       // selects the operation of the PC
    input wire rst,
    output wire [7:0] AYEQ,
    output wire [7:0] BEEQ,
    output wire [7:0] CEEQ,
    output wire [7:0] MemOut,
    output wire [7:0] MARQ,
    output wire [7:0] ACCAGP,
    input wire [7:0] MBRA
);

wire [7:0] INQ;
//wire [7:0] OUTA;
//wire [7:0] OUTQ;
wire [7:0] AYEA;
wire [7:0] BEEA;
wire [7:0] CEEA;
wire [7:0] buswires;
wire [7:0] accagp;
//wire [7:0] PCA;
wire [7:0] pcjmp;
wire [7:0] MARA;
wire [7:0] MBRQ; 
//wire [7:0] STKA;
wire [7:0] STKQ; 
//wire [7:0] Memo;

// Not connected: pcjmp
demux U1 (AYEA, BEEA, CEEA, MemOut, PortOUT, pcjmp, MARA, seldst, clk, buswires, dsten);

sourcemux U2 (AYEQ, BEEQ, CEEQ, INQ, ACCAGP, MBRQ, STKQ, selsrc, clk, buswires, srcen);

regbasic U3 (INQ, PortIN, rst, clk);    // INR 
regbasic U4 (AYEQ, AYEA, rst, clk);     // ACC
regbasic U5 (BEEQ, BEEA, rst, clk);     // BREG
regbasic U12 (CEEQ, CEEA, rst, clk);    // C 
regbasic U8 (MARQ, MARA, rst, clk);     // MAR
regbasic U9 (MBRQ, MBRA, rst, clk);     // MBR
 
d4breg U10(PCOUT, clk, STKQ, IRREF);    // Stack

ALU U6(AYEQ, BEEQ, CEEQ, op, ACCAGP, ALUREsult, clk);

PC U7(ACCAGP, clk, pcopsel, rst, PCOUT);

// TODO: Check if ACCAGP is supposed to be connected there
// This is fine for now as long as PC doesn't branch
basicmux U11 (IRJUMP,MARQ,SELJUMP,clk,ACCAGP);
//basicmux U6(AYEA,alutrib,alupsel,clk,accagp);

endmodule
