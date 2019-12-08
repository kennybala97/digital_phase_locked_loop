module vco_model(dig_ctrl_voltage, clk_vco);
    input wire [19:0] dig_ctrl_voltage;
    output reg clk_vco = 0;
    parameter VCO_CTRL_VOLTAGE_INC = 0.0000047684;
    parameter VCO_GAIN = 0.024;    
    parameter VCO_Fo = 0.095;
    
    integer write_data;

    real vco_freq = VCO_Fo;
    real vco_analog_ctrl_voltage = 0;
    real vco_period = 1/VCO_Fo;
    
    initial begin
        write_data = $fopen("/mnt/c/Users/kenny_h7nqsfc/Documents/gain_3000_150.csv");
    end

    always @(dig_ctrl_voltage) begin
        vco_analog_ctrl_voltage = dig_ctrl_voltage*VCO_CTRL_VOLTAGE_INC;
        vco_freq = VCO_Fo + vco_analog_ctrl_voltage*VCO_GAIN;
        vco_period = 1/vco_freq;
        $fdisplay(write_data, "%f,%f", vco_analog_ctrl_voltage, vco_period);
    end
    
    always #vco_period clk_vco = ~clk_vco;

endmodule