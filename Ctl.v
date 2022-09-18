`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     Ctl
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     Control module that receives reset,trig and split inputs from the buttons
//                  outpputs the init_regs and count_enabled level signals that should govern the 
//                  operation of the Counter module.
// Dependencies:    None
//
// Revision:        2.0
// Revision         2.1 - Fall 2018 - changed parameter to localparam
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Ctl(clk, reset, trig, init_regs, count_enabled);
   
   input clk, reset, trig;
   output init_regs, count_enabled;
   
   //-------------Internal Constants--------------------------
   localparam SIZE = 3;
   localparam IDLE  = 3'b001, COUNTING = 3'b010, PAUSED = 3'b100 ;
   reg [SIZE-1:0] 	  state;

   //-------------Transition Function (Delta) ----------------
   always @(posedge clk)
     begin
        if (reset)
          state <= IDLE;
        else
          // FILL HERE STATE TRANSITIONS
           begin
                     case (state)
                         IDLE:
                             if (trig)
                                 state <= COUNTING;
                             else
                                 state <= IDLE;
                         COUNTING:
                             if (trig)
                                 state <= PAUSED;
                             else
                                 state <= COUNTING;
                         PAUSED:
                             if (trig)
                                 state <= COUNTING;
                             else if(init_regs)     
                                 state <= IDLE;
                             else
                                 state <= PAUSED;
                         default:
                             state <= IDLE;
                     endcase
                   end
     end
     
   //-------------Output Function (Lambda) ----------------
	 assign init_regs     = (state==IDLE);// FILL HERE
	 assign count_enabled =(state==COUNTING); // FILL HERE
	 

endmodule
