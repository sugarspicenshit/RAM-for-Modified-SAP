`timescale 1ns / 1ps


module SAP_TB();
     reg [7:0] INRtb;
     reg INTtb;
     reg rsttb;
     reg clktb;
     wire [7:0] OUTRtb;
     wire[7:0] PCtb;   // PC
     wire [7:0] PCAtb;
     wire [2:0] statetb;
     wire [7:0] IRtb;
     wire [3:0] aluopselbt;
     wire [1:0] pcopseltb;
     wire [3:0] seldstbt;
     wire [3:0] selsrctb;
     wire [7:0] ALUREsulttb; // Primitive Chipscope
     wire [7:0] AYEtb;
     wire [7:0] BEEtb;
     wire [7:0] CEEtb;
     wire [7:0] MemOuttb;
     wire [7:0] MARtb;
SAP UUT(
.INR(INRtb),
.INT(INTtb),
.rst(rsttb),
.clk(clktb),
.OUTR(OUTRtb),
.PC(PCtb),   // PC
.PCA(PCAtb),
.state(statetb),
.IR(IRtb),
.aluopsel(aluopseltb),
.pcopsel(pcopseltb),
.seldst(seldsttb),
.selsrc(selsrctb),
.ALUREsult(ALUREsulttb),
.AYE(AYEtb),
.BEE(BEEtb),
.CEE(CEEtb), //CEE
.MemOut(MemOuttb),
.MAR(MARtb)
);
/*module SAP(
     input wire [7:0] INR,
     input wire [7:0] ROMDATA,
     input wire rst,
     input wire clk,
     output wire [7:0] OUTR,
     output wire[7:0] PC,   // PC
     output wire [2:0] state,
     output wire [3:0] aluopsel,
     output wire [1:0] pcopsel,
     output wire [3:0] seldst,
     output wire [3:0] selsrc,
     output wire [7:0] ALUREsult, // Primitive Chipscope
     output wire [7:0] AYE,
     output wire [7:0] BEE,
     output wire [7:0] MAR
    );
*/    
initial 
begin
   #5 rsttb=1'b0; clktb=1'b0; INRtb=8'h56; INTtb=1'b0;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INRtb = 8'h00;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 rsttb=1'b1;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   //IN [01] <- MEMIN
   #5 INRtb = 8'h01;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   // in[05] <- MEMIN
   #5 INRtb = 8'h05;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   
   //MEMOUT <- M[01]
   
  
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
  
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
  
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b1;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b0;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   
      #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b1;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b0;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   
      #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b1;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 INTtb=1'b0;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;

   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   #5 clktb=~clktb;
   
   
end

endmodule