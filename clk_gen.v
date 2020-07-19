`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 03:44:16 PM
// Design Name: 
// Module Name: clk_gen
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


module clk_gen(
    input clk,
    input rst,
    output clk_div
    );
    
    reg [26:0] cnt;
    initial cnt = 0;
    
    always @ (posedge clk, posedge rst) // counter to divide the system clock
        begin
            cnt <= cnt + 1;
            // asynchronous reset
            if (rst) cnt <= 0;
        end
        
     // roughly 200hz to hanndle 4 seven seg displays refreshing at 50Hz each    
    assign clk_div = cnt[18];
    
endmodule
