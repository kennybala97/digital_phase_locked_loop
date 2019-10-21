`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2019 10:49:43 AM
// Design Name: 
// Module Name: ff
// Project Name: 
// Target Devices: 
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


module ff
( input D,input cdn, input clk, output reg Q);
 
  always @ (posedge clk or negedge cdn) 
       if (!cdn)
          Q <= 0;
       else
          Q <= D;
endmodule
