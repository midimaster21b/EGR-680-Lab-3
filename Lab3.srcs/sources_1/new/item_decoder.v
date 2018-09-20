`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 09:12:45 PM
// Design Name: Vending Machine
// Module Name: item_decoder
// Project Name: EGR 680 - Lab 2
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

module item_decoder(clk, rst, item, item_character_one, item_character_two, item_output_channel);
// module item_decoder(clk, rst, item, item_character_one, item_output_channel_one, item_character_two, item_output_channel_two);

   // Declare inputs
   input clk, rst;
   input  [3:0] item;
   output [4:0] item_character_one;
   output [4:0] item_character_two;
   // output item_output_channel_one;
   // output item_output_channel_two;
   output	item_output_channel;


   // Define registers for the module
   reg [4:0] item_character_one;
   reg [4:0] item_character_two;
   // reg item_output_channel_one;
   // reg item_output_channel_one;
   reg [1:0] item_output_channel;

   always @(posedge clk)
     begin
	case(item)
	  // When nothing is being dispensed, print nothing
	  `dispensing_nothing:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 16; // V
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 14; // n
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 11; // E
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 15; // d
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When dispensing gum, print g
	  `dispensing_gum:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 12; // g
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 31; // blank
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When dispensing an apple, print A
	  `dispensing_apple:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 10; // A
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 31; // blank
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When dispensing a yogurt, print y
	  `dispensing_yogurt:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 13; // y
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 31; // blank
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When a total of zero is present, print 00
	  `total_zero:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 0;  // 0
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 0;  // 0
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When a total of five is present, print 05
	  `total_five:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 0;  // 0
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 5;  // 5
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When a total of ten is present, print 10
	  `total_ten:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 1;  // 1
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 0;  // 0
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When a total of fifteen is present, print 15
	  `total_fifteen:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 1;  // 1
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 5;  // 5
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  // When a total of twenty is present, print 20
	  `total_twenty:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 2;  // 2
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 0;  // 0
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end

	  default:
	    begin
	       // if(item_output_channel_one == 0)
	       if(item_output_channel[0] == 0)
		 begin
		    item_character_one <= 31; // blank
		    // item_output_channel_one <= 1;
		    item_output_channel[0] <= 1;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 1;
		 end
	       else
		 begin
		    item_character_one <= 31; // blank
		    // item_output_channel_one <= 0;
		    item_output_channel[0] <= 0;

		    item_character_two <= 31; // blank
		    item_output_channel[1] <= 0;
		 end
	    end
	endcase // case (item)
     end // always @ (item)
endmodule
