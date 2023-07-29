`timescale 1ns / 1ps


module sourcemux (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [7:0] C,
    input wire [7:0] INna,
    input wire [7:0] ALUOUT,
    input wire [7:0] MBR,
    input wire [7:0] PC,
    input wire [3:0] sel,
    input wire clk,
    output reg [7:0] busout
);


always @(sel) begin 
    case (sel)
        4'h1: busout=A;
        4'h2: busout=B;
        4'h3: busout=C;
        4'h4: busout=INna;
        4'h5: busout=ALUOUT;
        4'h6: busout=MBR;
        4'h7: busout=PC;
        default: busout=A;
    endcase
end

endmodule