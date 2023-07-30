`timescale 1ns / 1ps


module ALU(
    input wire [7:0] ACC,
    input wire [7:0] BREG,
    input wire [7:0] Cval,
    input wire [7:0] LIT,
    input wire [3:0] OP,
    output reg [7:0] ALUOUT,
    output reg [7:0] ALUSHOW,
    output reg zf
);
    
always @(ACC or BREG or Cval or OP)
begin
    case(OP)
        // No operation
        4'h0:  ALUOUT=ALUOUT;
        // Operations involving ACC and B 
        4'h1:  ALUOUT=ACC+BREG; // ADDAB
        4'h2:  ALUOUT=ACC-BREG; // SUBAB
        4'h3:  ALUOUT=~ACC;     // NOT A
        4'h4:  ALUOUT=ACC&BREG; // ANDAB
        4'h5:  ALUOUT=ACC|BREG; // ORLAB
        4'h6:  ALUOUT=ACC^BREG; // XORAB
        // Branching operations
        4'h7:  begin            // EQAB
                   ALUOUT=ACC-BREG;
                   zf=(ALUOUT==0);     
                end
        // Operations involving ACC and immediate value
        4'h8:  ALUOUT=ACC+LIT; // ADDAi 
        4'h9:  ALUOUT=ACC-LIT; // SUBAi
        4'ha:  ALUOUT=ACC&LIT; // ANDAi
        4'hb:  ALUOUT=ACC|LIT; // ORAi
        4'hc:  ALUOUT=ACC^LIT; // XORAi
        // Default case: no operation
        default: ALUOUT=ALUOUT;
    endcase
    
    if (OP!=4'h7)
        zf=0;
        
    ALUSHOW=ALUOUT;
end
    
endmodule