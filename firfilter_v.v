`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 10:18:38 PM
// Design Name: 
// Module Name: firfilter_v
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


module firfilter_v(input clk,input rst, input x_in, 
input [7:0] multiplier, output reg [19:0] x_out
    );
    
  wire [10:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11; 
  reg x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11; 
   
   assign c0 = 251;
  assign c1 = 194;
  assign c2 = 106;
  assign c3 = 21;
  assign c4 = 33;
  assign c5 = 49;
  assign c6 = 37;
  assign c7 = 16;
  assign c8 =10;
  assign c9 = 8;
  assign c10 = 7;
  assign c11 = 3; 
  
  always @(posedge clk or negedge rst) begin 
    if (!rst) begin 
       x1 <=0; x2 <=0; x3 <=0; x4 <=0;
       x5 <=0; x6 <=0; x7 <=0; x8 <=0;
       x9 <=0; x10 <=0; x11 <=0;
       x_out <=0; 
     end
     
    else begin 
    x1 <=x_in; x2 <=x1; x3 <=x2; x4 <=x3;
           x5 <=x4; x6 <=x5; x7 <=x6; x8 <=x7;
           x9 <=x8; x10 <=x9; x11 <=x10;
    end
  
  end
  
  always @(*) begin 
  
  if (!rst) begin 
  
  x_out = 0; 
  end 
  
  else
  x_out = (c0*x_in + c1*x1 + c2*x2 + c3*x3 - c4*x4 - c5*x5 - c6*x6 - c7*x7 + c8*x8 + c9*x9 + c10*x10)*multiplier;
  
  
  end
  
    
endmodule
