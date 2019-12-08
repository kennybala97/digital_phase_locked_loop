iverilog -o a.out ff.v phase_detector.v loop_filter.v vco_model.v pll_full_model.v
vvp a.out