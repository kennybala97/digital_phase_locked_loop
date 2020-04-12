
module vco_model(dig_ctrl_voltage, clk_vco);

    input wire [`DIG_CTRL_V_WIDTH - 1:0] dig_ctrl_voltage;
    output reg clk_vco = 0;

    integer write_data, read_phn, read_data;
    
    real phn_jitter = 0;

    parameter VCO_CTRL_VOLTAGE_INC = (`VCO_VMAX - `VCO_VMIN)/(2 ** `DIG_CTRL_V_WIDTH);

    // Initial conditions : Set VCO frequency to the base frequency, the
    // initial voltage to zero and the VCO period to a the base frequency, in
    // picoseconds

    real vco_freq = `VCO_F0;
    real vco_analog_ctrl_voltage = 0;
    real vco_period = 1/`VCO_F0;
    
    initial begin
        write_data = $fopen("vco_fir_filter_test3.csv");
        read_phn = $fopen("phase_noise_generation/phn.txt","r");
        $fdisplay(write_data, "Time,Control Voltage,Period,Frequency");
        print_info();
    end

    always @(clk_vco) begin
        if(!$feof(read_phn)) begin
            read_data = $fscanf(read_phn, "%f\n", phn_jitter);
            vco_period = 1/(`VCO_F0 + vco_analog_ctrl_voltage*`VCO_GAIN) + phn_jitter;
            vco_freq = 1/vco_period;
            $fdisplay(write_data, "%.20f,%.20f,%.20f,%.20f", $realtime, vco_analog_ctrl_voltage, vco_period, vco_freq);
        end
    end

    always @(dig_ctrl_voltage) begin
            vco_analog_ctrl_voltage = dig_ctrl_voltage*VCO_CTRL_VOLTAGE_INC;
    end

    always #vco_period clk_vco = ~clk_vco;

    task print_info;
    begin
        $display("Maximum Voltage %5.1f V", `VCO_VMAX);
        $display("Minimum Voltage %5.1f V", `VCO_VMIN);
        $display("The VCO Gain is %10.5f GHz/V", `VCO_GAIN);
        $display("The VCO Base Frequency is %10.5f GHz", `VCO_F0);
        $display("The VCO Max Frequency is %10.5f GHz", `VCO_FMAX);
        $display("The frequency increment is = %4.2e GHz/bit", `VCO_GAIN*VCO_CTRL_VOLTAGE_INC);
    end
    endtask

endmodule
