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
