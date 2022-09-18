`timescale 1 ns / 1 ns
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     Counter_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     test bench for Counter module
// Dependencies:    Counter
//
// Revision:        2.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Counter_tb();

    reg clk, init_regs, count_enabled, count_sample, show_sample, correct, loop_was_skipped;
    wire [7:0] time_reading;
    wire [3:0] tens_seconds_wire;
    wire [3:0] ones_seconds_wire;
   
    integer ts,os, sync;
    
    // Instantiate the UUT (Unit Under Test)
    // TODO
    Counter uut (clk, init_regs, count_enabled, count_sample, show_sample, time_reading);
    assign tens_seconds_wire = time_reading[7:4];
    assign ones_seconds_wire = time_reading[3:0];
  
    
    initial begin 
        #1
        sync = 0;
        count_sample = 0;
        show_sample = 0;
        correct = 1;
        loop_was_skipped = 1;
        clk = 1;
        init_regs = 1;
        count_enabled = 0;
	count_sample = 0; 
        show_sample = 0;
        #20
        init_regs = 0;
        count_enabled = 1;        
        // Remember that every 1000000 clocks are 10 milliseconds
        for( ts=0; ts<1; ts=ts+1 ) begin // not more than 1*10 seconds check
            for( os=0; os<2; os=os+1 ) begin // not more than 2*1 seconds check
                            #(999999999+sync) // FILL HERE THE "correct" signal MAINTENANCE 
                             correct = correct & (ts == tens_seconds_wire);
                             correct = correct & (os == ones_seconds_wire);
                            sync = sync | 1;
                            loop_was_skipped = 0;
           end
        end
        



        #5
        if (correct && ~loop_was_skipped)
            $display("Test Passed - %m");
        else
            $display("Test Failed - %m");
        $finish;
    end
    
    always #5 clk = ~clk;
endmodule
    
  