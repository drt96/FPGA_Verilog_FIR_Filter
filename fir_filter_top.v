`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2020 01:12:57 PM
// Design Name: 
// Module Name: fir_filter_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// Need a signal generator capable of doing at least 1MHz.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fir_filter_top(
   input clk,
   input btnC, // rst
   input vauxp6, // Wave gen max
   input vauxn6, // Wave gen min
   input sw, // Filtering On/Off switch
   output [3:0] an,
   output dp,
   output [0:6] seg,
   output [7:0] JB // DAC output
    );
    
   wire enable;
   wire [6:0] Address_in;     
   reg [15:0] string;
   wire [15:0] data; // Input data being received by the ADC and made digital
   wire signed [7:0] filtered_data; // Output data after the filter has cleaned it up 
   reg [7:0] filtered_data_tm[0:4];

   assign Address_in = 8'h16;// What does this mean? Should be 7'h16 (Read adrressing) user guild never uses 1 and 6 together
   
 assign JB = filtered_data; // Send the filtered data to the DAC
   
//assign JB = data[15:8]; // 12 MSBs are the registers where the data resides but DAC only used 8 bits
   
    xadc_wiz_0 XLXI_7 (
      .daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
                             // set this to 8'h16.
      .dclk_in(clk),   // use the 100MHz clock to connect to dclk_in.  This will automatically be 
                             // divided by 100 to 1MHz for the sample clock
      .den_in(enable),   // must come from the eoc_out signal
      .di_in(),          // not needed
      .dwe_in(),         // not needed
      .busy_out(),       // not needed          
      .vauxp6(vauxp6),   // positive analog input (pin 1 of the XADC PMOD port)
      .vauxn6(vauxn6),   // negative analog input (pin 7 of the XADC PMOD port)
      .vn_in(),          // not needed
      .vp_in(),          // not needed
      .alarm_out(),      // not needed
      .do_out(data),     // 16-bit data output (only 12 (upper) bits are used)
      .reset_in(),       // not needed
      .eoc_out(enable),  // must connect to den_in input
      .channel_out(),    // not needed
      .drdy_out()        // not needed SHOULD I USE THIS?
      );
    
    /* Create a delayed version of data by 4 cycles so that
        we can make time for the pipelining */
//    always @ (posedge clk)
//        begin
//            filtered_data_tm[0] <= filtered_data;
//            filtered_data_tm[1] <= filtered_data_tm[0];
//            filtered_data_tm[2] <= filtered_data_tm[1];
//            filtered_data_tm[3] <= filtered_data_tm[2];
//            filtered_data_tm[4] <= filtered_data_tm[3];
//        end
        
    // Filter the signal and send it to the DAC
    low_pass_rf filter(.sig_in(data[15:8]), .clk(clk), .rst(btnC), .sig_out(filtered_data), .enable(sw));
    
    // Set up display of cool stuff on 7seg 
    always @ (*)
        begin
            if (btnC)
                string = 16'h1111; // test pattern
            else if (sw)
                string = 16'h000F; // Filter on
            else if (~sw)
                string = 16'h0000; // filter off
            else
            string = 16'he404; // Error 404 input not found
        end
    
    // Helpful debug display
    sseg_x4_top display(
      .sw(string),
      .clk(clk),
      .rst(btnC),
      .an(an),
      .dp(dp),
      .seg(seg));    

    // test_DAC test1(.clk(clk), .JB(JB));

endmodule

module test_DAC(
    input clk,
    output reg [7:0] JB
);

wire slow_clk;

clk_gen cd1(.clk(clk), .rst(1'b0), .clk_div(slow_clk));

initial JB = 8'h00;
always @ (posedge slow_clk)
    begin
        JB <= JB + 1;
    end 
endmodule