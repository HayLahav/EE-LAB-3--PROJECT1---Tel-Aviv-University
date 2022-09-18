`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:    11/12/2021 01:28AM
// Design Name:     EE3 lab1
// Module Name:     Stopwatch
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     Top module of the stopwatch circuit. Displays 2 independent 
//                  stopwatches on the 4 digits of the 7-segment component.
//                  Uses btnC as reset, btnU as trigger, and btnR as split button to
//                  control the currently selected stopwatch.
//                  Pressing btnL at any time - toggles the selection between the 
//                  left hand side (LHS) and the RHS stopwatches.
//                  The stopwatch's time reading is outputted using an, seg and dp signals
//                  that should be connected to the 4-digit-7-segment display and driven
//                  by 100MHz clock. 
// Dependencies:    Debouncer, Ctl, Counter, Seg_7_Display
//
// Revision:        3.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Stopwatch(clk, btnC, btnU, btnR, btnD, btnL,sw, seg, an, dp);

    input              clk, btnC, btnU, btnR, btnD, btnL,sw;
    output  wire [6:0] seg;
    output  wire [3:0] an;
    output  wire       dp; 
   

    wire [15:0] time_reading;
    wire trig, sample, set, toggle;
    wire reset_right,trig_right, sample_right, show_sample_right, init_regs_right, count_enabled_right;
    wire reset_left,trig_left, sample_left, show_sample_left, init_regs_left, count_enabled_left;
    reg selected_stopwatch;
    
    //mine
//      reg isSsetLeft,isSsetRight;

    

    Debouncer       Deb_btnC(clk, btnC, set); //set
    Debouncer       Deb_btnU(clk, btnU, trig); //trigger
    Debouncer       Deb_btnR(clk, btnR, sample); //sample
    Debouncer       Deb_btnL(clk, btnL, toggle); //toggle
    

    	always @(toggle) //choosing a stopwatch -> 0 = Right, 1 = Left
        begin
        if (toggle == 1'b1) //does the user clicked the switching screens button
               selected_stopwatch <= !selected_stopwatch; //change to left screen
        end
        
         //left stopwatch
           assign trig_left = selected_stopwatch? trig : 1'b0;
           assign sample_left =selected_stopwatch? sample : 1'b0;
           //right stopwatch
           assign trig_right = selected_stopwatch? 1'b0 : trig;
           assign sample_right = selected_stopwatch?  1'b0  : sample ;
        
        assign reset_right = (!(selected_stopwatch)&set)|sw;
        assign reset_left = (selected_stopwatch&set)|sw;

//     	always @(set) //choosing a stopwatch -> 0 = Right, 1 = Left
//       begin
//            if (set == 1'b1) //does the user clicked the switching screens button
//                if (selected_stopwatch == 1'b0) // the current screen is right
//                    begin
//                        isSsetRight <= !selected_stopwatch; //change to left screen
                        
//                    end
//                else // if we are at left screen
//                    begin
//                        isSsetLeft <= 1; //change to right screen
//                    end
//        end
//        assign reset_left = isSsetLeft|sw;
//        assign reset_right = isSsetRight|sw;


   
//right side
Ctl  Ctl_Right(clk, reset_right, trig_right, init_regs_right, count_enabled_right);
Counter  Counter_Right(clk, init_regs_right, count_enabled_right,sample_right,btnD, time_reading[7:0]);

//left side
Ctl  Ctl_left(clk, reset_left, trig_left, init_regs_left, count_enabled_left);
Counter  Counter_left(clk, init_regs_left, count_enabled_left,sample_left,btnD, time_reading[15:8]);

 //time_reading is the output of the counter and the input of the 7 seg display
 
Seg_7_Display   Seven_seg(time_reading, clk, reset_right|reset_left, seg, an, dp);
   
    


endmodule
