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
endmodule
