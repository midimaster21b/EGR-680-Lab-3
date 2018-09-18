`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/16/2018 09:48:03 PM
// Design Name: Vending Machine
// Module Name: seven_segment_tb
// Project Name: EGR 680 - Lab 3
// Target Devices: xc7z020clg400-1
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


module seven_segment_tb();

   reg [3:0] character;
   wire [6:0] seven_seg_out;

   // Initialize module
   seven_segment_decoder s1(character, seven_seg_out);

   // Initialize wire values
   // initial
   //   begin
   //	// character = 0;
   //   end

   initial #50 character  = 0;
   initial #100 character = 1;
   initial #150 character = 2;
   initial #200 character = 3;
   initial #250 character = 4;
   initial #300 character = 5;
   initial #350 character = 6;
   initial #400 character = 7;
   initial #450 character = 8;
   initial #500 character = 9;
   initial #550 character = 10;
   initial #600 character = 11;
   initial #650 character = 12;
   initial #700 character = 13;
   initial #750 character = 14;
   initial #800 character = 15;

   // Run for 1000 ns
   initial #1000 $finish;


endmodule
