%% initialization
clc;
clear all;
figure(6);
hold off;
F0=14e9;
npoints=40e5;
fmin=1e3;
fmax=1e9;
ymin=-160;
ymax=0;
% L1_flicker=-45;
L1_flicker=-75;
f1_flicker=1e5;
L1_white=-105;
% L1_white=-200;
f1_white= 1e6;
L0_pll=-200;
f3dB_pll=100e6;
L0_flat=-143;
%% generate spectrum
t_id=1/F0*(0:npoints-1);
gamma=abs(sqrt(10)/(1+j*10)+1/(1+j)+sqrt(10)/(10+j))^2;
sigma_l_flicker=sqrt(10^(L1_flicker/10)*f1_flicker^3/(F0^3*fmin*gamma));
l_flicker=sigma_l_flicker*randn(1,npoints);
fcorner=logspace(log10(fmin),log10(fmax),8);
[B1,A1] = butter(1,2*fcorner(1)/F0);
[B2,A2] = butter(1,2*fcorner(2)/F0);
[B3,A3] = butter(1,2*fcorner(3)/F0);
[B4,A4] = butter(1,2*fcorner(4)/F0);
[B5,A5] = butter(1,2*fcorner(5)/F0);
[B6,A6] = butter(1,2*fcorner(6)/F0);
[B7,A7] = butter(1,2*fcorner(7)/F0);
[B8,A8] = butter(1,2*fcorner(8)/F0);
l1_filtered=filter(B1,A1,l_flicker);
l2_filtered=filter(B2,A2,l_flicker/sqrt(10));
l3_filtered=filter(B3,A3,l_flicker/sqrt(10)^2);
l4_filtered=filter(B4,A4,l_flicker/sqrt(10)^3);
l5_filtered=filter(B5,A5,l_flicker/sqrt(10)^4);
l6_filtered=filter(B6,A6,l_flicker/sqrt(10)^5);
l7_filtered=filter(B7,A7,l_flicker/sqrt(10)^6);
l8_filtered=filter(B8,A8,l_flicker/sqrt(10)^7);
j1_flicker=l1_filtered+l2_filtered+l3_filtered+l4_filtered+...
l5_filtered+l6_filtered+l7_filtered+l8_filtered;
j_flicker=cumsum(j1_flicker);
sigma_l_white=(f1_white/F0)*sqrt(10^(L1_white/10)/F0);
l_white=sigma_l_white*randn(1,npoints);
j_white=cumsum(l_white);
sigma_l_pll=sqrt(10^(L0_pll/10)/F0)/(2*pi);
l_pll=sigma_l_pll*randn(1,npoints);
[B,A] = butter(1,2*f3dB_pll/F0);
j_pll=filter(B,A,l_pll);
sigma_j_flat=1/(2*pi)*sqrt(10^(L0_flat/10)/F0);
j_flat=sigma_j_flat*randn(1,npoints);
j=j_flicker+j_white+j_pll+j_flat;
t=t_id+j;
% t=t_id+j_flicker+j_white+j_pll+j_flat;
%% save data
jcsvFile = fopen('jitter_data.csv','w');
jtxtFile = fopen('jitter_data.txt','w');
% for i=1:npoints
%     fprintf(jFile,'%20.19f\n',t(i));
% %     fprintf(jFile,'%20.19f,%20.19f\n',t(i),t(i));
% end
% dlmwrite('jitter_data.txt',j, 'delimiter',' ');
fprintf(jcsvFile,'%16.15f\n',t);
fprintf(jtxtFile,'%d ',diff(int64(j*1e15)));  % convert to fs
fclose(jcsvFile);
fclose(jtxtFile);
%% plot spectrum dadalt
[F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t);
semilogx(fPHN,10*log10(PHN),'k');
axis([fmin fmax ymin ymax]);
yticks([-150 -140 -130 -120 -110 -100 -90 -80 -70 ...
    -60 -50 -40 -30 -20 -10 0])
grid on;
hold on;
xlabel('Offset Frequency [Hz]');
ylabel('Phase Noise [dBc/Hz]');

%% plot spectrum pwelch
%figure(2)
Ts = 1/F0; 
% x = j;
x = 1e-9./(Ts+j);
% x = j*5e10;
% x = j*7.5e9; % tukey window
x = x - mean(x); 
plotOrder = [1];
num_segments = 10;
window_length = floor(length(x)/num_segments);
[Pxx,f] = pwelch(x,window_length,[],[],1/Ts,'onesided');
% [Pxx,f] = pwelch(x,hamming(window_length),[],[],1/Ts,'onesided');
% [Pxx,f] = pwelch(x,tukeywin(window_length),[],[],1/Ts,'onesided');
Pxx = Pxx(2:end);
ivar = f(2:end);
L = 10*log10((sqrt(2)/2*Pxx));
% L = 10*log10((1/2*Pxx));
% semilogx(ivar, L,'b');

% yticks([-150 -140 -130 -120 -110 -100 -90 -80 -70 ...
%     -60 -50 -40 -30 -20 -10 0])
% grid on;
% hold on;
