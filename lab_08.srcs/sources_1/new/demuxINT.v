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
    input wire [7:0] busin
);


always @(sel) begin 
    case (sel)
        4'h1: A=busin;
        4'h2: B=busin;
        4'h3: C=busin;
        4'h4: pcjmp=busin;
        4'h5: outbuf=busin;
        4'h6: MAR=busin;
        4'h7: Mem=busin;
        default: outbuf=busin;
    endcase
end

endmodule