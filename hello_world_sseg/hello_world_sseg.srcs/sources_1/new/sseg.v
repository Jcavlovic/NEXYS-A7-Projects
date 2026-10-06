`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2026 02:23:52 PM
// Design Name: 
// Module Name: bcd_to_sseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SSEG(Sign,DP,G,F,E,D,C,B,A,Enable,CLK100MHZ,BCD);
    input Sign;
    input wire CLK100MHZ;
    input wire [39:0] BCD;
    output reg DP,G,F,E,D,C,B,A;
    output reg [7:0] Enable;

    reg [3:0] Location = 0;
    reg [4:0] Digit;
    reg [3:0] Special_Case;
    
    initial begin
        DP = 0;
        G = 0;
        F = 0;
        E = 0;
        D = 0;
        C = 0;
        B = 0;
        A = 0;
        Enable = 0;
        Location = 0;
        Digit = 5'b10111;
        Special_Case = 0;
    end

    wire Clk_Multi;
    CLK100MHZ_divider IN432476(CLK100MHZ, Clk_Multi);
    
    always@(*) begin
        if(Special_Case == 0) begin
            if(Digit == 5'b00000) {G,F,E,D,C,B,A} = 7'b1000000; // Make 0 with LEDs
            if(Digit == 5'b00001) {G,F,E,D,C,B,A} = 7'b1001111; // Make 1 with LEDs
            if(Digit == 5'b00010) {G,F,E,D,C,B,A} = 7'b0100100; // Make 2 with LEDs
            if(Digit == 5'b00011) {G,F,E,D,C,B,A} = 7'b0110000; // Make 3 with LEDs        
            if(Digit == 5'b00100) {G,F,E,D,C,B,A} = 7'b0011001; // Make 4 with LEDs
            if(Digit == 5'b00101) {G,F,E,D,C,B,A} = 7'b0010010; // Make 5 with LEDs
            if(Digit == 5'b00110) {G,F,E,D,C,B,A} = 7'b0000010; // Make 6 with LEDs
            if(Digit == 5'b00111) {G,F,E,D,C,B,A} = 7'b1111000; // Make 7 with LEDs        
            if(Digit == 5'b01000) {G,F,E,D,C,B,A} = 7'b0000000; // Make 8 with LEDs
            if(Digit == 5'b01001) {G,F,E,D,C,B,A} = 7'b0011000; // Make 9 with LEDs
            if(Digit == 5'b01010) {G,F,E,D,C,B,A} = 7'b0001000; // Make A with LEDs
            if(Digit == 5'b01011) {G,F,E,D,C,B,A} = 7'b0000011; // Make b with LEDs        
            if(Digit == 5'b01100) {G,F,E,D,C,B,A} = 7'b1000110; // Make C with LEDs
            if(Digit == 5'b01101) {G,F,E,D,C,B,A} = 7'b0100001; // Make d with LEDs
            if(Digit == 5'b01110) {G,F,E,D,C,B,A} = 7'b0000110; // Make E with LEDs
            if(Digit == 5'b01111) {G,F,E,D,C,B,A} = 7'b0001110; // Make F with LEDs 
            
            if(Digit == 5'b10000) {G,F,E,D,C,B,A} = 7'b1100011; // Make w with LEDs 
            if(Digit == 5'b10001) {G,F,E,D,C,B,A} = 7'b1110011; // Make w with LEDs 
            if(Digit == 5'b10010) {G,F,E,D,C,B,A} = 7'b0100011; // Make o with LEDs 
            if(Digit == 5'b10011) {G,F,E,D,C,B,A} = 7'b0101111; // Make r with LEDs 
            if(Digit == 5'b10100) {G,F,E,D,C,B,A} = 7'b0001001; // Make H with LEDs 
            if(Digit == 5'b10101) {G,F,E,D,C,B,A} = 7'b1000111; // Make L with LEDs 
            if(Digit == 5'b10110) {G,F,E,D,C,B,A} = 7'b1110111; // Make _ with LEDs
            if(Digit == 5'b10111) {G,F,E,D,C,B,A} = 7'b1111111; // Make   with LEDs
            
        end
        if(Special_Case == 1){G,F,E,D,C,B,A} = 7'b0111111; // Make - with LEDs 
    end
    
    always@(posedge Clk_Multi) begin
        Location <= Location + 1;
        case(Location) 
            0:  begin
                    Enable <= 8'b11111110;
                    {DP,Digit} <= {1'b1,BCD[4:0]};      
                    Special_Case <= 0;    
                end
            1:  begin
                    Enable <= 8'b11111101;
                    {DP,Digit} <= {1'b1,BCD[9:5]};
                    Special_Case <= 0;
                end 
            2:  begin
                    Enable <= 8'b11111011;
                    {DP,Digit} <= {1'b1,BCD[14:10]};
                    Special_Case <= 0;
                end
            3:  begin
                    Enable <= 8'b11110111;
                    {DP,Digit} <= {1'b1,BCD[19:15]};
                    Special_Case <= 0;
                end 
            4:  begin
                    Enable <= 8'b11101111;
                    {DP,Digit} <= {1'b1,BCD[24:20]};
                    Special_Case <= 0;    
                end
            5:  begin
                    Enable <= 8'b11011111;
                    {DP,Digit} <= {1'b1,BCD[29:25]};
                    Special_Case <= 0;  
                end 
            6:  begin
                    Enable <= 8'b10111111;
                    {DP,Digit} <= {1'b1,BCD[34:30]};
                    Special_Case <= 0;
                end
            7:  begin
                    Enable <= 8'b01111111;
                    {DP,Digit} <= {1'b1,BCD[39:35]};
                    if (Sign)
                        Special_Case <= 1;
                    Location <= 0;
                end 
        endcase
    end
endmodule

module CLK100MHZ_divider#(RATE=10000)(CLK100MHZ, New_Clock);
    input wire CLK100MHZ;      // Input clock signal
    output reg New_Clock;         // Divided clock output
    
    reg [31:0] count = 0; // [31:0] is large enough to hold any value

    initial begin
        New_Clock = 0;
        count = 0;
    end

    always @(posedge CLK100MHZ) begin
        count <= count + 1;   // Increment count
        if (count == RATE) begin
            New_Clock <= ~New_Clock; // Toggle New Clock
            count <= 31'b0;       // Reset count
        end 
    end
endmodule


