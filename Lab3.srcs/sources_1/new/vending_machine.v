`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 03:03:54 PM
// Design Name: Vending Machine
// Module Name: vending_machine
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


// Define states
`define reset              4'b0000

// Only money input
`define five_cents         4'b0001
`define ten_cents          4'b0010
`define fifteen_cents      4'b0011
`define twenty_cents       4'b0100

// 10 cents dispense states
`define dispense_gum_10    4'b0101

// 15 cents dispense states
`define dispense_gum_15    4'b0110
`define dispense_apple_15  4'b0110

// 20 cents dispense states
`define dispense_gum_20    4'b0111
`define dispense_apple_20  4'b1000
`define dispense_yogurt_20 4'b1001


module vending_machine(
		       input 	    clk,
		       input 	    rst,
		       input 	    nickel,
		       input 	    dime,
		       input 	    gum,
		       input 	    apple,
		       input 	    yogurt,
		       output [3:0] dispensed_item,
		       output [3:0] change
		       );

   // Define module registers
   reg [3:0] 			    current_state = `reset;
   reg [3:0] 			    next_state = `reset;

   // Handle reset behavior
   always @(rst)
     begin
	if(rst == 1)
	  begin
	     current_state = `reset;
	  end
     end

   // Handle state transition behavior
   always @(posedge clk)
     begin
	case(current_state)
	  /**********************
	   * Reset State
	   **********************/
	  `reset:
	    begin
	       // Handle nickel input
	       if(nickel == 1)
		 begin
		    next_state <= `five_cents;
		 end

	       // Handle dime input
	       else if(dime == 1)
		 begin
		    next_state <= `ten_cents;
		 end

	       else
		 begin
		    next_state <= `reset;
		 end
	    end // case: `reset


	  /**********************
	   * Five Cent State
	   **********************/
	  `five_cents:
	    begin
	       // Handle nickel entered
	       if(nickel == 1)
		 begin
		    // Handle simultaneous nickel and gum selection
		    if(gum == 1)
		      begin
			 next_state <= `dispense_gum_10;
		      end

		    // Otherwise just increment total entered amount
		    else
		      begin
			 next_state <= `ten_cents;
		      end
		 end

	       // Handle dime entered
	       else if(dime == 1)
		 begin
		    // Handle simultaneous dime and gum selection
		    if(gum == 1)
		      begin
			 next_state <= `dispense_gum_15;
		      end

		    // Handle simultaneous dime and apple selection
		    else if(apple == 1)
		      begin
			 next_state <= `dispense_apple_15;
		      end

		    // Otherwise just increment total entered amount
		    else
		      begin
			 next_state <= `fifteen_cents;
		      end
		 end // if (dime == 1)

	       else
		 begin
		    next_state <= `five_cents;
		 end // else: !if(dime == 1)
	    end // case: `five_cents

	  /**********************
	   * Ten Cent State
	   **********************/
	  `ten_cents:
	    begin
	       // Handle nickel entered
	       if(nickel == 1)
		 begin
		    // Handle simultaneous nickel and gum inputs
		    if(gum == 1)
		      begin
			 next_state <= `dispense_gum_15;
		      end

		    // Handle simultaneous nickel and apple inputs
		    else if(apple == 1)
		      begin
			 next_state <= `dispense_apple_15;
		      end

		    // Otherwise increment total money input
		    else
		      begin
			 next_state <= `fifteen_cents;
		      end
		 end // if (nickel == 1)

	       // Handle dime entered
	       else if(dime == 1)
		 begin
		    // Handle simultaneous dime and gum inputs
		    if(gum == 1)
		      begin
			 next_state <= `dispense_gum_20;
		      end

		    // Handle simultaneous dime and apple inputs
		    else if(apple == 1)
		      begin
			 next_state <= `dispense_apple_20;
		      end

		    // Handle simultaneous dime and yogurt inputs
		    else if(yogurt == 1)
		      begin
			 next_state <= `dispense_yogurt_20;
		      end

		    // Otherwise increment total money input
		    else
		      begin
			 next_state <= `twenty_cents;
		      end
		 end // if (dime == 1)

	       // Handle gum alone entered
	       else if(gum == 1)
		 begin
		    next_state <= `dispense_gum_10;
		 end

	       else
		 begin
		    next_state <= `ten_cents;
		 end
	    end // case: `ten_cents

	  /**********************
	   * Fifteen Cent State
	   **********************/
	  `fifteen_cents:
	    begin
	       // Handle nickel or dime entered (20 cent max cap)
	       if(nickel == 1 || dime == 1)
		 begin
		    // Handle simultaneous nickel and gum inputs
		    if(gum == 1)
		      begin
			 next_state <= `dispense_gum_20;
		      end

		    // Handle simultaneous nickel and apple inputs
		    else if(apple == 1)
		      begin
			 next_state <= `dispense_apple_20;
		      end

		    // Handle simultaneous nickel and yogurt inputs
		    else if(yogurt == 1)
		      begin
			 next_state <= `dispense_yogurt_20;
		      end

		    // Otherwise increment total money input
		    else
		      begin
			 next_state <= `twenty_cents;
		      end
		 end // if (nickel == 1)

	       // Handle gum alone entered
	       else if(gum == 1)
		 begin
		    next_state <= `dispense_gum_15;
		 end

	       // Handle apple alone entered
	       else if(apple == 1)
		 begin
		    next_state <= `dispense_apple_15;
		 end

	       else
		 begin
		    next_state = `fifteen_cents;
		 end

	    end // case: `fifteen_cents

	  /**********************
	   * Twenty Cent State
	   **********************/
	  `twenty_cents:
	    begin
	       // Handle gum input
	       if(gum == 1)
		 begin
		    next_state <= `dispense_gum_20;
		 end

	       // Handle apple input
	       else if(apple == 1)
		 begin
		    next_state <= `dispense_apple_20;
		 end

	       // Handle yogurt input
	       else if(yogurt == 1)
		 begin
		    next_state <= `dispense_yogurt_20;
		 end

	       // Handle no input
	       else
		 begin
		    next_state <= `twenty_cents;
		 end

	    end // case: `twenty_cents

	  // handle out of range state
	  default: next_state = `reset;
	endcase // case (current_state)
     end

   // Continuous assignment of next state to current state
   assign current_state = next_state;

endmodule
