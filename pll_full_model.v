`timescale 1ns / 1fs

`define GLOBAL_TIMESCALE = 1e9

`define DIG_CTRL_V_WIDTH  12

`define P_GAIN 20
`define I_GAIN 1

`define DIVIDER_WIDTH 8
`define DIVIDER_N 4

// The maximum and minimum voltages the VCO will accept

`define VCO_VMAX 5
`define VCO_VMIN 0.0

// The VCO gain is 47MHz per volt

`define VCO_GAIN 0.06

// The VCO base frequency

`define VCO_F0 0.75

// The VCO maximum frequency

`define VCO_FMAX 1

module pll_full_model();

    real ref_freq = 0.99/((`VCO_F0/(2*`DIVIDER_N)));

    reg clk_master;
    wire clk_vco;    
    
    // Arguments for the phase detector

    reg rst;
    wire f_ref;
    wire f_div;
    wire dir;

    // Instantiate PD DUT

    assign f_ref = clk_master;
    // assign f_div = clk_vco;

    phase_detector DUT_pd(.f_ref(f_ref), .f_div(f_div), .rst(rst), .dir(dir));

    // Arguments for the loop filter
    
    wire clk;
    wire phase_error;
    wire [`DIG_CTRL_V_WIDTH - 1:0] dig_ctrl_voltage;
    wire [`DIG_CTRL_V_WIDTH - 1:0] dig_ctrl_voltage_smoothed;

    // Instantiate LF DUT

    assign clk = clk_master;
    assign phase_error = dir;

    reg[7:0] multiplier = 40;

    /*firfilter_v3 DUT(.clk(clk),
                    .rst(rst),
                    .x_in(phase_error),
                    .multiplier(multiplier),
                    .x_out(dig_ctrl_voltage));*/

    loop_filter #(`P_GAIN, `I_GAIN, `DIG_CTRL_V_WIDTH) DUT_Lf(.clk(clk),
        .phase_error(phase_error),
        .dig_ctrl_voltage(dig_ctrl_voltage),
        .dig_ctrl_voltage_smoothed(dig_ctrl_voltage_smoothed));

    /*pi_filter DUT(.rst(rst), 
                  .x(phase_error),
                  .clk(clk),
                  .dac(dig_ctrl_voltage));*/






    // Instantiate VCO DUT

    vco_model DUT_vco(.dig_ctrl_voltage(dig_ctrl_voltage_smoothed), .clk_vco(clk_vco));


    clock_divider #(`DIVIDER_WIDTH, `DIVIDER_N) DUT_clk_div(.clk(clk_vco),.reset(rst),.clk_out(f_div));

    initial clk_master = 0;
    initial rst = 1;

    always #ref_freq clk_master = ~clk_master;

    integer write_clock;

    initial begin
        write_clock = $fopen("clock_comparison.csv");

        $fdisplay(write_clock, "Divided Clock");

        $dumpfile("pll_full_model.vcd");
        $dumpvars(0, pll_full_model);
        #1000000 $finish;
    end

    always @(f_div) begin
        $fdisplay(write_clock, "%.20f",$realtime);
    end

endmodule
