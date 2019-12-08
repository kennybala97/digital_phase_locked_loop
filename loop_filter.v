module loop_filter(clk, phase_error, dig_ctrl_voltage);

    parameter p_gain = 500;
    parameter i_gain = 100;

    // In out arguments

    input wire clk;
    input wire phase_error;
    output reg [19:0] dig_ctrl_voltage = 0;

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
            if(integral_sum == 1048576) begin
                integral_sum <= integral_sum;
            end else begin
                integral_sum <= integral_sum + i_gain;
            end
        end
    end

    always @(posedge clk) begin

        if (phase_error == 1) begin
            if(proportional_out + integral_sum > 1048576) begin
                dig_ctrl_voltage <= 1048576;
            end else begin
                dig_ctrl_voltage <= proportional_out + integral_sum;
            end
        end else begin
            dig_ctrl_voltage <= integral_sum;
            // if(integral_sum < proportional_out) begin
            //    dig_ctrl_voltage <= 0;
            ///end else begin
            //    dig_ctrl_voltage <= integral_sum - proportional_out;
            //end
        end
    end

endmodule