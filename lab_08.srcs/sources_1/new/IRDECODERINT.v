`timescale 1ns / 1ps


module IRDECODER(
    input wire INT,
    input wire [7:0] OPCODE,
    output reg [7:0] IRJUMP,
    output reg IRREF,
    output reg SELJUMP,
    output reg [3:0] aluopsel,
    output reg [2:0] pcopsel,
    output reg [3:0] seldst,
    output reg [3:0] selsrc,
    output reg [3:0] state,
    output reg [7:0] IR,
    output reg dstoe,
    output reg srcoe,
    input wire clk,
    input wire rst,
    output reg wr_en
    );

reg statex;
reg prima;


initial
begin
prima=1'b0;
state=4'h0;
IR=8'h0;
dstoe=1'b1;
srcoe=1'b1;
seldst=4'h0; 
selsrc=4'h0; 
aluopsel=4'h0;      
pcopsel=2'h0;
IRREF=1'b0;  // Stack Refresh
SELJUMP=1'b0; //MAR Selected
IRJUMP=8'd33; // Jump vector For Interrupt
statex=1'b0;
end

    
always@(posedge clk)
begin
    if(!rst) begin
             state=4'h0;
             prima=1'b0;
             IR=8'h0;
             dstoe=1'b1;
             srcoe=1'b1;
             seldst=4'h0; 
             selsrc=4'h0; 
             aluopsel=4'h0; 
             pcopsel=2'h0;
             statex=1'b0;
             IRREF=1'b0;  // Stack Refresh
             SELJUMP=1'b0; //MAR Selected
             IRJUMP=8'd33; // Jump vector For Interrupt
             wr_en=1'b0;
             end 
    if(rst) begin
                 if(INT==1'b1 & state!=4'h0) begin
                         prima=1'b1;
                         end
                 if(prima==1'b1 & state==4'h0)
                    begin
                    prima=1'b0; // reset prima value
                    statex=1'b1; // primes interrupt routine to start
                    end
                 if(statex)
                 begin
                 case(state)
                 3'h0: begin
                       IRJUMP=8'd33; // Jump vector For Interrupt
                       IRREF=1'b1;  // Stack Obtain data
                       SELJUMP=1'b1; //IRJMP Selected
                       state=state+1;
                       end
                 3'h1: begin
                       IRREF=1'b0;  // Stack Refresh
                       SELJUMP=1'b1; //IRJUMP Selected
                       pcopsel=2'h2; // Load data from IRJMP to PC
                       state=state+1;
                       end
                 3'h2: begin
                       SELJUMP=1'b0; //IRJUMP Selected
                       pcopsel=2'h0; // PC Refresh
                       state=4'h0;  // Reset State
                       statex=1'b0; // Ends ISR Vector
                       end                       
                endcase
                end
                if(!statex)
                begin
                    dstoe=1'b1;
                    srcoe=1'b1;
                    case(state)
                    4'h0: begin
                          IR=OPCODE; // FETCH
                          state=state+1;
                          end
                    4'h1: begin
                          case(IR)   //DECODE PH1
                          8'h00: begin
                                 seldst=4'h1; 
                                 selsrc=4'h1; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; //NOP
                                 end
                          8'h01: begin
                                 seldst=4'h1; 
                                 selsrc=4'h3; 
                                 aluopsel=4'h0;   // Load Value
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; // PC
                                 end 
                          8'h02: begin
                                 seldst=4'h2; 
                                 selsrc=4'h3;  
                                 aluopsel=4'h0; // LOAD Value
                                 pcopsel=2'h0;
                                 wr_en=1'h0; 
                                 end 
                          8'h03: begin
                                 seldst=4'h5; 
                                 selsrc=4'h1; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; // OUTA
                                 end  
                          8'h04: begin
                                 seldst=4'h5; 
                                 selsrc=4'h2; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; //OUTB
                                 end 
                          8'h06: begin
                                 seldst=4'h1; 
                                 selsrc=4'h1; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; // NOP
                                 end
                          8'h07: begin
                                 seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h1; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; // ADDAB
                                 end
                           8'h08: begin
                                 seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h2; 
                                 pcopsel=2'h0; 
                                 wr_en=1'h0; // SUBAB
                                 end
                            8'h09: begin //ANDAB
                                 seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h4; 
                                 pcopsel=2'h0;
                                 wr_en=1'h0;  
                                 end 
                          8'h0a: // ORLAB
                          begin
                                seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h5; 
                                 pcopsel=2'h0;
                                 wr_en=1'h0;  
                                 end
                          8'h0b: // NOTA
                          begin
                                seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h3; 
                                 pcopsel=2'h0;
                                 wr_en=1'h0;  
                                 end
                          8'h0c: // XORAB
                            begin
                                 seldst=4'h1; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h6; 
                                 pcopsel=2'h0;
                                 wr_en=1'h0;  
                                 end
                          8'h0d: begin  // RAM Write
                                 seldst=4'h7;   // Sends to datapath's MemOut then to RAM's data_in
                                 selsrc=4'h4;   // Value is from testbench (PortIN)
                                 aluopsel=4'h0;
                                 pcopsel=2'h0;
                                 wr_en=1'h1; 
                                 end
                          8'h0e: begin  // RAM Read
                                 seldst=4'h1;   // TODO 3: Modify this; RAM read's destination register
                                 selsrc=4'h6;   // Obtains value from MBR connected to RAM'S data_out
                                 aluopsel=4'h0;
                                 pcopsel=2'h0;
                                 wr_en=1'h0;
                                 end
                          endcase
                            state=state+8'h01;
                          end
                     4'h2: begin
                            state=state+8'h01;
                           end
                     4'h3: begin
                          case(IR) // EXECUTE PH2
                          8'h00: begin
                                 seldst=4'h1; 
                                 selsrc=4'h1; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; //NOP
                                end
                          8'h01: begin
                                 seldst=4'h1; 
                                 selsrc=4'h3; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; // A<-INR
                                 end
                          8'h02: begin
                                 seldst=4'h2; 
                                 selsrc=4'h3; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; // B<-INR
                                 end
                          8'h03: begin
                                 seldst=4'h4; 
                                 selsrc=4'h1; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; // OUTA
                                 end  
                          8'h04: begin
                                 seldst=4'h4; 
                                 selsrc=4'h2; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; //OUTB
                                 end 
                          8'h06: begin
                                 seldst=4'h5; 
                                 selsrc=4'h5; 
                                 aluopsel=4'h0; 
                                 pcopsel=2'h0; // MAR<-MBR
                                 end
                          8'h07: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  // previously 1
                                 pcopsel=2'h0; // ADDAB
                                 end
                          8'h08: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  
                                 pcopsel=2'h0; // SUBAB
                                 end
                          8'h09: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  
                                 pcopsel=2'h0; // ANDAB
                                 end
                          8'h0a: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  
                                 pcopsel=2'h0; // ORLAB
                                 end
                          8'h0b: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  
                                 pcopsel=2'h0; // NOTA
                                 end
                          8'h0c: begin
                                 seldst=4'h1;
                                 selsrc=4'h5; 
                                 aluopsel=4'h0;  
                                 pcopsel=2'h0; // XORAB
                                 end                           
                          endcase
                          state=state+8'h01;
                          end     
                     4'h4: if(IR==8'h06) begin
                                             pcopsel=2'h0;
                                             state=state+8'h01;
                                          end
                            else
                                  begin
                                       pcopsel=2'h1;
                                       state=state+8'h01;
                                   end
                     4'h5: begin
                            if(IR==8'h06) begin 
                                         state=state+1;
                                         end// PC<-MAR
                            else
                                begin                         
                                    pcopsel=2'h0;
                                    state=8'h0;
                                end
                            end
                     4'h6:  if(IR==8'h06) begin
                                            pcopsel=2'h0; 
                                            state=state+1;
                                          end
                            else  
                                           begin
                                             pcopsel=2'h1; 
                                             state=4'h0;
                                           end
                     4'h7:  begin
                             pcopsel=2'h2; 
                             state=4'h8;
                            end
                     4'h8:  begin
                              pcopsel=2'h0; 
                              state=8'h9;
                            end
                     4'h9:  begin
                            //   IR=OPCODE;
                               pcopsel=2'h0; 
                               state=8'h0;
                             end
                     default: begin
                              seldst=4'h1;
                              selsrc=4'h1; 
                              aluopsel=4'h0; 
                              pcopsel=2'h0;
                              end
                     endcase
                 end
             end
             
end

endmodule
