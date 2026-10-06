`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 04:04:10 PM
// Design Name: 
// Module Name: tb_hello_world
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


module tb_hello_world();

    reg clk;
    wire [6:0] seg;
    wire [7:0] an;
    wire dp;
    
    hello_world #(
    .RATE (10_000)
    ) hw (
    .CLK100MHZ(clk),
    .seg(seg),
    .an(an),
    .dp(dp)
    );
    
    initial begin
        clk = 1'b0; forever #5 clk = ~clk; end
        
    initial begin
        $display("Seg");
        $monitor("%b", seg);
//        #10000;
//        $finish;
    end
endmodule
