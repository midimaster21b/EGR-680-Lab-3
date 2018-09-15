`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 05:40:38 PM
// Design Name: Vending Machine
// Module Name: button_debounce_tb
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


module button_debounce_tb();
   reg clk, rst, btn;

   // Initialize module
   button_debounce #(4) testing(clk, rst, btn, debounce);

   // Generate clock signal
   always #10 clk = ~clk;

   // Initialize wire values
   initial
     begin
	clk = 1'b0;
	rst = 1'b1;
	btn = 1'b0;
     end

   // Pull reset low at 100 ns
   initial #100 rst = 1'b0;

   // Set button to high at 200 ns
   initial #200 btn = 1'b1;

   // Set button to low at 500 ns
   initial #500 btn = 1'b0;

   // Run for 1000 ns
   initial #1000 $finish;
endmodule
