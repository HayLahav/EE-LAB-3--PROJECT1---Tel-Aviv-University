`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 00:16 AM
// Design Name:     EE3 lab1
// Module Name:     Lim_Inc
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Incrementor modulo L, where the input a is *saturated* at L 
//                  If a+ci>L, then the output will be s=0,co=1 anyway.
// 
// Dependencies:    CSA
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Lim_Inc(a, ci, sum, co);
    
    parameter L = 10;
    parameter N =$clog2(L) /* FILL HERE */;
    
    input [N-1:0] a;
    input ci;
    output [N-1:0] sum;
    output co;

    // FILL HERE
    wire [N-1:0] b;
           wire [N-1:0] summation_csa;
           wire [N:0] outcome;
           assign b=0;
           CSA #(N) addlim(a,b,ci,summation_csa,csa_output);
           assign outcome [N-1:0]=summation_csa;
           assign outcome[N]=csa_output;
           assign sum = (outcome >= L) ? 0 : outcome[N-1:0];
           assign co = (outcome >= L) ? 1 : 0;
           
endmodule

