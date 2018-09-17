`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/16/2018 08:27:50 PM
// Design Name: Vending Machine
// Module Name: vending_machine_tb
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


module vending_machine_tb();
   reg clk, rst, btn;

   reg nickel, dime, gum, apple, yogurt;
   wire [3:0] desired_out;
   wire [1:0] change;

   // Initialize module
   vending_machine testing(clk, rst,
			   nickel,
			   dime,
			   gum,
			   apple,
			   yogurt,
			   desired_out,
			   change
			   );

   // Generate clock signal
   always #10 clk = ~clk;

   // Initialize wire values
   initial
     begin
	clk = 1'b0;
	rst = 1'b1;
	btn = 1'b0;
	nickel = 1'b0;
	dime = 1'b0;
	gum = 1'b0;
	apple = 1'b0;
	yogurt = 1'b0;
     end

   // Pull reset low at 100 ns
   initial #100 rst = 1'b0;

   // Set button to high at 200 ns
   initial #300 nickel = 1'b1;
   // initial #400 nickel = 1'b0;

   // Set button to low at 500 ns
   // initial #500 btn = 1'b0;

   // Run for 1000 ns
   initial #1000 $finish;
endmodule
