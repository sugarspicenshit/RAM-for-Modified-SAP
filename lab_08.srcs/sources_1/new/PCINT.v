`timescale 1ns / 1ps


module PC (
    input [7:0] PCIN,       // Input Register
    input clk,              // Clock
    input [2:0] pcopsel,    // Selector Control Line
    input rst,              // Reset pin
    output reg [7:0] PCOUT, // Output Port
    output reg [7:0] STACK
);

//reg [7:0] STACK;  
    
always @(posedge clk)
begin
    if (!rst) begin
        PCOUT=8'h00; // resets  counter position
        STACK=8'h00;
    end
    if (rst) 
    begin
        case (pcopsel) 
            3'h0:   PCOUT=PCOUT; // refresh
            3'h1:   begin 
                        PCOUT=PCOUT+1'b1; 
                        STACK = STACK; 
                    end // increment
            3'h2:   PCOUT=PCIN; // load new value for PC
            3'h3:   STACK=PCOUT; // refresh
            3'h4:   begin 
                        PCOUT=STACK; 
                        STACK=STACK; 
                    end
            default: PCOUT=PCOUT;
        endcase
    end
end

endmodule