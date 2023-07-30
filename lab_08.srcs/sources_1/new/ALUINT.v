`timescale 1ns / 1ps


module ALU(
    input wire [7:0] ACC,
    input wire [7:0] BREG,
    input wire [7:0] Cval,
    input wire [3:0] OP,
    output reg [7:0] ALUOUT,
    output reg [7:0] ALUSHOW,
    output reg zf
);
    
always @(ACC or BREG or Cval or OP)
begin
    case(OP)
        4'h0:  ALUOUT=ALUOUT; 
        4'h1:  ALUOUT=ACC+BREG; // ADDAB
        4'h2:  ALUOUT=ACC-BREG; // SUBAB
        4'h3:  ALUOUT=~ACC;     // NOT A
        4'h4:  ALUOUT=ACC&BREG; // ANDAB
        4'h5:  ALUOUT=ACC|BREG; // ORLAB
        4'h6:  ALUOUT=ACC^BREG; // XORAB
        4'h7:  begin            // EQAB
                   ALUOUT=ACC-BREG;
                   zf=(ALUOUT==0);     
               end
        default: ALUOUT=ALUOUT;
    endcase
    
    if (OP!=4'h7)
        zf=0;
        
    ALUSHOW=ALUOUT;
end
    
endmodule