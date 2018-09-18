`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 03:03:54 PM
// Design Name: Vending Machine
// Module Name: clock_divider
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


module clock_divider(clk, rst, divided_clk);

   // Declare inputs and outputs
   input clk, rst;
   output reg divided_clk = 0;

   // Clock divider parameters
   parameter [31:0] peak = 1000;

   // Declare registers
   reg [31:0] counter = 0;

   always @(posedge clk or posedge rst)
     begin
	// Handle reset behavior
	if(rst == 1)
	  begin
	     counter = 0;
	     divided_clk = 0;
	  end

	// // Normal behavior
	else
	  begin
	     // Increment counter
	     counter = counter + 1;

	     if(counter >= peak)
	       begin
		  divided_clk = 1;
		  counter = 0;
	       end
	     else
	       begin
		  divided_clk = 0;
	       end
	  end // else: !if(rst == 1)
     end // always @ (posedge clk or posedge rst)
endmodule
