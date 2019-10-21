`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2019 10:54:05 AM
// Design Name: 
// Module Name: phase_detector
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

// module phase_detector(input rst, input fref, input fdiv, output dir);
module phase_detector();

// The inputs

reg master;
wire f_ref;  // The reference clock signal
wire f_div;  // The divided VCO signal
reg rst;  // A signal to reset the phase detection

// flip-flops generating U and D

wire U, D, CD;

assign CD = ~(~rst || (U && D));

ff feed_back(1'b1,CD,f_ref,U);
ff reference(1'b1,CD,f_div,D);

// logic to generate up and dn

wire up, dn;

assign up = (U && ~D); 
assign dn = (~U && D);

// logic to generate dir output

wire dir_1, dir_2, dir;

nor (dir_1, up, dir_2);
nor (dir_2, dn, dir_1); 

assign dir = dir_2;


//// The TB Part of the Module ////

// Generate the clocks

integer variable_delay_ref, variable_delay_div;

initial rst = 1;
initial master = 0;
initial variable_delay_ref = 0;
initial variable_delay_div = 0;

always #10 master = ~master;

assign #variable_delay_ref f_ref = master;
assign #variable_delay_div f_div = master;

initial begin
    #50 variable_delay_div = 1;
    #50 variable_delay_div = 2;
    #50 variable_delay_div = 3;
    #50 variable_delay_div = 0;
    #50 variable_delay_ref = 1;
    #50 variable_delay_ref = 2;
    #50 variable_delay_ref = 3;
    $finish;
end

endmodule
