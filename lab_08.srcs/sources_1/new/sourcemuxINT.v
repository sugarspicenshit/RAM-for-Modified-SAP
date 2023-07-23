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
    output reg [7:0] outna,
    input wire srcoe
);


always @(posedge clk)
begin 
    if (srcoe) 
    begin
        case (sel)
            4'h1: outna=A;
            4'h2: outna=B;
            4'h3: outna=C;
            4'h4: outna=INna;
            4'h5: outna=ALUOUT;
            4'h6: outna=MBR;
            4'h7: outna=PC;
            default: outna=A;
        endcase
    end
end

endmodule