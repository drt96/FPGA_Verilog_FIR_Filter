`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 03:41:15 PM
// Design Name: 
// Module Name: sseg_x4_top
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

module sseg_x4_top(
    input [15:0] sw,
    input clk,
    input rst,
    output [0:6] seg,
    output [3:0] an,
    output dp
    );
    
    wire [3:0] not_used; // Place holder individual anodes which are handled by digit_selector
    wire clkd; // 200 Hz Clock
    wire [0:3] hex_num; // Can't be called sw any more so I'll call it 
    
    // Get the clock frequency divided down by the clock generator (200Hz)
    clk_gen U1(.clk(clk), .rst(rst), .clk_div(clkd));
    // Display one character at a time
    digit_selector U2(.clk(clkd), .rst(rst), .digit_sel(an));
    // Assign the correct hexadecimal number to the correct digit
    hex_num_gen U3(.digit_sel(an), .sw(sw), .hex_num(hex_num));
    // Handle hardware for display
    sseg U4(.seg(seg), .an(not_used), .dp(dp), .sw(hex_num));
   
endmodule
