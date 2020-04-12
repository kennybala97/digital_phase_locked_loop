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

gain1 = readtable("../vco_gain_1_1.csv");
gain2 = readtable("../vco_gain_10_1.csv");
gain3 = readtable("../vco_gain_1_10.csv");
gain4 = readtable("../vco_gain_40_1.csv");


[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_2,PHN_2] = f_extract_jitter_phn((gain1.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_3,PHN_3] = f_extract_jitter_phn((gain2.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_4,PHN_4] = f_extract_jitter_phn((gain3.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_5,PHN_5] = f_extract_jitter_phn((gain4.Time(150000:end)')*1e-9);

figure;

subplot(311);

plot(gain3.Time, gain3.ControlVoltage);
hold on;
plot(gain1.Time, gain1.ControlVoltage);
hold on;
plot(gain4.Time, gain4.ControlVoltage);
hold on;
plot(gain2.Time, gain2.ControlVoltage);
grid on;
title('Loop Filter Control Voltage  vs. $K_p:K_i$ : Loop Stability Results', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Voltage(V)', 'interpreter','latex');
legend('1:10','1:1', '40:1', '10:1', 'interpreter','latex')

subplot(312);

plot(gain3.Time, gain3.Frequency);
hold on;
plot(gain1.Time, gain1.Frequency);
hold on;
plot(gain4.Time, gain4.Frequency);
hold on;
plot(gain2.Time, gain2.Frequency);
grid on;
title('VCO Frequency vs. $K_p:K_i$ : Loop Stability Results', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Frequency(GHz)', 'interpreter','latex');
legend('1:10','1:1', '40:1', '10:1', 'interpreter','latex')

subplot(313);

semilogx(fPHN, 10*log10(PHN));
hold on;
semilogx(fPHN_2, 10*log10(PHN_2));
hold on;
semilogx(fPHN_3, 10*log10(PHN_3));
hold on;
semilogx(fPHN_4, 10*log10(PHN_4));
hold on;
semilogx(fPHN_5, 10*log10(PHN_5));
grid on;
title('VCO Phase Noise vs. $K_p:K_i$ : Loop Stability Results', 'interpreter','latex');
xlabel('Frequency(Hz)', 'interpreter','latex');
ylabel('Phase Noise Power(dBc/Hz)', 'interpreter','latex');
legend('Free-Running VCO', '1:1', '10:1', '1:10', '40:1', 'interpreter','latex')

