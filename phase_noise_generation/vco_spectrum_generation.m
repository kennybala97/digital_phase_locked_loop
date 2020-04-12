clear all;
close all;
clc;

F0 = [0.5e9 0.5e9 0.5e9];
fmin=[1e3 1e3 1e3]; 
fmax=[1e7 1e7 1e7];
L1=[-80 -127];
f1=[1e3 1e5];
npoints=1e8;

sigma_l=sqrt(10^((-160)/10)/F0(1));
t_id=(1/F0(1))*(0:npoints-1);

j_1f3 = f_generate_1_f3_phn(F0(1), fmin(1), fmax(1), L1(1), f1(1), npoints);
j_1f2 = f_generate_1_f2_phn(F0(2), L1(2), f1(2), npoints);
% j_1f = f_generate_1_f_phn(F0(3), fmin(3), fmax(3), L1(3), f1(3), npoints);
% j_flat=sigma_l*randn(1,npoints);

% t = t_id + j_1f + j_1f2 + j_1f3 + j_flat;
t = t_id + j_1f2 + j_1f3;
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t);


semilogx(fPHN, 10*log10(PHN));
grid on;
title('VCO Phase Noise', 'interpreter','latex');
xlabel('Frequency(Hz)', 'interpreter','latex');
ylabel('Phase Noise Power(dBc/Hz)', 'interpreter','latex');


jittered = ((t - t_id)')*1e9;
fnm = 'phn.txt';
fid = fopen(fnm,'wt');
fprintf(fid,'%.12f\n',jittered);
fclose(fid);
