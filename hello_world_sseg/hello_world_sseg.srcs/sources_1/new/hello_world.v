`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 02:11:29 PM
// Design Name: 
// Module Name: hello_world
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


module hello_world#(
    RATE =  12_500_000
    )(
    input CLK100MHZ,
    output [6:0] seg,
    output [7:0] an,
    output dp
    );
    
    localparam [5:0] H = 5'b10100;
    localparam [5:0] E = 5'b01110;
    localparam [5:0] L = 5'b10101;
    localparam [5:0] O = 5'b00000;
    
    localparam [9:0] w = 5'b10000;
    localparam [5:0] u = 5'b10001;
    localparam [5:0] o = 5'b10010;
    localparam [5:0] r = 5'b10011;
    localparam [5:0] l = 5'b00001;
    localparam [5:0] d = 5'b01101;
    localparam [5:0] space = 5'b10111;
    
    reg [4:0] hello_world [12:0];
    reg [39:0] out;
    reg [3:0] count;

    CLK100MHZ_divider #(
    .RATE(RATE)
    ) clk_1sec (
    .CLK100MHZ(CLK100MHZ),
    .New_Clock(clk_1s)
    );
    
    SSEG sseg(
    .CLK100MHZ(CLK100MHZ),
    .BCD(out),
    .DP(dp),
    .G(seg[6]),
    .F(seg[5]),
    .E(seg[4]),
    .D(seg[3]),
    .C(seg[2]),
    .B(seg[1]),
    .A(seg[0]),
    .Enable(an)
    );
    
    initial begin
        out = {{8{space}}};
        hello_world[0] = H;
        hello_world[1] = E;
        hello_world[2] = L;
        hello_world[3] = L;
        hello_world[4] = O;
        hello_world[5] = space;
        hello_world[6] = w;
        hello_world[7] = u;
        hello_world[8] = o;
        hello_world[9] = r;
        hello_world[10] = 1;
        hello_world[11] = d;
        hello_world[12] = space;
        count = 0;
    end
    
    always@(posedge clk_1s) begin
        if (count == 4'hD) begin
            count = 0; end
        out <= {out[34:0], hello_world[count]};
        count = count + 1;
    end
endmodule
