`timescale 1ns / 1ps


module basicmux(
    input [7:0] ACCTRIB,
    input [7:0] ALUIN,
    input ALUPSEL,
    output reg [7:0] ACCAGP
);
    
always @*
begin 
    if (!ALUPSEL) ACCAGP=ALUIN;
    if (ALUPSEL) ACCAGP=ACCTRIB;
end
    
endmodule