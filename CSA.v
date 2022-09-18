`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     11/12/2021 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     CSA
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Variable length binary adder. The parameter N determines
//                  the bit width of the operands. Implemented according to 
//                  Conditional Sum Adder.
// 
// Dependencies:    FA
// 
// Revision:        2.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module CSA(a, b, ci, sum, co);

    parameter N=4;
    parameter K = N >> 1;
    
    input [N-1:0] a;
    input [N-1:0] b;
    input ci;
    output [N-1:0] sum;
    output co;
    
    wire [N-1:0] sum;
    wire co, co_2, co_3;
    wire select;
    wire [(N-K)-1:0] sum_2;
    wire [(N-K)-1:0] sum_3;
    generate
       if (N == 1) 
          FA FA(a, b, ci, sum, co);
       else
       begin
          CSA #(K) myCSA_1(a[K-1:0], b[K-1:0], ci, sum[K-1:0], select);
    
          CSA #(N-K) myCSA_2(a[N-1:K], b[N-1:K], 0, sum_2[(N-K)-1:0], co_2);
          CSA #(N-K) myCSA_3(a[N-1:K], b[N-1:K], 1, sum_3[(N-K)-1:0], co_3);
       
          assign sum[N-1:K] = select ? sum_3[(N-K)-1:0] : sum_2[(N-K)-1:0];
          assign co = select ? co_3 : co_2;
       end
    endgenerate
endmodule
