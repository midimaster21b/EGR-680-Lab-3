`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 04:46:59 PM
// Design Name: Vending Machine
// Module Name: clock_divider_tb
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


module clock_divider_tb();
   reg clk;
   reg rst;

   clock_divider #(4) testing(clk, rst, clk_div);

   // Generate clock signal
   always #10 clk = ~clk;

   initial
     begin
	clk = 1'b0;
	rst = 1'b1;
     end

   initial #100 rst = 1'b0;

   initial #1000 $finish;
endmodule
