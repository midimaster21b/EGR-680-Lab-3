`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/16/2018 07:00:50 PM
// Design Name: Vending Machine
// Module Name: item_decoder_tb
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


module item_decoder_tb();
   reg clk;
   reg rst;

   reg [3:0] item_char = 0;
   wire [3:0] seven_seg_out;

   item_decoder testing(clk, rst, item_char, seven_seg_out, seven_seg_channel);

   // Generate clock signal
   always #10 clk = ~clk;

   initial
     begin
	clk = 1'b0;
	rst = 1'b1;
     end

   initial #100 rst = 1'b0;

   initial #200 item_char = 1;

   initial #300 item_char = 2;

   initial #400 item_char = 3;

   initial #500 item_char = 4;

   initial #600 item_char = 5;

   initial #700 item_char = 6;

   initial #800 item_char = 7;

   initial #900 item_char = 8;

   initial #1000 $finish;
endmodule
