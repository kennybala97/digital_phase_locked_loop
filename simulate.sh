
rm gain_3000_150.csv
rm a.out
rm pll_full_model.vcd

iverilog -o a.out *.v
vvp a.out