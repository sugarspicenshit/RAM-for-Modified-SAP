`timescale 1ns / 1ps


module regbasic (
    output reg [7:0] Q,
    input wire [7:0] D,
    input wire rst,
    input wire clk
);
                
always @(posedge clk)
begin 
    if (!rst) begin 
        Q<=8'h00; 
    end else
    begin 
        Q<=D; 
    end
end

endmodule
         