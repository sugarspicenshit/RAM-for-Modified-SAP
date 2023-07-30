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
    input wire [7:0] MBRA,
    input wire [7:0] LIT
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
wire zf;

// Destination register demultiplexer
// Not connected: pcjmp
demux U1 (
    .A(AYEA), // seldst = 4'h1
    .B(BEEA), // seldst = 4'h2
    .C(CEEA), // seldst = 4'h3
    .Mem(MemOut), // seldst = 4'h4; to RAM's data in port
    .outbuf(PortOUT), // seldst = 4'h5
    .pcjmp(pcjmp), // seldst = 4'h6
    .MAR(MARA), // seldst = 4'h7
    .sel(seldst), 
    .busin(buswires) 
);

// Source register multiplxer
sourcemux U2 (
    .A(AYEQ), // selsrc = 4'h1
    .B(BEEQ), // selsrc = 4'h2
    .C(CEEQ), // selsrc = 4'h3
    .INna(INQ), // selsrc = 4'h4
    .ALUOUT(accagp), // selsrc = 4'h5
    .MBR(MBRQ), // selsrc = 4'h6; from RAM's data out port
    .PC(STKQ), // selsrc = 4'h7
    .LIT(LIT), // selsrc = 4'h8
    .sel(selsrc), 
    .busout(buswires)
);

regbasic U3 (INQ, PortIN, rst, clk);    // INR 
regbasic U4 (AYEQ, AYEA, rst, clk);     // ACC
regbasic U5 (BEEQ, BEEA, rst, clk);     // BREG
regbasic U12 (CEEQ, CEEA, rst, clk);    // C 
regbasic U8 (MARQ, MARA, rst, clk);     // MAR
regbasic U9 (MBRQ, MBRA, rst, clk);     // MBR
 
d4breg U10(PCOUT, clk, STKQ, IRREF);    // Stack

ALU U6(AYEQ, BEEQ, CEEQ, op, accagp, ALUREsult, zf);

PC U7(ACCAGP, clk, pcopsel, rst, PCOUT);

basicmux U11 (
    .ACCTRIB(IRJUMP), // ALUPSEL = 1'h1; interrupt vector
    .ALUIN(MARQ), // ALUPSEL = 1'h0
    .ALUPSEL(SELJUMP), 
    .ACCAGP(ACCAGP)
);

endmodule
