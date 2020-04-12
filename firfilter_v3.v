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


module firfilter_v3(input clk,input rst, input [19:0] x_in, 
input [7:0] multiplier, output reg [19:0] x_out
    );
    
  wire [10:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28;
  reg x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28;
  assign c0 = 14;
  assign c1 = 19;
  assign c2 = 23;
  assign c3 =24;
  assign c4 = 22;
  assign c5 = 16;
  assign c6 = 5;
  assign c7 = 11;
  assign c8 = 31;
  assign c9 = 54;
  assign c10 = 76;
  assign c11 = 97;
  assign c12 = 114;
  assign c13 = 125;
  assign c14 = 129;
  assign c15 = 125;
  assign c16 = 114;
  assign c17 = 97;
  assign c18 = 76;
  assign c19 = 54;
  assign c20 =31;
  assign c21 = 11;
  assign c22 = 5;
  assign c23 = 16; 
  assign c24 = 22;
  assign c25 = 24;
  assign c26 = 23;
  assign c27 = 19;
  assign c28 = 14;

  
  
  always @(posedge clk or negedge rst) begin 
    if (!rst) begin 
       x1 <=0; x2 <=0; x3 <=0; x4 <=0;
       x5 <=0; x6 <=0; x7 <=0; x8 <=0;
       x9 <=0; x10 <=0; x11 <=0;
       
       x12 <=0; x13 <=0; x14 <=0; x15 <=0;
       x16 <=0; x17 <=0; x18 <=0; x19 <=0;
       x20 <=0; x21 <=0; x22 <=0; x23 <=0; 
       x24 <=0; x25 <=0; x26 <=0; x27 <=0;
       x28 <=0; 
       x_out <=0; 
       
     end
     
    else begin 
    x1 <=x_in; x2 <=x1; x3 <=x2; x4 <=x3;
    x5 <=x4; x6 <=x5; x7 <=x6; x8 <=x7;
    x9 <=x8; x10 <= x9; x11 <=x10; x12 <=x11;
    x13 <=x12; x14 <=x13; x15 <=x14; x16 <=x15;
    x17 <=x16; x18 <=x17; x19 <=x18; x20 <=x19;
    x21 <=x20; x22 <=x21; x23 <= x22;
    x24 <=x23; x25 <=x24; x26 <= x25;
    x27 <=x26; x28 <=x27;  
    end
  
  end
  
  always @(*) begin 
  
   if(!rst) begin 
   x_out =0;
   end
  
  else begin
  x_out = (((-c0*x_in - c1*x1 - c2*x2 - c3*x3 - c4*x4 - c5*x5 - c6*x6 + c7*x7 + c8*x8 + c9*x9 + c10*x10 + c11*x11 + c12*x12 + c13*x13 + c14*x14 + 
  c15*x15 - c16*x16 - c17*x17 - c18*x18 - c19*x19  + c20*x20 + c21*x21 + c22*x22 + x23*c23 + x24*c24 + 
  x25*c25 + x26*c26 + x27*c27 + x28*c28))*multiplier);

 end
  
  end
  
  always @(*) begin 
  if (x_out > 200000)
  x_out = 0;
  end
  
    
endmodule
