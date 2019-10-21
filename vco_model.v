`timescale 1ns / 1ps;

module vco_model(vco_dig_ctrl_voltage, clk_vco);
    input [12:0] vco_dig_ctrl_voltage;
    output reg clk_vco;
    
    parameter VCO_CTRL_VOLTAGE_MAX = 5;
    parameter VCO_GAIN = 2;    
    parameter VCO_Fo = 1.985;
    
    real vco_freq;
    real vco_analog_ctrl_voltage;
    real vco_period;
    
    always @(vco_dig_ctrl_voltage) begin
        vco_analog_ctrl_voltage = (vco_dig_ctrl_voltage[12:1]/4095)*VCO_CTRL_VOLTAGE_MAX;
        
        if (vco_dig_ctrl_voltage[0] == 0) begin
            vco_freq = VCO_Fo - vco_analog_ctrl_voltage*VCO_GAIN;
        end else begin
            vco_freq = VCO_Fo + vco_analog_ctrl_voltage*VCO_GAIN;
        end
    
        vco_period = 1/vco_freq;
    end
    
    initial vco_freq = VCO_Fo;
    initial vco_analog_ctrl_voltage = 0;
    initial clk_vco = 0;
    
    always #vco_period clk_vco = ~clk_vco;
endmodule