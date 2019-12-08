`timescale 1ns / 1ps

module pll_full_model();

    reg clk_master;
    wire clk_vco;    

    // Arguments for the phase detector

    reg rst;
    wire f_ref;
    wire f_div;
    wire dir;

    // Instantiate PD DUT
    
    assign f_ref = clk_master;
    assign f_div = clk_vco;

    phase_detector DUT_pd(.f_ref(f_ref), .f_div(f_div), .rst(rst), .dir(dir));

    // Arguments for the loop filter
    
    wire clk;
    wire phase_error;
    wire [19:0] dig_ctrl_voltage;
    // Instantiate LF DUT

    assign clk = clk_master;
    assign phase_error = dir;

    loop_filter #(3000,150) DUT_Lf(.clk(clk), .phase_error(phase_error), .dig_ctrl_voltage(dig_ctrl_voltage));

    // Instantiate VCO DUT

    vco_model DUT_vco(.dig_ctrl_voltage(dig_ctrl_voltage), .clk_vco(clk_vco));
    
    initial clk_master = 0;
    initial rst = 1;

    always #10 clk_master = ~clk_master;

    initial begin
        $dumpfile("pll_full_model.vcd");
        $dumpvars(0, pll_full_model);
        #100000 $finish;
    end

endmodule