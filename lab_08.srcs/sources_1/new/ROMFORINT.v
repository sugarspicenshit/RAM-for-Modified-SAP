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


module ROMBasic(
    input wire [7:0] ADDR,
    output reg [15:0] DATA,
    input wire clk,
    input wire rst
);
    
always@(posedge clk)
begin
if(!rst) DATA=8'h00;
      
if(rst)
      begin
      case(ADDR)
      8'd0:  DATA=16'h0d00; // SW 
      8'd1:  DATA=16'h0e00; // LW.A 
      
//      8'd2:  DATA=16'h09; // OUTR <- ACC     a-and,b
//      8'd3:  DATA=16'h03; // OUTR <-BREG     a->out
//      8'd4:  DATA=16'h10; // ACC <- ADD AB   a-OR b
//      8'd5:  DATA=16'h03; // OUTR <- ACC     a->out
//      8'd6:  DATA=16'h11; // JMP 00          a npt
//      8'd7:  DATA=16'h03;                    // a->OUT
//      8'd8:  DATA=16'h06;
      8'd9:  DATA=16'h00;
      8'd10:  DATA=16'h00;
      8'd11:  DATA=16'h00;
      8'd12:  DATA=8'h00;
      8'd13:  DATA=8'h00;
      8'd14:  DATA=8'h00;
      8'd15:  DATA=8'h00;
      8'd16:  DATA=8'h00;
      8'd17:  DATA=8'h00;
      8'd18:  DATA=8'h00;
      8'd19:  DATA=8'h00;
      8'd20:  DATA=8'h00;
      8'd21:  DATA=8'h03;
      8'd22:  DATA=8'h04;
      8'd23:  DATA=8'h07;
      8'd24:  DATA=8'h0F;
      8'd25:  DATA=8'h00;
      8'd26:  DATA=8'h00;
      8'd27:  DATA=8'h00;
      8'd28:  DATA=8'h00;
      8'd29:  DATA=8'h00;
      8'd30:  DATA=8'h00;
      8'd31:  DATA=8'h00;
      8'd32:  DATA=8'h00;
      8'd33:  DATA=8'h07; // ADD AB
      8'd34:  DATA=8'h07; // ADD AB
      8'd35:  DATA=8'h06; // JMP 00
      8'd36:  DATA=8'h00;
      8'd37:  DATA=8'h00;
      8'd38:  DATA=8'h00;
      8'd39:  DATA=8'h00;
      8'd40:  DATA=8'h00;
      8'd41:  DATA=8'h00;
      8'd42:  DATA=8'h00;
      8'd43:  DATA=8'h00;
      8'd44:  DATA=8'h00;
      8'd45:  DATA=8'h00;
      8'd46:  DATA=8'h00;
      8'd47:  DATA=8'h00;
      8'd48:  DATA=8'h00;
      8'd49:  DATA=8'h00;
      8'd50:  DATA=8'h00;
      8'd51:  DATA=8'h00;
      8'd52:  DATA=8'h00;
      8'd53:  DATA=8'h00;
      8'd54:  DATA=8'h00;
      8'd55:  DATA=8'h00;
      8'd56:  DATA=8'h00;
      8'd57:  DATA=8'h00;
      8'd58:  DATA=8'h00;
      8'd59:  DATA=8'h00;
      8'd60:  DATA=8'h00;
      8'd61:  DATA=8'h00;
      8'd62:  DATA=8'h00;
      8'd63:  DATA=8'h00;
      8'd64:  DATA=8'h00;
      8'd65:  DATA=8'h00;
      8'd66:  DATA=8'h00;
      8'd67:  DATA=8'h00;
      8'd68:  DATA=8'h00;
      8'd69:  DATA=8'h00;
      8'd70:  DATA=8'h00;
      8'd71:  DATA=8'h00;
      8'd72:  DATA=8'h00;
      8'd73:  DATA=8'h00;
      8'd74:  DATA=8'h00;
      8'd75:  DATA=8'h00;
      8'd76:  DATA=8'h00;
      8'd77:  DATA=8'h00;
      8'd78:  DATA=8'h00;
      8'd79:  DATA=8'h00;
      8'd80:  DATA=8'h00;
      8'd81:  DATA=8'h00;
      8'd82:  DATA=8'h00;
      8'd83:  DATA=8'h00;
      8'd84:  DATA=8'h00;
      8'd85:  DATA=8'h00;
      8'd86:  DATA=8'h00;
      8'd87:  DATA=8'h00;
      8'd88:  DATA=8'h00;
      8'd89:  DATA=8'h00;
      8'd90:  DATA=8'h00;
      8'd91:  DATA=8'h00;
      8'd92:  DATA=8'h00;
      8'd93:  DATA=8'h00;
      8'd94:  DATA=8'h00;
      8'd95:  DATA=8'h00;
      8'd96:  DATA=8'h00;
      8'd97:  DATA=8'h00;
      8'd98:  DATA=8'h00;
      8'd99:  DATA=8'h00;
      8'd100:  DATA=8'h00;
      8'd101:  DATA=8'h00;
      8'd102:  DATA=8'h00;
      8'd103:  DATA=8'h00;
      8'd104:  DATA=8'h00;
      8'd105:  DATA=8'h00;
      8'd106:  DATA=8'h00;
      8'd107:  DATA=8'h00;
      8'd108:  DATA=8'h00;
      8'd109:  DATA=8'h00;
      8'd110:  DATA=8'h00;
      8'd111:  DATA=8'h00;
      8'd112:  DATA=8'h00;
      8'd113:  DATA=8'h00;
      8'd114:  DATA=8'h00;
      8'd115:  DATA=8'h00;
      8'd116:  DATA=8'h00;
      8'd117:  DATA=8'h00;
      8'd118:  DATA=8'h00;
      8'd119:  DATA=8'h00;
      8'd120:  DATA=8'h00;
      8'd121:  DATA=8'h00;
      8'd122:  DATA=8'h00;
      8'd123:  DATA=8'h00;
      8'd124:  DATA=8'h00;
      8'd125:  DATA=8'h00;
      8'd126:  DATA=8'h00;
      8'd127:  DATA=8'h00;
      8'd128:  DATA=8'h00;
      8'd129:  DATA=8'h00;
      8'd130:  DATA=8'h00;
      8'd131:  DATA=8'h00;
      8'd132:  DATA=8'h00;
      8'd133:  DATA=8'h00;
      8'd134:  DATA=8'h00;
      8'd135:  DATA=8'h00;
      8'd136:  DATA=8'h00;
      8'd137:  DATA=8'h00;
      8'd138:  DATA=8'h00;
      8'd139:  DATA=8'h00;
      8'd140:  DATA=8'h00;
      8'd141:  DATA=8'h00;
      8'd142:  DATA=8'h00;
      8'd143:  DATA=8'h00;
      8'd144:  DATA=8'h00;
      8'd145:  DATA=8'h00;
      8'd146:  DATA=8'h00;
      8'd147:  DATA=8'h00;
      8'd148:  DATA=8'h00;
      8'd149:  DATA=8'h00;
      8'd150:  DATA=8'h00;
      8'd151:  DATA=8'h00;
      8'd152:  DATA=8'h00;
      8'd153:  DATA=8'h00;
      8'd154:  DATA=8'h00;
      8'd155:  DATA=8'h00;
      8'd156:  DATA=8'h00;
      8'd157:  DATA=8'h00;
      8'd158:  DATA=8'h00;
      8'd159:  DATA=8'h00;
      8'd160:  DATA=8'h00;
      8'd161:  DATA=8'h00;
      8'd162:  DATA=8'h00;
      8'd163:  DATA=8'h00;
      8'd164:  DATA=8'h00;
      8'd165:  DATA=8'h00;
      8'd166:  DATA=8'h00;
      8'd167:  DATA=8'h00;
      8'd168:  DATA=8'h00;
      8'd169:  DATA=8'h00;
      8'd170:  DATA=8'h00;
      8'd171:  DATA=8'h00;
      8'd172:  DATA=8'h00;
      8'd173:  DATA=8'h00;
      8'd174:  DATA=8'h00;
      8'd175:  DATA=8'h00;
      8'd176:  DATA=8'h00;
      8'd177:  DATA=8'h00;
      8'd178:  DATA=8'h00;
      8'd179:  DATA=8'h00;
      8'd180:  DATA=8'h00;
      8'd181:  DATA=8'h00;
      8'd182:  DATA=8'h00;
      8'd183:  DATA=8'h00;
      8'd184:  DATA=8'h00;
      8'd185:  DATA=8'h00;
      8'd186:  DATA=8'h00;
      8'd187:  DATA=8'h00;
      8'd188:  DATA=8'h00;
      8'd189:  DATA=8'h00;
      8'd190:  DATA=8'h00;
      8'd191:  DATA=8'h00;
      8'd192:  DATA=8'h00;
      8'd193:  DATA=8'h00;
      8'd194:  DATA=8'h00;
      8'd195:  DATA=8'h00;
      8'd196:  DATA=8'h00;
      8'd197:  DATA=8'h00;
      8'd198:  DATA=8'h00;
      8'd199:  DATA=8'h00;
      8'd200:  DATA=8'h00;
      8'd201:  DATA=8'h00;
      8'd202:  DATA=8'h00;
      8'd203:  DATA=8'h00;
      8'd204:  DATA=8'h00;
      8'd205:  DATA=8'h00;
      8'd206:  DATA=8'h00;
      8'd207:  DATA=8'h00;
      8'd208:  DATA=8'h00;
      8'd209:  DATA=8'h00;
      8'd210:  DATA=8'h00;
      8'd211:  DATA=8'h00;
      8'd212:  DATA=8'h00;
      8'd213:  DATA=8'h00;
      8'd214:  DATA=8'h00;
      8'd215:  DATA=8'h00;
      8'd216:  DATA=8'h00;
      8'd217:  DATA=8'h00;
      8'd218:  DATA=8'h00;
      8'd219:  DATA=8'h00;
      8'd220:  DATA=8'h00;
      8'd221:  DATA=8'h00;
      8'd222:  DATA=8'h00;
      8'd223:  DATA=8'h00;
      8'd224:  DATA=8'h00;
      8'd225:  DATA=8'h00;
      8'd226:  DATA=8'h00;
      8'd227:  DATA=8'h00;
      8'd228:  DATA=8'h00;
      8'd229:  DATA=8'h00;
      8'd230:  DATA=8'h00;
      8'd231:  DATA=8'h00;
      8'd232:  DATA=8'h00;
      8'd233:  DATA=8'h00;
      8'd234:  DATA=8'h00;
      8'd235:  DATA=8'h00;
      8'd236:  DATA=8'h00;
      8'd237:  DATA=8'h00;
      8'd238:  DATA=8'h00;
      8'd239:  DATA=8'h00;
      8'd240:  DATA=8'h00;
      8'd241:  DATA=8'h00;
      8'd242:  DATA=8'h00;
      8'd243:  DATA=8'h00;
      8'd244:  DATA=8'h00;
      8'd245:  DATA=8'h00;
      8'd246:  DATA=8'h00;
      8'd247:  DATA=8'h00;
      8'd248:  DATA=8'h00;
      8'd249:  DATA=8'h00;
      8'd250:  DATA=8'h00;
      8'd251:  DATA=8'h00;
      8'd252:  DATA=8'h00;
      8'd253:  DATA=8'h00;
      8'd254:  DATA=8'h00;
      endcase
      end
      
      end

endmodule

