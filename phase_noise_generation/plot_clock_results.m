clear all;
close all;
clc;

tab = readtable('../clock_comparison.csv');
t = tab.DividedClock*1e-9;

[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t');

semilogx(fPHN, 10*log10(PHN));
