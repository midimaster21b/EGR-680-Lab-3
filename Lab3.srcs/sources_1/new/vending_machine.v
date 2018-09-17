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
`define dispense_apple_15  4'b0111

// 20 cents dispense states
`define dispense_gum_20    4'b1000
`define dispense_apple_20  4'b1001
`define dispense_yogurt_20 4'b1010

// Dispensed item definitions
`define dispensing_nothing 4'b0000
`define dispensing_gum     4'b0001
`define dispensing_apple   4'b0010
`define dispensing_yogurt  4'b0011

// Define current total money input
// NOTE: HACKY METHOD!!!
// TODO: FIND A MORE ELEGANT APPROVED SOLUTION
`define total_zero         4'b0100
`define total_five         4'b0101
`define total_ten          4'b0110
`define total_fifteen      4'b0111
`define total_twenty       4'b1000

// Change definitions
`define change_nothing     2'b00
`define change_five        2'b01
`define change_ten         2'b10
`define change_fifteen     2'b11

module vending_machine(clk, rst, nickel, dime, gum, apple, yogurt, dispensed_item, change);

   // Define inputs/outputs
   input  clk, rst, nickel, dime, gum, apple, yogurt;
   output [3:0] dispensed_item;
   output [1:0] change;

   // Define module parameters
   parameter [31:0] dispenser_state_time = 124999999; // 1 second

   // Define module registers
   reg [3:0]	current_state = `reset;
   reg [3:0]	next_state = `reset;
   reg [31:0]	temp_counter = 0; // For waiting in states
   reg [1:0]	change = 0;
   reg [3:0]	dispensed_item = 0;

   // State transition
   always @(posedge clk)
     begin
	if(rst == 1)
	  begin
	     current_state = `reset;
	  end
	else
	  begin
	     // Assign next state to current state
	     current_state = next_state;
	  end
     end // always @ (posedge clk)

   // Next state logic
   always @(posedge clk)
     begin
	case(current_state)
	  /**********************
	   * Reset State
	   **********************/
	  `reset:
	    begin
	       temp_counter = 0;

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
		    next_state <= `fifteen_cents;
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

	  /************************
	   * Dispensing Gum States
	   ************************/
	  `dispense_gum_10:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_gum_10;
		 end
	    end // case: `dispense_gum_10

	  `dispense_gum_15:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_gum_15;
		 end
	    end // case: `dispense_gum_15

	  `dispense_gum_20:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_gum_20;
		 end
	    end // case: `dispense_gum_20

	  /**************************
	   * Dispensing Apple States
	   **************************/
	  `dispense_apple_15:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_apple_15;
		 end
	    end // case: `dispense_apple_15

	  `dispense_apple_20:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_apple_20;
		 end
	    end // case: `dispense_apple_20

	  /***************************
	   * Dispensing Yogurt States
	   ***************************/
	  `dispense_yogurt_20:
	    begin
	       // Check if it has reached dispenser state time
	       if(temp_counter >= dispenser_state_time)
		 begin
		    temp_counter = 0;
		    next_state <= `reset;
		 end
	       else
		 begin
		    // Increment temp counter
		    temp_counter = temp_counter + 1;
		    next_state <= `dispense_yogurt_20;
		 end
	    end // case: `dispense_yogurt_20

	  // handle out of range state
	  default: next_state <= `reset;
	endcase // case (current_state)
     end // always @ *


   // Handle output behavior
   always @(posedge clk)
     begin
	case(current_state)
	  /**************************
	   * Gum dispensing behavior
	   **************************/
	  `dispense_gum_10:
	    begin
	       dispensed_item <= `dispensing_gum;
	       change <= `change_nothing;
	    end

	  `dispense_gum_15:
	    begin
	       dispensed_item <= `dispensing_gum;
	       change <= `change_five;
	    end

	  `dispense_gum_20:
	    begin
	       dispensed_item <= `dispensing_gum;
	       change <= `change_ten;
	    end

	  /****************************
	   * Apple dispensing behavior
	   ****************************/
	  `dispense_apple_15:
	    begin
	       dispensed_item <= `dispensing_apple;
	       change <= `change_nothing;
	    end

	  `dispense_apple_20:
	    begin
	       dispensed_item <= `dispensing_apple;
	       change <= `change_five;
	    end

	  /*****************************
	   * Yogurt dispensing behavior
	   *****************************/
	  `dispense_yogurt_20:
	    begin
	       dispensed_item <= `dispensing_yogurt;
	       change <= `change_nothing;
	    end


	  /*****************************
	   * Current total money input
	   *****************************/
	  `five_cents:
	    begin
	       dispensed_item <= `total_five;
	       change <= `change_nothing;
	    end

	  `ten_cents:
	    begin
	       dispensed_item <= `total_ten;
	       change <= `change_nothing;
	    end

	  `fifteen_cents:
	    begin
	       dispensed_item <= `total_fifteen;
	       change <= `change_nothing;
	    end

	  `twenty_cents:
	    begin
	       dispensed_item <= `total_twenty;
	       change <= `change_nothing;
	    end

	  /*****************************
	   * Default dispensing behavior
	   *****************************/
	  default:
	    begin
	       dispensed_item <= `total_zero;
	       change <= `change_nothing;
	    end
	endcase // case (current_state)
     end // always @ (posedge clk)
endmodule
