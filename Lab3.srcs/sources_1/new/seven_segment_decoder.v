`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 03:03:54 PM
// Design Name: Vending Machine
// Module Name: seven_segment_decoder
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


module seven_segment_decoder(clk, rst, char, decoded_output);

   // Declare inputs and outputs
   input clk, rst;
   input [3:0] char;
   output [6:0] decoded_output;

   // Declare module registers
   reg [6:0]	decoded_output;

   // Handle reset behavior
   always @(rst)
     begin
	if(rst == 1)
	  begin
	     decoded_output <= 7'b0000000;
	  end
     end

   // Handle decoder behavior
   always @(posedge clk)
     begin
	case(char)
	  // Numbers
	  0: decoded_output <= 7'b1111110; // 0
	  1: decoded_output <= 7'b0110000; // 1, l
	  2: decoded_output <= 7'b1101101; // 2, Z
	  3: decoded_output <= 7'b1111001; // 3
	  4: decoded_output <= 7'b0110011; // 4
	  5: decoded_output <= 7'b1011011; // 5, S
	  6: decoded_output <= 7'b1011111; // 6
	  7: decoded_output <= 7'b1110000; // 7, T
	  8: decoded_output <= 7'b1111111; // 8, B
	  9: decoded_output <= 7'b1110011; // 9

	  // Letters
	  10: decoded_output <= 7'b1110111; // A, R
	  11: decoded_output <= 7'b1001111; // E
	  12: decoded_output <= 7'b1111011; // g
	  13: decoded_output <= 7'b0111011; // Y

	  // Default behavior
	  default: decoded_output <= 7'b0000000; // No output
	endcase // case (char)
     end
endmodule
