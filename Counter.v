`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:   Hay Lahav     
// 
// Create Date:     11/12/2021 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     Counter
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     A counter that advances its reading as long as time_reading 
//                  signal is high and zeroes its reading upon init_regs=1 input.
//                  the time_reading output represents: 
//                  {dekaseconds,seconds}
// Dependencies:    Lim_Inc
//
// Revision:        2.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Counter(clk, init_regs, count_enabled, count_sample, show_sample, time_reading);

   parameter CLK_FREQ = 100000000;// in Hz
   
   input clk, init_regs, count_enabled, count_sample, show_sample;
   output [7:0] time_reading;

   reg [$clog2(CLK_FREQ)-1:0] clk_cnt;
   reg [3:0] ones_seconds;    
   reg [3:0] tens_seconds;
   
   reg [7:0] sampled_count;
   reg [$clog2(CLK_FREQ)-1:0] module_cnt;      
   reg [7:0] time_res;
  
   // FILL HERE THE LIMITED-COUNTER INSTANCES
   wire[3:0] wires_port_ones;
   wire co_ones;
   wire[3:0] wires_port_tens;
   wire co_tens; 
   Lim_Inc sec(ones_seconds, count_enabled,wires_port_ones,co_ones);
   Lim_Inc dasec(tens_seconds, co_ones,wires_port_tens,co_tens);
   //------------- Synchronous ----------------
   always @(posedge clk)
     begin
		// FILL HERE THE ADVANCING OF THE REGISTERS AS A FUNCTION OF init_regs, count_enabled
		if (init_regs == 1)
		 begin
           clk_cnt <= 0;
           module_cnt <= 0;
           ones_seconds <= 0;
           tens_seconds <= 0;
         end
         
         
           
        if (count_sample == 0)
             begin
             end
             
        if (count_sample == 1)
             begin
             sampled_count = {tens_seconds, ones_seconds};
             end               
        else
                              
           if (show_sample == 0)
             begin
             time_res = {tens_seconds, ones_seconds};
             end
             
         else if (show_sample == 1)
             begin
             time_res = sampled_count;
             end
             
           if (count_enabled == 1) 
             begin
             module_cnt <= module_cnt +1;
             clk_cnt <= clk_cnt + 1;
             end
             
           if (module_cnt == CLK_FREQ)
              begin
              ones_seconds<= wires_port_ones;
              tens_seconds<= wires_port_tens;
              module_cnt <= 0;
              end            
           if (clk_cnt ==(CLK_FREQ)) 
             begin
             clk_cnt <= 0;
             end
           
          end      
          assign time_reading = time_res;
      endmodule
          