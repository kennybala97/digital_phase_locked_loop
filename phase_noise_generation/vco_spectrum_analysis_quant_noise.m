clear all;
close all;
clc;

gain1 = readtable("../vco_lf_12bit.csv");
gain2 = readtable("../vco_lf_14bit.csv");
gain3 = readtable("../vco_lf_16bit.csv");
gain4 = readtable("../vco_lf_20bit.csv");

figure;

subplot(221);

plot(gain1.Time, gain1.ControlVoltage);
hold on;
plot(gain2.Time, gain2.ControlVoltage);
hold on;
plot(gain3.Time, gain3.ControlVoltage);
hold on;
plot(gain4.Time, gain4.ControlVoltage);
grid on;
title('Loop Filter Control Voltage Quantization Noise vs. Bit Width', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Voltage(V)', 'interpreter','latex');
legend('12 bits', '14 bits', '16 bits', '20 bits','interpreter','latex');

subplot(222);

plot(gain1.Time, gain1.Frequency);
hold on;
plot(gain2.Time, gain2.Frequency);
hold on;
plot(gain3.Time, gain3.Frequency);
hold on;
plot(gain4.Time, gain4.Frequency);
grid on;
title('VCO Frequency vs. Loop Filter Bit Width', 'interpreter','latex');
xlabel('Time(ns)', 'interpreter','latex');
ylabel('Frequency(GHz)', 'interpreter','latex');
legend('12 bits', '14 bits', '16 bits', '20 bits','interpreter','latex');

[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_2,PHN_2] = f_extract_jitter_phn((gain1.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_3,PHN_3] = f_extract_jitter_phn((gain2.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_4,PHN_4] = f_extract_jitter_phn((gain3.Time(150000:end)')*1e-9);
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN_5,PHN_5] = f_extract_jitter_phn((gain4.Time(300000:end)')*1e-9);

subplot(223);

semilogx(fPHN_2, 10*log10(PHN_2));
hold on;
semilogx(fPHN_3, 10*log10(PHN_3));
hold on;
semilogx(fPHN_4, 10*log10(PHN_4));
hold on;
semilogx(fPHN_5, 10*log10(PHN_5));
grid on;
title('VCO Phase Noise As a Function of Loop Filter Bit Width', 'interpreter','latex');
xlabel('Frequency(Hz)', 'interpreter','latex');
ylabel('Phase Noise Power(dBc/Hz)', 'interpreter','latex');
legend('12 bits', '14 bits', '16 bits', '20 bits','interpreter','latex');


subplot(224);

[pxx1,f1] = plomb(gain1.ControlVoltage(200000:end),gain1.Time(200000:end)*1e-9);
[pxx2,f2] = plomb(gain2.ControlVoltage(200000:end),gain2.Time(200000:end)*1e-9);
[pxx3,f3] = plomb(gain3.ControlVoltage(200000:end),gain3.Time(200000:end)*1e-9);
[pxx4,f4] = plomb(gain4.ControlVoltage(200000:end),gain4.Time(200000:end)*1e-9);

loglog(10*log10(pxx1));
hold on;
loglog(10*log10(pxx2));
loglog(10*log10(pxx3));
loglog(10*log10(pxx4));
grid on;

title('$V_c(s)$ vs. Loop Filter Bit Width', 'interpreter','latex');
xlabel('Frequency(Hz)', 'interpreter','latex');
ylabel('Power Spectral Density(dB)', 'interpreter','latex');
legend('12 bits', '14 bits', '16 bits', '20 bits','interpreter','latex');