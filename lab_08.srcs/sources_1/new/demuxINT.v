`timescale 1ns / 1ps


module demux (
    output reg [7:0] A,
    output reg [7:0] B,
    output reg [7:0] C,
    output reg [7:0] Mem,
    output reg [7:0] outbuf_1,
    output reg [7:0] outbuf_2,
    output reg [7:0] outbuf_3,
    output reg [7:0] pcjmp,
    output reg [7:0] MAR,
    input wire [3:0] sel,
    input wire [7:0] busin
);


always @* begin 
    case (sel)
        4'h1: A=busin;
        4'h2: B=busin;
        4'h3: C=busin;
        4'h4: pcjmp=busin;
        4'h5: outbuf_1=busin;
        4'h6: outbuf_2=busin;
        4'h7: outbuf_3=busin;
        4'h8: MAR=busin; // old value = 6
        4'h9: Mem=busin; // old value = 7
        default: outbuf_1=busin;
    endcase
end

endmodule