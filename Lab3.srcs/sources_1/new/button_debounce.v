`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 03:03:54 PM
// Design Name: Vending Machine
// Module Name: button_debounce
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


module button_debounce(clk, rst, button, debounced_button);

   // Declare inputs and outputs
   input clk, rst, button;
   output debounced_button;

   // Declare necessary registers
   // reg	  button;
   reg	  debounced_button;
   reg [3:0] counter = 0;
   parameter [3:0] peak = 4;

   always @(rst)
     begin
	// Handle reset conditions
	if(rst == 1)
	  begin
	     counter = 0;
	  end
     end

   always @(posedge clk)
     begin
	// Increment counter if button is pressed
	if(button == 1)
	  begin
	     counter = counter + 1;
	  end
	else
	  begin
	     counter = 0;
	  end

	// Check debounce conditions
	if(counter == peak)
	  begin
	     debounced_button = 1;
	  end
	else
	  begin
	     debounced_button = 0;
	  end
     end
endmodule
