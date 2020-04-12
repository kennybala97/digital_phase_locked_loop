module loop_filter(clk,
                   phase_error,
                   dig_ctrl_voltage,
                   dig_ctrl_voltage_smoothed);

    parameter p_gain = 500;
    parameter i_gain = 100;
    parameter width = 20;

    integer MAX_VAL = 2**(width);

    // In out arguments

    input wire clk;
    input wire phase_error;

    output reg [width - 1:0] dig_ctrl_voltage = 0;
    output wire [width - 1:0] dig_ctrl_voltage_smoothed;

    median_filter #(width)DUT(.ctrl_in(dig_ctrl_voltage),
                              .ctrl_out(dig_ctrl_voltage_smoothed));

    reg [31:0] proportional_out = 0;
    reg [31:0] integral_sum = 0;

    // Proportional path

    always @(posedge clk) begin
        proportional_out <= p_gain;
    end

    // Integral path

    always @(posedge clk) begin
        if(phase_error == 0) begin
            if (integral_sum > i_gain) begin
                integral_sum <= integral_sum - i_gain;
            end else begin
                integral_sum <=  integral_sum;
            end
        end else begin
            if(integral_sum == MAX_VAL) begin
                integral_sum <= integral_sum;
            end else begin
                integral_sum <= integral_sum + i_gain;
            end
        end
    end

    always @(posedge clk) begin
        if (phase_error == 1) begin
            if(proportional_out + integral_sum > MAX_VAL) begin
                dig_ctrl_voltage <= MAX_VAL;
            end else begin
                dig_ctrl_voltage <= proportional_out + integral_sum;
            end
        end else begin
            dig_ctrl_voltage <= integral_sum;
        end
    end



endmodule

module median_filter(ctrl_in, ctrl_out);
    parameter width = 20;

    input [width - 1: 0] ctrl_in;
    output reg [width - 1:0] ctrl_out = 0;

    reg [width - 1:0] samp_1 = 0;
    reg [width - 1:0] samp_2 = 0;
    reg [width - 1:0] samp_3 = 0;
    reg [width - 1:0] samp_4 = 0;

    always @(ctrl_in) begin
        samp_4 = samp_3;
        samp_3 = samp_2;
        samp_2 = samp_1;
        samp_1 = ctrl_in;

        ctrl_out = (samp_1 + samp_2 + samp_3 + samp_4 )/4;
    end

endmodule