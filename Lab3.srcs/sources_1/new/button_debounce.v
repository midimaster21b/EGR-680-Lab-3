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

   // Declare module parameters
   parameter [31:0] clk_division = 6249999; // 50 ms intervals
   parameter [3:0] seq_samps = 4; // Sequential samples necessary to trigger a debounced output
   parameter samp_val = 1; // Normally desire the sample to be high for a debounce to occur


   // Declare necessary registers
   reg	  debounced_button;
   reg [9:0] samp_counter = 0; // Counts from zero up to seq_samps and triggers a debounce
   reg [31:0] clk_counter = 0; // Counts from zero to clk_division (Used for clock division)

   always @(posedge clk or posedge rst)
     begin
	// Handle reset conditions
	if(rst == 1)
	  begin
	     // Reset clock divider and sequential sample counters to zero
	     samp_counter = 0;
	     clk_counter = 0;
	  end

	else
	  begin
	     if(clk_counter >= clk_division)
	       begin
		  // Reset clk divider counter to zero
		  clk_counter = 0;

		  // Increment counter if button is pressed
		  if(button == samp_val)
		    begin
		       samp_counter = samp_counter + 1;
		    end
		  else
		    begin
		       samp_counter = 0;
		    end

		  // Check debounce conditions
		  if(samp_counter == seq_samps)
		    begin
		       debounced_button = 1;
		    end
		  else
		    begin
		       debounced_button = 0;
		    end
	       end // if (clk_counter >= clk_division)
	     else
	       begin
		  // Increment clock divider counter
		  clk_counter = clk_counter + 1;

		  // Set debounced output to zero
		  debounced_button = 0;
	       end // else: !if(clk_counter >= clk_division)

	  end
     end
endmodule
