`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2020 08:03:07 PM
// Design Name: 
// Module Name: fir_filter_TB
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


module fir_filter_TB(
    );
    reg clk, btnC, sw;
    reg [15:0] signal; 
    wire [7:0] out; // DAC output 
     
//    fir_filter_top f0(.clk(clk),
//    .btnC(btnC), // rst
//    .vauxp6(), // Wave gen max
//   .vauxn6(), // Wave gen min
//   .sw(sw), // Filtering On/Off switch
//   .an(),
//   .dp(),
//   .seg(),
//   .JB(JB)); // DAC output)
   
    low_pass_rf filter(.sig_in(signal[15:8]), .clk(clk),
     .rst(btnC), .sig_out(out), .enable(sw));
   
   initial
       begin
           clk = 1'b0;
           sw = 1'b1;
           btnC = 1'b0;
       end
       
   always #5 clk = ~clk;
   
   initial
   begin
       signal = 16'h0000; #1000000;
       signal = 16'h000F; #1000000;
       signal = 16'h00F0; #1000000;
       signal = 16'h0F00; #1000000;
       signal = 16'hF000; #1000000;
       signal = 16'hFF00; #1000000;
       signal = 16'hFFF0; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
       signal = 16'h0000; #1000000;
       signal = 16'hFFFF; #1000000;
   end
endmodule
