`timescale 1ns / 1ps


module d4breg ( 
    input wire [7:0] INna,
    input wire clk,
    output reg [7:0] Outna,
    input wire CE
);

always @(posedge clk)
begin
    if (!CE) 
    begin 
        Outna=Outna;
    end
    if (CE)
    begin
        Outna=INna;
    end
end

endmodule