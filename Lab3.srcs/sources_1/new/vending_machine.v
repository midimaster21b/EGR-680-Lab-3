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
`define reset              4'b0000;

// Only money input
`define five_cents         4'b0001;
`define ten_cents          4'b0010;
`define fifteen_cents      4'b0011;
`define twenty_cents       4'b0100;

// 10 cents dispense states
`define dispense_gum_10    4'b0101;

// 15 cents dispense states
`define dispense_gum_15    4'b0110;
`define dispense_apple_15  4'b0110;

// 20 cents dispense states
`define dispense_gum_20    4'b0111;
`define dispense_apple_20  4'b1000;
`define dispense_yogurt_20 4'b1001;


module vending_machine(
    input clk,
    input rst,
    input nickel,
    input dime,
    input gum,
    input apple,
    input yogurt,
    output [3:0] dispensed_item,
    output [3:0] change
    );
endmodule
