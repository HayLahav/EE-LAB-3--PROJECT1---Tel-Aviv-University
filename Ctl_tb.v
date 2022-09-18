`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     Ctl_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     test bennch for the control.
// Dependencies:    None
//
// Revision:        2.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Ctl_tb();

    reg clk, reset, trig, correct;
    wire init_regs, count_enabled;
    // Define more wires/regs/integers if necessary
    
    // Instantiate the UUT (Unit Under Test)
    Ctl uut(clk, reset, trig, init_regs, count_enabled);
    // FILL HERE
    
    initial begin
        correct = 1;
        clk = 0; 
        reset = 1; 
        trig = 0;
     #10
           reset = 0; 
           correct = correct & init_regs & ~count_enabled;
           // idle -> idle 00
           #20
           #2 
           trig =1; 
           #5 
           correct = correct & ~init_regs & count_enabled ;
           // idle -> counting 01
           #5 
           trig = 0; 
           #5 
           correct = correct & ~init_regs & count_enabled ;
           //  counting ->  counting 00 
           
            #5 
             reset=1; 
             #5 
             correct = correct & init_regs & ~count_enabled;
             //counting -> idle 11
           
             #5
             reset = 0; 
             trig = 1; 
             #5 
             correct = correct & ~init_regs & count_enabled ;
             //  idle ->  counting 01 
           
           
           #5 
           trig = 1; 
           #5 
           correct = correct & ~init_regs & ~count_enabled;
            //   counting -> pause 01 
           #5 
           trig = 0;   
           #5 
           correct = correct & ~init_regs & ~count_enabled;
           //pause -> pause 00
           #5 
           reset = 1; 
           #5
           correct = correct & init_regs & ~count_enabled;
           // pause -> idle 10
           #5  
           reset = 0;  
           trig = 1; 
           #5 
           correct = correct & ~init_regs & count_enabled;
           // idle -> counting 01 
           #10
           correct = correct & ~init_regs & ~count_enabled;
           //counting -> pause 01
           #10  
           correct = correct & ~init_regs & count_enabled;
           //pause -> counting 01
           #10
           correct = correct & ~init_regs & ~count_enabled;
           //counting -> pause 01
           #5 
           reset=1; 
           #5 
           correct = correct & init_regs & ~count_enabled;
           //idle -> idle 11
           #5 
           #5 
           trig=0; 
           #5 
           correct = correct & init_regs & ~count_enabled;
           //idle -> idle 10
           //#5
           //trig =1; 
           //reset = 0;
           //#5 
           //correct = correct & ~init_regs & count_enabled ;
           // idle -> counting 01
           //#5
            //reset = 1;
           // #5 
         //   correct = correct & ~init_regs & count_enabled ;
            // counting -> idle 10
        if (correct)
            $display("Test Passed - %m");
        else
            $display("Test Failed - %m");
        $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule
