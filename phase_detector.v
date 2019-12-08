module phase_detector(f_ref, f_div, rst, dir);

    // The inputs

    input f_ref;  // The reference clock signal
    input f_div;  // The divided VCO signal
    input rst;  // A signal to reset the phase detection
    output dir; // Phase error output
    
    // flip-flops generating U and D

    wire U, D, CD;

    ff feed_back(1'b1,CD,f_ref,U);
    ff reference(1'b1,CD,f_div,D);

    assign CD = ~(~rst || (U && D));

    // logic to generate up and dn

    wire up, dn;

    assign up = (U && ~D); 
    assign dn = (~U && D);

    // logic to generate dir output

    wire dir_1, dir_2;

    nor (dir_1, up, dir_2);
    nor (dir_2, dn, dir_1); 

    assign dir = dir_2;
endmodule