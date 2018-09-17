`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Joshua Edgcombe
//
// Create Date: 09/15/2018 03:03:54 PM
// Design Name: Vending Machine
// Module Name: vending_machine_top
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


module vending_machine_top(
    input clk,
    input rst,
    input nickel,
    input dime,
    input gum,
    input apple,
    input yogurt,
    output [6:0] seven_segment,
    output seven_segment_digit,
    output reg progress_bar_clk,
    output reg progress_bar_data
    );

   // Debounce wires
   wire    deb_nic, deb_dime, deb_gum, deb_app, deb_yog;
   wire    deb_clk, disp_clk;

   // Activity wire (for reset timer)
   wire    activity, reset_line, inactivity_rst;

   // Registers for game output
   // reg [3:0] display;
   // reg [1:0] change;
   wire [1:0] change;
   wire [3:0] display;

   // reg [3:0]  seven_seg_char;
   wire [3:0]  seven_seg_char;

   // OR the user input reset line and inactivity reset line for final reset line
   or rst_or(reset_line, rst, inactivity_rst);

   // Activity is due to user input, user reset, or inactivity timeout
   or active_or(activity, reset_line, deb_nic, deb_dime, deb_gum, deb_app, deb_yog);

   // Reset timer (3 seconds)
   clock_divider #(374999999) reset_timer(clk, activity, inactivity_rst);

   // Divide clock down to 50 ms period for debouncing
   clock_divider #(6249999) debounce_clk(clk, rst, deb_clk);

   // Seven segment display divider
   clock_divider #(499999) display_clk(clk, rst, disp_clk);

   // Button debouncing 4 for 250 ms debounce
   button_debounce #(8) nickel_debounce(deb_clk, rst, nickel, deb_nic);
   button_debounce #(8) dime_debounce(deb_clk, rst, dime, deb_dime);
   button_debounce #(8) gum_debounce(deb_clk, rst, gum, deb_gum);
   button_debounce #(8) apple_debounce(deb_clk, rst, apple, deb_app);
   button_debounce #(8) yogurt_debounce(deb_clk, rst, yogurt, deb_yog);

   // Hook up vending machine
   vending_machine vendor(clk,
			  reset_line,
			  deb_nic,
			  deb_dime,
			  deb_gum,
			  deb_app,
			  deb_yog,
			  display,
			  change);

   // Item output translation
   item_decoder item_dec(disp_clk, rst, display, seven_seg_char, seven_segment_digit);

   // Seven segment decoder
   seven_segment_decoder sev_seg(seven_seg_char, seven_segment);

   always @*
     begin
	progress_bar_clk <= 0;
	progress_bar_data <= 0;
     end
endmodule
