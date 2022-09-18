`timescale 1ns/10ps
`define L 10
`define WIDTH 4
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 00:16 AM
// Design Name:     EE3 lab1
// Module Name:     Lim_Inc_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Limited incrementor test bench
// 
// Dependencies:    Lim_Inc
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Lim_Inc_tb();

    reg [3:0] a; 
    reg ci, correct, loop_was_skipped;
    wire [3:0] sum;
    wire co;
    
    integer ai,cii;
    
    // Instantiate the UUT (Unit Under Test)
    Lim_Inc #(`L) uut (a, ci, sum, co);
	//FILL HERE
    
    initial begin
        correct = 1;
        loop_was_skipped = 1;
        #1
        for( ai=0; ai<2**`WIDTH; ai=ai+1) begin
            for( cii=0; cii<=1; cii=cii+1 ) begin
                // FILL HERE :   a=...   b=....  
                a = ai; ci = cii;  
                #5 
                // FILL HERE :  correct = ....
                correct = correct & (a+ci<`L ? (co == 0 & sum == a+ci) : (co == 1 & sum == 0));
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
endmodule


