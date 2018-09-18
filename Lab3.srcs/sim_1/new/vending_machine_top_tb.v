`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/16/2018 08:08:42 PM
// Design Name: Vending Machine
// Module Name: vending_machine_top_tb
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


module vending_machine_top_tb();
   reg clk, rst, btn;

   reg nickel, dime, gum, apple, yogurt;
   wire [6:0] seven_seg_out;
   wire       progress_bar_clk;
   wire       progress_bar_data;

   // Initialize module
   vending_machine_top testing(clk, rst,
			       nickel,
			       dime,
			       gum,
			       apple,
			       yogurt,
			       // seven_segment,
			       seven_seg_out,
			       seven_segment_digit,
			       progress_bar_clk,
			       progress_bar_data
    );

   // Generate clock signal
   always #10 clk = ~clk;

   // Initialize wire values
   initial
     begin
	clk = 1'b0;
	rst = 1'b0;
	btn = 1'b0;
	nickel = 1'b0;
	dime = 1'b0;
	gum = 1'b0;
	apple = 1'b0;
	yogurt = 1'b0;
     end

   // Pull reset low at 100 ns
   initial #100 rst = 1'b0;

   // Set nickel high at 200 ns
   initial #200 nickel = 1'b1;

   // Run for 1000 ns
   initial #1000 $finish;

endmodule
