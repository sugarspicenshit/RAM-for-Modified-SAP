`timescale 1ns / 1ps


module demux (
    output reg [7:0] A,
    output reg [7:0] B,
    output reg [7:0] C,
    output reg [7:0] Mem,
    output reg [7:0] outbuf,
    output reg [7:0] pcjmp,
    output reg [7:0] MAR,
    input wire [3:0] sel,
    input wire clk,
    input wire [7:0] busfin,
    input wire busin
);


always @(posedge clk)
begin 
    if (busin) 
    begin
        case (sel)
            4'h1: A=busfin;
            4'h2: B=busfin;
            4'h3: C=busfin;
            4'h4: pcjmp=busfin;
            4'h5: outbuf=busfin;
            4'h6: MAR=busfin;
            4'h7: Mem=busfin;
            default: outbuf=busfin;
        endcase
    end
end

endmodule