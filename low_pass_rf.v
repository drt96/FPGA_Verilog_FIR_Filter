`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Thomson
// 
// Create Date: 07/09/2020 05:18:19 PM
// Design Name: 
// Module Name: low_pass_rf
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

module low_pass_rf(
    input signed [7:0] sig_in,
    input clk,
    input rst,
    input enable,
    output reg signed [7:0] sig_out // Monitor for overflow
    );

reg cnt; // Counter used to wait 20 clock cycles to get the delayed data lined up

parameter N = 21; // Number of taps (b bit coeffiecent resolution)
parameter  
a0 = 1,
a1 = 3,
a2 = 4,
a3 = 3,
a4 = -2,
a5 = -7,
a6 = -7,
a7 = 2,
a8 = 18,
a9 = 34,
a10 = 40,
a11 = 34,
a12 = 18,
a13 = 2,
a14 = -7,
a15 = -7,
a16 = -2,
a17 = 3,
a18 = 4,
a19 = 3,
a20 = 1;

reg signed [7:0] data [0:N-1]; // Taps
reg signed [7:0] temp [0:N-1]; // Multiply results
reg signed [7:0] partial_sum [0:16]; 

integer i;

initial cnt = 0;

always @ (posedge clk)
    begin
        if (enable)
            begin            
                data[0] <= sig_in;
                for (i = 1; i < N-1; i = i + 1) 
                    begin
                        data[i] <= data[i-1];   
                    end
             end
         
         if (rst)
            begin
                for (i = 0; i < N-1 ; i = i + 1) 
                    begin
                        data[i] <= 8'h00;
                    end
            end
            
        if (cnt == 20) cnt <= 0;
        else cnt <= cnt + 1;
    end
    
//genvar i;
//generate
//	 for (i = 0; i < N-1 ; i = i + 1) 
//         begin: makeDelay 
//             always @ (posedge clk)
//              begin
//                if (rst) data[0] <= 0;
//                else 
//                    begin
//                        data[0] <= sig_in;
//                    end
//              end
//         end
//endgenerate

// Grab the data 12 bits at a time so that we can start the calculations for the fir
//always @ (posedge clk)
//    begin
//        if (rst) data[0] <= 0;
//        else if (enable) data[0] <= sig_in;
//        else data[0] <= 0;
//    end

// Multiply by the coefficients // DOUBLE CHECK THE ORDER 0-K or K-0 for the multiply
 always @ (posedge clk)
    begin
    if (cnt == 20)
        begin
          temp[0] <= a0 * data[0];
          temp[1] <= a1 * data[1];
          temp[2] <= a2 * data[2];
          temp[3] <= a3 * data[3];
          temp[4] <= a4 * data[4];
          temp[5] <= a5 * data[5];
          temp[6] <= a6 * data[6];
          temp[7] <= a7 * data[7];
          temp[8] <= a8 * data[8];
          temp[9] <= a9 * data[9];
          temp[10] <= a10 * data[10];
          temp[11] <= a11 * data[11];
          temp[12] <= a12 * data[12];
          temp[13] <= a13 * data[13];
          temp[14] <= a14 * data[14];
          temp[15] <= a15 * data[15];
          temp[16] <= a16 * data[16];
          temp[17] <= a17 * data[17];
          temp[18] <= a18 * data[18];
          temp[19] <= a19 * data[19];
          temp[20] <= a20 * data[20];
       end
//   temp[0] <= a20 * data[0];
//      temp[1] <= a19 * data[1];
//      temp[2] <= a18 * data[2];
//      temp[3] <= a17 * data[3];
//      temp[4] <= a16 * data[4];
//      temp[5] <= a15 * data[5];
//      temp[6] <= a14 * data[6];
//      temp[7] <= a13 * data[7];
//      temp[8] <= a12 * data[8];
//      temp[9] <= a11 * data[9];
//      temp[10] <= a10 * data[10];
//      temp[11] <= a9 * data[11];
//      temp[12] <= a8 * data[12];
//      temp[13] <= a7 * data[13];
//      temp[14] <= a6 * data[14];
//      temp[15] <= a5 * data[15];
//      temp[16] <= a4 * data[16];
//      temp[17] <= a3 * data[17];
//      temp[18] <= a2 * data[18];
//      temp[19] <= a1 * data[19];
//      temp[20] <= a0 * data[20];
    end
        
// pipeline these adds
// sum up the result 
// Should incure about 4 maybe 5 delays
always @ (posedge clk)
    begin
    if (cnt == 20)
            begin
            sig_out <= temp[0] +
                      temp[1] +
                      temp[2] +
                      temp[3] +
                      temp[4] +
                      temp[5] +
                      temp[6] +
                      temp[7] +
                      temp[8] +
                      temp[9] +
                      temp[10]+
                      temp[11]+
                      temp[12]+
                      temp[13]+
                      temp[14]+
                      temp[15]+
                      temp[16]+
                      temp[17]+
                      temp[18]+
                      temp[19]+
                      temp[20];
              end
       end
//    if (cnt == 20)
//        begin
//            partial_sum[0] <= temp[0] + temp[1];
//            partial_sum[1] <= temp[2] + temp[3];
//            partial_sum[2] <= temp[4] + temp[5]; 
//            partial_sum[3] <= temp[6] + temp[7]; 
//            partial_sum[5] <= temp[8] + temp[9]; 
//            partial_sum[6] <= temp[10] + temp[11];
//            partial_sum[7] <= temp[12] + temp[13]; 
//            partial_sum[8] <= temp[14] + temp[15]; 
//            partial_sum[9] <= temp[16] + temp[17]; 
//            partial_sum[10] <= temp[18] + temp[19] + temp[20]; 
                    
//                   partial_sum[11] <= partial_sum[0] + partial_sum[1] + partial_sum[2];
//                   partial_sum[12] <= partial_sum[3] + partial_sum[4] + partial_sum[5];
//                   partial_sum[13] <= partial_sum[6] + partial_sum[7] + partial_sum[8];
//                   partial_sum[14] <= partial_sum[9] + partial_sum[10];  
                   
//                           partial_sum[15] <= partial_sum[11] + partial_sum[12];
//                           partial_sum[16] <= partial_sum[13] + partial_sum[14];
                           
//                                sig_out <=  partial_sum[15] + partial_sum[16];
      //  end
   // end                
endmodule                 