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
    output [1:0] seven_segment_digit,
    output progress_bar_clk,
    output progress_bar_output
    );

   // Debounce wires
   wire    deb_nic, deb_dime, deb_gum, deb_app, deb_yog;
   wire    deb_clk;

   // Divide clock down to 50 ms period for debouncing
   clock_divider #(6249999) debounce_clk(clk, rst, deb_clk);

   // Button debouncing 4 for 250 ms debounce
   button_debounce #(4) nickel_debounce(deb_clk, rst, nickel, deb_nic);
   button_debounce #(4) dime_debounce(deb_clk, rst, dime, deb_dime);
   button_debounce #(4) gum_debounce(deb_clk, rst, gum, deb_gum);
   button_debounce #(4) apple_debounce(deb_clk, rst, apple, deb_app);
   button_debounce #(4) yogurt_debounce(deb_clk, rst, yogurt, deb_yog);

endmodule
