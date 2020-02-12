clear all;
close all;
clc;

F0 = [1.985e9 1.985e9 1.985e9];
fmin=[1e3 1e3 1e3]; 
fmax=[1e8 1e8 1e8];
L1=[-164 -136 -122];
f1=[1e7 1e6 1e5];
npoints=1e8;

sigma_l=sqrt(10^((-170)/10)/1e9);
t_id=1/F0(1)*(0:npoints-1);
j_flat=sigma_l*randn(1,npoints);

j_1f = f_generate_1_f_phn(F0(1), fmin(1), fmax(1), L1(1), f1(1), npoints);
j_1f2 = f_generate_1_f2_phn(F0(2), L1(2), f1(2), npoints);
j_1f3 = f_generate_1_f3_phn(F0(3), fmin(3), fmax(3), L1(3), f1(3), npoints);

t = t_id + j_1f + j_1f2 + j_1f3 + j_flat;
jittered = j_1f + j_1f2 + j_1f3 + j_flat;

[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t);

figure(4);
semilogx(fPHN, 10*log10(PHN));
grid on;
title('Simulated VCO Phase Noise');
xlabel('Frequency(Hz)');
ylabel('Phase Noise Power(dBc/Hz)');

