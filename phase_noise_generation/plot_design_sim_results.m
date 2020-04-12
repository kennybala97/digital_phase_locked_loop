clear all;
close all;
clc;

F0 = [0.75e9 0.75e9 0.75e9];
fmin=[1e1 1e1 1e1]; 
fmax=[1e5 1e5 1e5];
L1=[-100 -120];
f1=[1e4 1e5];
npoints=2.5e6;

sigma_l=sqrt(10^((-160)/10)/F0(1));
t_id=(1/F0(1))*(0:npoints-1);

j_1f3 = f_generate_1_f3_phn(F0(1), fmin(1), fmax(1), L1(1), f1(1), npoints);
j_1f2 = f_generate_1_f2_phn(F0(2), L1(2), f1(2), npoints);

t = t_id + j_1f2 + j_1f3;

[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t);

gain1 = readtable("../vco_pi_filter_test.csv");

[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_2,PHN_2] = f_extract_jitter_phn((gain1.Time(150000:end)')*1e-9);

figure;

subplot(311);

plot(gain1.Time, gain1.ControlVoltage);
grid on;
title('Loop Filter Control Voltage', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Voltage(V)', 'interpreter','latex');

subplot(312);

plot(gain1.Time, gain1.Frequency);
grid on;
title('VCO Frequency', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Frequency(GHz)', 'interpreter','latex');

subplot(313);

semilogx(fPHN, 10*log10(PHN));
hold on;
semilogx(fPHN_2, 10*log10(PHN_2));
grid on;
title('VCO Phase Noise', 'interpreter','latex');
xlabel('Frequency(Hz)', 'interpreter','latex');
ylabel('Phase Noise Power(dBc/Hz)', 'interpreter','latex');
legend('Free-Running VCO', 'PLL-Controlled VCO', 'interpreter','latex');

