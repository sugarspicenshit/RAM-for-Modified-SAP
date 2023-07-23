`timescale 1ns / 1ps


module basicmux(
    input [7:0] ACCTRIB,
    input [7:0] ALUIN,
    input ALUPSEL,
    input clk,
    output reg [7:0] ACCAGP
);
    
always @(posedge clk)
begin 
    if (!ALUPSEL) ACCAGP=ALUIN;
    if (ALUPSEL) ACCAGP=ACCTRIB;
end
    
endmodule