`timescale 1ns / 1ps


module IRDECODER(
    input wire INT,
    input wire [7:0] OPCODE,
    output reg [7:0] IRJUMP,
    output reg IRREF,
    output reg SELJUMP,
    output reg [3:0] aluopsel,
    output reg [2:0] pcopsel,
    output reg [3:0] seldst,
    output reg [3:0] selsrc,
    output reg [3:0] state,
    output reg [7:0] IR,
    output reg dstoe,
    output reg srcoe,
    input wire clk,
    input wire rst,
    output reg wr_en,
    input wire zf
);

reg statex;
reg prima;

//initial
//begin
//    prima=1'b0;
//    state=4'h0;
//    IR=8'h0;
//    dstoe=1'b1;
//    srcoe=1'b1;
//    seldst=4'h0; 
//    selsrc=4'h0; 
//    aluopsel=4'h0;      
//    pcopsel=3'h0;
//    IRREF=1'b0;     // Stack Refresh
//    SELJUMP=1'b0;   // MAR Selected
//    IRJUMP=8'd33;   // Jump vector For Interrupt
//    statex=1'b0;    
//end

    
always@(posedge clk)
begin
    if(!rst) begin
        state=4'h0;
        prima=1'b0;
        IR=8'h0;
        dstoe=1'b1;
        srcoe=1'b1;
        seldst=4'h0; 
        selsrc=4'h0; 
        aluopsel=4'h0; 
        pcopsel=3'h0;
        statex=1'b0;
        IRREF=1'b0;     // Stack Refresh
        SELJUMP=1'b0;   // MAR Selected
        IRJUMP=8'd33;   // Jump vector For Interrupt
        wr_en=1'b0;
    end 
    
    if(rst) 
    begin
        // Interrupt routine
        begin 
            // Prime the interrupt routine, but let the current cycle (fetch,
            // decode, execute) finish before servicing the interrupt.
            if(INT==1'b1 & state!=4'h0) begin 
                prima=1'b1;
            end
            if(prima==1'b1 & state==4'h0) begin 
                prima=1'b0;     // reset prima value
                statex=1'b1;    // primes interrupt routine to start
            end
            
            // Program counter jumps to the interrupt vector then resumes normal
            // operation throughout the interrupt vector until the return instruction.
            if(statex) begin 
                case(state)
                    3'h0:   begin
                                IRJUMP=8'd33;   // Jump vector For Interrupt
                                IRREF=1'b1;     // Stack Obtain data
                                SELJUMP=1'b1;   // IRJMP Selected
                                state=state+1;
                            end
                    3'h1:   begin
                                IRREF=1'b0;     // Stack Refresh
                                SELJUMP=1'b1;   // IRJUMP Selected
                                pcopsel=3'h2;   // Load data from IRJMP to PC
                                state=state+1;
                            end
                    3'h2:   begin
                                SELJUMP=1'b0;   // IRJUMP Selected
                                pcopsel=3'h0;   // PC Refresh
                                state=4'h0;     // Reset State
                                statex=1'b0;    // Ends ISR Vector
                            end                       
                endcase
            end
        end
    
        // Begin fetch, decode, execute cycle
        if(!statex) begin
            dstoe=1'b1;
            srcoe=1'b1;
            
            // SAP FSM
            case(state)
                4'h0:   begin
                            // Buffer state to allow the OPCODE to reach from ROM
                            state=state+1;
                        end
                4'h1:   begin                               // FETCH 
                            IR=OPCODE;                      
                            state=state+1;
                        end
                4'h2:   begin                               // DECODE PH1 
                            case(IR)                        
                                8'h00:  begin               // NOP 
                                            seldst=4'h1;    
                                            selsrc=4'h1;    
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end
                                8'h01:  begin               // MOVAC 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h3;    // From C
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end 
                                8'h02:  begin               // MOVBC 
                                            seldst=4'h2;    // To B
                                            selsrc=4'h3;    // From C
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0;
                                            wr_en=1'h0; 
                                        end 
                                8'h03:  begin               // OUTA 
                                            seldst=4'h5;    // To OUTR
                                            selsrc=4'h1;    // From A
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end  
                                8'h04:  begin               // OUTB 
                                            seldst=4'h5;    // To OUTR
                                            selsrc=4'h2;    // From B
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end
                                8'h05:  begin               // OUTC 
                                            seldst=4'h5;    // To OUTR
                                            selsrc=4'h3;    // From C
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end                                
                                8'h06:  begin               // MAR <- MBR
                                            seldst=4'h1; 
                                            selsrc=4'h1; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end
                                8'h07:  begin               // ADDAB 
                                            seldst=4'h1;    // To A 
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h1;  // A + B
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end
                                8'h08:  begin               // SUBAB 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h2;  // A - B
                                            pcopsel=3'h0; 
                                            wr_en=1'h0; 
                                        end
                                8'h09:  begin               // ANDAB 
                                            seldst=4'h1;    // To A 
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h4;  // A & B
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end 
                                8'h0a:  begin               // ORLAB 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h5;  // A | B
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end
                                8'h0b:  begin               // NOTA 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h3;  // ~A
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end
                                8'h0c:  begin               // XORAB 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h6;  // A ^ B
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end
                                8'h0d:  begin               // SW.IN 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h4;    // From PortIN
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h1;     // Write enabled
                                end
                                8'h0e:  begin               // SW.A 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h1;    // From A
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h1;     // Write enabled
                                        end
                                8'h0f:  begin               // SW.B 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h2;    // From B
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h1;     // Write enabled
                                        end
                                8'h10:  begin               // SW.C 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h3;    // From C
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h1;     // Write enabled
                                        end
                                8'h11:  begin               // LW.A 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h6;    // From MBRA (RAM data_out)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h12:  begin               // LW.B 
                                            seldst=4'h2;    // To B
                                            selsrc=4'h6;    // From MBRA (RAM data_out)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h13:  begin               // LW.C 
                                            seldst=4'h3;    // To C
                                            selsrc=4'h6;    // From MBRA (RAM data_out)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h14:  begin               // LW.Ai (Load immediate to A)
                                            seldst=4'h1;    // To A
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h15:  begin               // LW.Bi (Load immediate to B)
                                            seldst=4'h2;    // To B
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h16:  begin               // LW.Ci (Load immediate to C)
                                            seldst=4'h3;    // To C
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h17:  begin               // BEQ.AB (branch if A equals B)
                                            seldst=4'h6;    // To MAR (to PC address input)
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0]) 
                                            aluopsel=4'h7;  // EQAB
                                            pcopsel=3'h0;
                                            wr_en=1'h0;         
                                        end
                                8'h18:  begin               // ADD.Ai (ACC <- ACC + immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h8;  // ADDAi
                                            pcopsel=3'h0;
                                        end
                                8'h19:  begin               // SUB.Ai (ACC <- ACC - immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h9;  // SUBAi
                                            pcopsel=3'h0;
                                        end
                                8'h1a:  begin               // AND.Ai (ACC <- ACC & immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'ha;  // ANDAi
                                            pcopsel=3'h0;
                                        end
                                8'h1b:  begin               // OR.Ai (ACC <- ACC | immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'hb;  // ORAi
                                            pcopsel=3'h0;
                                        end
                                8'h1c:  begin               // XOR.Ai (ACC <- ACC ^ immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'hc;  // XORAi 
                                            pcopsel=3'h0;
                                        end
                                8'h1d:  begin               // JMP (unconditional jump)
                                            seldst=4'h6;    // To MAR (to PC address input)
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h2;   // Jump to address
                                        end   
                                8'hff:  begin               // HLT
                                            seldst=4'h0;
                                            selsrc=4'h0;
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                            endcase
                            
                            // Proceed to default case if instruction is HLT
                            if (IR!=8'hff)                  
                                state=state+4'h1;
                            else
                                state=4'hf;
                        end
                4'h3:   begin 
                            state=state+4'h1;
                        end
                4'h4:   begin                               // EXECUTE PH2 
                            case(IR)                        
                                8'h00:  begin               // NOP 
                                            seldst=4'h1; 
                                            selsrc=4'h1; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end
                                8'h01:  begin               // MOVAC 
                                            seldst=4'h1; 
                                            selsrc=4'h3; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0;
                                            wr_en=1'h0;  
                                        end
                                8'h02:  begin               // MOVB 
                                            seldst=4'h2; 
                                            selsrc=4'h3; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0;
                                            wr_en=1'h0;   
                                        end
                                8'h03:  begin               // OUTA 
                                            seldst=4'h5; 
                                            selsrc=4'h1; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0;
                                            wr_en=1'h0; 
                                        end  
                                8'h04:  begin               // OUTB 
                                            seldst=4'h5; 
                                            selsrc=4'h2; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end
                                8'h05:  begin               // OUTC 
                                            seldst=4'h5; 
                                            selsrc=4'h3; 
                                            aluopsel=4'h0; 
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end  
                                8'h06:  begin               // MAR <- MBR
                                            seldst=4'h6;    // To MAR
                                            selsrc=4'h6;    // From MBR
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0;   
                                            wr_en=1'h0;
                                        end 
                                8'h07:  begin               // ADDAB 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  // previously 1
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end
                                8'h08:  begin               // SUBAB 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end
                                8'h09:  begin               // ANDAB 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0;
                                            wr_en=1'h0; 
                                        end
                                8'h0a:  begin               // ORLAB 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end
                                8'h0b:  begin               // NOTA 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end
                                8'h0c:  begin               // XORAB 
                                            seldst=4'h1;
                                            selsrc=4'h5; 
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0; 
                                            wr_en=1'h0;
                                        end                           
                                8'h0d:  begin               // SW.IN 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h4;    // From PortIN
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h0e:  begin               // SW.A 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h1;    // From A
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h0f:  begin               // SW.B 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h2;    // From B
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h10:  begin               // SW.C 
                                            seldst=4'h7;    // To MemOut (RAM data_in)
                                            selsrc=4'h3;    // From C
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h11:  begin               // LW.A 
                                            seldst=4'h1;    // To A
                                            selsrc=4'h1;    // From A (loop the data around A)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h12:  begin               // LW.B 
                                            seldst=4'h2;    // To B
                                            selsrc=4'h2;    // From B (loop the data around B)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h13:  begin               // LW.C 
                                            seldst=4'h3;    // To C
                                            selsrc=4'h3;    // From C (loop the data around C)
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;     // Write disabled
                                        end
                                8'h14:  begin               // LW.Ai (Load immediate to A)
                                            seldst=4'h1;    // To A
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h15:  begin               // LW.Bi (Load immediate to B)
                                            seldst=4'h2;    // To B
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h16:  begin               // LW.Ci (Load immediate to C)
                                            seldst=4'h3;    // To C
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                            wr_en=1'h0;
                                        end
                                8'h17:  begin               // BEQ.AB (branch if A equals B)
                                            seldst=4'h6;    // To MAR (to PC address input)
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0]) 
                                            aluopsel=4'h7;  // EQAB
                                            if (zf)
                                                pcopsel=3'h4;
                                            else
                                                pcopsel=3'h0;
                                            wr_en=1'h0;         
                                        end 
                                8'h18:  begin               // ADD.Ai (ACC <- ACC + immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h0;  
                                            pcopsel=3'h0;
                                        end
                                8'h19:  begin               // SUB.Ai (ACC <- ACC - immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                        end
                                8'h1a:  begin               // AND.Ai (ACC <- ACC & immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                        end
                                8'h1b:  begin               // OR.Ai (ACC <- ACC | immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                        end
                                8'h1c:  begin               // XOR.Ai (ACC <- ACC ^ immediate value)
                                            seldst=4'h1;    // To ACC
                                            selsrc=4'h5;    // From ALUOUT
                                            aluopsel=4'h0;
                                            pcopsel=3'h0;
                                        end
                                8'h1d:  begin               // JMP (unconditional jump)
                                            seldst=4'h6;    // To MAR (to PC address input)
                                            selsrc=4'h8;    // From LIT (ROMDATA[7:0])
                                            aluopsel=4'h0;
                                            pcopsel=3'h2;   // Jump to address
                                        end                                   
                            endcase

                            state=state+8'h01;
                        end     
                4'h5:   begin 
                            if(IR==8'h06) 
                            begin
                                pcopsel=3'h0;      
                                state=state+8'h01;
                            end
                            else
                            begin
                                // Increment PC and move to next state
                                if (!zf) 
                                    pcopsel=3'h1;
                                else
                                    pcopsel=3'h1;
                                    
                                state=state+8'h01;
                            end
                        end
                4'h6:   begin 
                            if(IR==8'h06) 
                            begin 
                                state=state+1;
                            end // PC<-MAR
                            else
                            begin                         
                                pcopsel=3'h0;
                                
                                // Proceed to fetch cycle
                                state=8'h00;
                            end
                        end
                4'h7:   begin 
                            if(IR==8'h06) 
                            begin
                                pcopsel=3'h0; 
                                state=state+1;
                            end
                            else  
                            begin
                                pcopsel=3'h1; 
                                state=4'h0;
                            end
                        end
                4'h8:   begin 
                            pcopsel=3'h2; 
                            state=4'h9;
                        end
                4'h9:   begin 
                            pcopsel=3'h0; 
                            state=8'ha;
                        end
                4'ha:   begin 
                            // IR=OPCODE;
                            pcopsel=3'h0; 
                            state=8'h0;
                        end
                default: 
                        begin
                            seldst=4'h1;
                            selsrc=4'h1; 
                            aluopsel=4'h0; 
                            pcopsel=3'h0;
                            wr_en=0;
                        end
            endcase
            
        end
    end
end

endmodule
