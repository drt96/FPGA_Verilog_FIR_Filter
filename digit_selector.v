`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2020 03:48:48 PM
// Design Name: 
// Module Name: digit_selector
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


module digit_selector(
    input clk,
    input rst,
    output reg [3:0] digit_sel
    );
    
     reg [1:0] cnt;
    initial cnt = 0;
     
    // Select one digit at a time 
    always @ (posedge clk, posedge rst) 
        begin
        if (rst) cnt <= 0;
            case (cnt)
                2'b00: digit_sel <= 4'b1110;
                2'b01: digit_sel <= 4'b1101;
                2'b10: digit_sel <= 4'b1011;
                2'b11: digit_sel <= 4'b0111;
                default: digit_sel <= 4'b1111;
            endcase
            cnt <= cnt + 1;
        end
    
endmodule
