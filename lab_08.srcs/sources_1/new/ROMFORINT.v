`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  DLSU
// Engineer:  Voltaire Dupo
// 
// Create Date: 25.04.2022 11:35:52
// Design Name:  MARIE Implementation
// Module Name: ROMBasic
// Project Name: SAP
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: For Educational Use only use at your own risk for commercial purposes
// 
//////////////////////////////////////////////////////////////////////////////////


module ROMBasic (
    input wire [7:0] ADDR,
    output reg [15:0] DATA
);
    
always @(ADDR)
begin
      case(ADDR)
      // Initialize values
      8'd0:    DATA=16'h150C;   // LW.Bi 00            ; hours = 0
      8'd1:    DATA=16'h0F00;   // SW.B $00  
      8'd2:    DATA=16'h1500;   // LW.Bi 00            ; minutes = 0
      8'd3:    DATA=16'h0F01;   // SW.B $01
      8'd4:    DATA=16'h1500;   // LW.Bi 00            ; seconds = 0
      8'd5:    DATA=16'h0F02;   // SW.B $02   
      8'd6:    DATA=16'h1500;   // LW.Bi 00            ; timezone = 0 (PH)
      // Loop begin
      8'd7:    DATA=16'h0F03;   // SW.B $03         
      8'd8:    DATA=16'h1102;   // LW.A $02            ; seconds = seconds + 1
      8'd9:    DATA=16'h1801;   // ADD.Ai 01  
      8'd10:   DATA=16'h0E02;   // SW.A $02
      8'd11:   DATA=16'h143C;   // LW.Ai 60            ; if (seconds == 60)
      8'd12:   DATA=16'h1202;   // LW.B $02 
      8'd13:   DATA=16'h171B;   // BEQ.AB function1
      8'd14:   DATA=16'h143C;   // LW.Ai 60            ; if (minutes == 60)
      8'd15:   DATA=16'h1201;   // LW.B $01
      8'd16:   DATA=16'h1721;   // BEQ.AB function2
      8'd17:   DATA=16'h1418;   // LW.Ai 24             ; if (hours == 24)
      8'd18:   DATA=16'h1200;   // LW.B $00
      8'd19:   DATA=16'h1727;   // BEQ.AB function3
      8'd20:   DATA=16'h1100;   // LW.A 00
      8'd21:   DATA=16'h0300;   // OUTA 00;output hours OUTR_1 <- A <- RAM[00]
      8'd22:   DATA=16'h1201;   // LW.B 01
      8'd23:   DATA=16'h0400;   // OUTB 00;output minutes OUTR_2 <- B <- RAM[01]
      8'd24:   DATA=16'h1302;   // LW.C 02
      8'd25:   DATA=16'h0500;   // OUTC 00 ;output seconds OUTR_3 <- C <- RAM[02]
      8'd26:   DATA=16'h1D08;   // JMP 08
      // Start of Function 1
      8'd27:   DATA=16'h1101;   //LW.A $01            ; minutes = minutes + 1
      8'd28:   DATA=16'h1801;   //ADD.Ai 01
      8'd29:   DATA=16'h0E01;   //SW.A $01
      8'd30:   DATA=16'h1400;   //LW.Ai 00            ; seconds = 0
      8'd31:   DATA=16'h0E02;   //SW.A $02 
      8'd32:   DATA=16'h1E00;   //RET
      // Start of Function 2
      8'd33:   DATA=16'h1100;   //LW.A $00            ; hours = hours + 1
      8'd34:   DATA=16'h1801;   //ADD.Ai 01
      8'd35:   DATA=16'h0E00;   //SW.A $00
      8'd36:   DATA=16'h1400;   //LW.Ai 00            ; minutes = 0
      8'd37:   DATA=16'h0E01;   //SW.A $01
      8'd38:   DATA=16'h1E00;   //RET
      // Start of Function 3
      8'd39:   DATA=16'h1400;   //LW.Ai 0             ; hours = 0
      8'd40:   DATA=16'h0E00;   //SW.A $00
      8'd41:   DATA=16'h1E00;   //RET
      8'd42:   DATA=16'h0000;   //
      8'd43:   DATA=16'h0000;   //
      // INTERRUPT VECTORS
      // ISR changeToPH
      8'd44:   DATA=16'h0E04;   //SW.A 04
      8'd45:   DATA=16'h0F05;   //SW.B 05
      8'd46:   DATA=16'h1006;   //SW.C 06
      8'd47:   DATA=16'h1103;   //LW.A 03
      8'd48:   DATA=16'h1501;   //LW.Bi 1
      8'd49:   DATA=16'h1770;   //BEQ.AB function 4
      8'd50:   DATA=16'h1502;   //LW.Bi 2
      8'd51:   DATA=16'h1775;   //BEQ.AB function 5
      8'd52:   DATA=16'h1503;   //LW.Bi 3
      8'd53:   DATA=16'h177A;   //BEQ.AB function 6
      8'd54:   DATA=16'h1100;   //LW.Ai 0
      8'd55:   DATA=16'h0E03;   //SW.A 03
      8'd56:   DATA=16'h1104;   //LW.A 04
      8'd57:   DATA=16'h1205;   //LW.B 05
      8'd58:   DATA=16'h1306;   //LW.C 06
      8'd59:   DATA=16'h1F00;   //RET.i
      8'd60:   DATA=16'h0000;   //
      // ISR changeToUS
      8'd61:   DATA=16'h1771;   //SW.A 04
      8'd62:   DATA=16'h1101;   //SW.B 05
      8'd63:   DATA=16'h0E03;   //SW.C 06
      8'd64:   DATA=16'h1103;   //LW.A 03
      8'd65:   DATA=16'h1500;   //LW.Bi 0
      8'd66:   DATA=16'h177F;   //BEQ.AB function 7
      8'd67:   DATA=16'h1502;   //LW.Bi 2
      8'd68:   DATA=16'h1784;   //BEQ.AB function 8
      8'd69:   DATA=16'h1503;   //LW.Bi 3
      8'd70:   DATA=16'h1789;   //BEQ.AB function 9
      8'd71:   DATA=16'h1101;   //LW.Ai 1
      8'd72:   DATA=16'h0E03;   //SW.A 03
      8'd73:   DATA=16'h1104;   //LW.A 04
      8'd74:   DATA=16'h1205;   //LW.B 05
      8'd75:   DATA=16'h1306;   //LW.C 06
      8'd76:   DATA=16'h1F00;   //RET.i
      8'd77:   DATA=16'h0000;   //
      // ISR changeToUK
      8'd78:   DATA=16'h1771;   //SW.A 04
      8'd79:   DATA=16'h1101;   //SW.B 05
      8'd80:   DATA=16'h0E03;   //SW.C 06
      8'd81:   DATA=16'h1103;   //LW.A 03
      8'd82:   DATA=16'h1500;   //LW.Bi 0
      8'd83:   DATA=16'h178E;   //BEQ.AB function 10
      8'd84:   DATA=16'h1501;   //LW.Bi 1
      8'd85:   DATA=16'h1793;   //BEQ.AB function 11
      8'd86:   DATA=16'h1503;   //LW.Bi 3
      8'd87:   DATA=16'h1798;   //BEQ.AB function 12
      8'd88:   DATA=16'h1102;   //LW.Ai 2
      8'd89:   DATA=16'h0E03;   //SW.A 03
      8'd90:   DATA=16'h1104;   //LW.A 04
      8'd91:   DATA=16'h1205;   //LW.B 05
      8'd92:   DATA=16'h1306;   //LW.C 06
      8'd93:   DATA=16'h1F00;   //RET.i
      8'd94:   DATA=16'h0000;   //
      // ISR changeToUAE
      8'd95:   DATA=16'h1771;   //SW.A 04
      8'd96:   DATA=16'h1101;   //SW.B 05
      8'd97:   DATA=16'h0E03;   //SW.C 06
      8'd98:   DATA=16'h1103;   //LW.A 03
      8'd99:   DATA=16'h1500;   //LW.Bi 0
      8'd100:   DATA=16'h179D;   //BEQ.AB function 13
      8'd101:   DATA=16'h1501;   //LW.Bi 1
      8'd102:   DATA=16'h17A2;   //BEQ.AB function 14
      8'd103:   DATA=16'h1502;   //LW.Bi 2
      8'd104:   DATA=16'h17A7;   //BEQ.AB function 15
      8'd105:   DATA=16'h1103;   //LW.Ai 3
      8'd106:   DATA=16'h0E03;   //SW.A 03
      8'd107:   DATA=16'h1104;   //LW.A 04
      8'd108:   DATA=16'h1205;   //LW.B 05
      8'd109:   DATA=16'h1306;   //LW.C 06
      8'd110:   DATA=16'h1F00;   //RET.i
      8'd111:   DATA=16'h0000;   //
      // Function4
      8'd112:   DATA=16'h1100;   //LW.A $00
      8'd113:   DATA=16'h180C;   //ADD.Ai 0C
      8'd114:   DATA=16'h0E00;   //SW.A $00
      8'd115:   DATA=16'h1E00;   //RET
      8'd116:   DATA=16'h0000;   //
      
      // Function5
      8'd117:   DATA=16'h1100;   //LW.A $00
      8'd118:   DATA=16'h1807;   //ADD.Ai 07
      8'd119:   DATA=16'h0E00;   //SW.A $00
      8'd120:   DATA=16'h1E00;   //RET
      8'd121:   DATA=16'h0000;   //
      
      // Function6
      8'd122:   DATA=16'h1100;   //LW.A $00
      8'd123:   DATA=16'h1804;   //ADD.Ai 04
      8'd124:  DATA=16'h0E00;   //SW.A $00
      8'd125:  DATA=16'h1E00;   //RET
      8'd126:  DATA=16'h0000;   //
      
      // Function7
      8'd127:  DATA=16'h1100;   //LW.A $00
      8'd128:  DATA=16'h190C;   //SUB.Ai 0C
      8'd129:  DATA=16'h0E00;   //SW.A $00
      8'd130:  DATA=16'h1E00;   //RET
      8'd131:  DATA=16'h0000;   //
      
      // Function8
      8'd132:  DATA=16'h1100;   //LW.A $00
      8'd133:  DATA=16'h1905;   //SUB.Ai 05
      8'd134:  DATA=16'h0E00;   //SW.A $00
      8'd135:  DATA=16'h1E00;   //RET
      8'd136:  DATA=16'h0000;   //
      
      // Function9
      8'd137:  DATA=16'h1100;   //LW.A $00
      8'd138:  DATA=16'h1908;   //SUB.Ai 08
      8'd139:  DATA=16'h0E00;   //SW.A $00
      8'd140:  DATA=16'h1E00;   //RET
      8'd141:  DATA=16'h0000;   //
      
      // Function10
      8'd142:  DATA=16'h1100;   //LW.A $00
      8'd143:  DATA=16'h1907;   //SUB.Ai 07
      8'd144:  DATA=16'h0E00;   //SW.A $00
      8'd145:  DATA=16'h1E00;   //RET
      8'd146:  DATA=16'h0000;   //
      
      // Function11
      8'd147:  DATA=16'h1100;   //LW.A $00
      8'd148:  DATA=16'h1805;   //ADD.Ai 05
      8'd149:  DATA=16'h0E00;   //SW.A $00
      8'd150:  DATA=16'h1E00;   //RET
      8'd151:  DATA=16'h0000;   //
      
      // Function12
      8'd152:  DATA=16'h1100;   //LW.A $00
      8'd153:  DATA=16'h1903;   //SUB.Ai 03
      8'd154:  DATA=16'h0E00;   //SW.A $00
      8'd155:  DATA=16'h1E00;   //RET
      8'd156:  DATA=16'h0000;   //
      
      // Function13
      8'd157:  DATA=16'h1100;   //LW.A $00
      8'd158:  DATA=16'h1904;   //SUB.Ai 04
      8'd159:  DATA=16'h0E00;   //SW.A $00
      8'd160:  DATA=16'h1E00;   //RET
      8'd161:  DATA=16'h0000;   //
      // Function 14
      8'd162:  DATA=16'h1100;   //LW.A $00
      8'd163:  DATA=16'h1808;   //ADD.Ai 08
      8'd164:  DATA=16'h0E00;   //SW.A $00
      8'd165:  DATA=16'h1E00;   //RET
      8'd166:  DATA=16'h0000;   //
      // Function 15
      8'd167:  DATA=16'h1100;   //LW.A $00
      8'd168:  DATA=16'h1803;   //ADD.Ai 03
      8'd169:  DATA=16'h0E00;   //SW.A $00
      8'd170:  DATA=16'h1E00;   //RET
      8'd171:  DATA=16'h0000;   //
      8'd172:  DATA=16'h0000;
      8'd173:  DATA=16'h0000;
      8'd174:  DATA=16'h0000;
      8'd175:  DATA=16'h0000;
      8'd176:  DATA=16'h0000;
      8'd177:  DATA=16'h0000;
      8'd178:  DATA=16'h0000;
      8'd179:  DATA=16'h0000;
      8'd180:  DATA=16'h0000;
      8'd181:  DATA=16'h0000;
      8'd182:  DATA=16'h0000;
      8'd183:  DATA=16'h0000;
      8'd184:  DATA=16'h0000;
      8'd185:  DATA=16'h0000;
      8'd186:  DATA=16'h0000;
      8'd187:  DATA=16'h0000;
      8'd188:  DATA=16'h0000;
      8'd189:  DATA=16'h0000;
      8'd190:  DATA=16'h0000;
      8'd191:  DATA=16'h0000;
      8'd192:  DATA=16'h0000;
      8'd193:  DATA=16'h0000;
      8'd194:  DATA=16'h0000;
      8'd195:  DATA=16'h0000;
      8'd196:  DATA=16'h0000;
      8'd197:  DATA=16'h0000;
      8'd198:  DATA=16'h0000;
      8'd199:  DATA=16'h0000;
      8'd200:  DATA=16'h0000;
      8'd201:  DATA=16'h0000;
      8'd202:  DATA=16'h0000;
      8'd203:  DATA=16'h0000;
      8'd204:  DATA=16'h0000;
      8'd205:  DATA=16'h0000;
      8'd206:  DATA=16'h0000;
      8'd207:  DATA=16'h0000;
      8'd208:  DATA=16'h0000;
      8'd209:  DATA=16'h0000;
      8'd210:  DATA=16'h0000;
      8'd211:  DATA=16'h0000;
      8'd212:  DATA=16'h0000;
      8'd213:  DATA=16'h0000;
      8'd214:  DATA=16'h0000;
      8'd215:  DATA=16'h0000;
      8'd216:  DATA=16'h0000;
      8'd217:  DATA=16'h0000;
      8'd218:  DATA=16'h0000;
      8'd219:  DATA=16'h0000;
      8'd220:  DATA=16'h0000;
      8'd221:  DATA=16'h0000;
      8'd222:  DATA=16'h0000;
      8'd223:  DATA=16'h0000;
      8'd224:  DATA=16'h0000;
      8'd225:  DATA=16'h0000;
      8'd226:  DATA=16'h0000;
      8'd227:  DATA=16'h0000;
      8'd228:  DATA=16'h0000;
      8'd229:  DATA=16'h0000;
      8'd230:  DATA=16'h0000;
      8'd231:  DATA=16'h0000;
      8'd232:  DATA=16'h0000;
      8'd233:  DATA=16'h0000;
      8'd234:  DATA=16'h0000;
      8'd235:  DATA=16'h0000;
      8'd236:  DATA=16'h0000;
      8'd237:  DATA=16'h0000;
      8'd238:  DATA=16'h0000;
      8'd239:  DATA=16'h0000;
      8'd240:  DATA=16'h0000;
      8'd241:  DATA=16'h0000;
      8'd242:  DATA=16'h0000;
      8'd243:  DATA=16'h0000;
      8'd244:  DATA=16'h0000;
      8'd245:  DATA=16'h0000;
      8'd246:  DATA=16'h0000;
      8'd247:  DATA=16'h0000;
      8'd248:  DATA=16'h0000;
      8'd249:  DATA=16'h0000;
      8'd250:  DATA=16'h0000;
      8'd251:  DATA=16'h0000;
      8'd252:  DATA=16'h0000;
      8'd253:  DATA=16'h0000;
      8'd254:  DATA=16'h0000;
      endcase
end

endmodule

