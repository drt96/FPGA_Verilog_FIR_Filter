`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2020 03:30:21 PM
// Design Name: 
// Module Name: seg7
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


module sseg(
    input [3:0] sw,
    output reg [0:6] seg,
    output dp,
    output [3:0] an
    );
    assign dp = 1'b1; //force the decimal point off
    
    always @(sw)  // sw is in the sensitivity list
    begin
        if (sw == 4'h0) seg = 7'b000001;
    	else if (sw == 4'h1) seg = 7'b1001111;
    	else if (sw == 4'h2) seg = 7'b0010010;
    	else if (sw == 4'h3) seg = 7'b0000110;
    	else if (sw == 4'h4) seg = 7'b1001100;
    	else if (sw == 4'h5) seg = 7'b0100100;
    	else if (sw == 4'h6) seg = 7'b0100000;
    	else if (sw == 4'h7) seg = 7'b0001111;
    	else if (sw == 4'h8) seg = 7'b0000000;
    	else if (sw == 4'h9) seg = 7'b0000100;
    	else if (sw == 4'ha) seg = 7'b0001000;
    	else if (sw == 4'hb) seg = 7'b1100000;
    	else if (sw == 4'hc) seg = 7'b0110001;
    	else if (sw == 4'hd) seg = 7'b1000010;
    	else if (sw == 4'he) seg = 7'b0110000;
    	else if (sw == 4'hf) seg = 7'b0111000;
    	else seg = 7'b1111111;
    end //always
endmodule
