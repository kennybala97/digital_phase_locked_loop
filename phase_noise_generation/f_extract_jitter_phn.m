function [F_id,tj_per_pp,tj_per_rms,tj_c2c_pp,tj_c2c_rms,...
tj_rms,tj_pp,fPHN,PHN] = f_extract_jitter_phn(t)
%% Compute Period Jitter
T=diff(t);
% Peak to Peak Period Jitter
tj_per_pp=max(T)-min(T);
% Rms Period Jitter
tj_per_rms=std(T);
% Peak to Peak Cycle to Cycle Jitter
tj_c2c_pp=max(diff(T))-min(diff(T));
% Rms Cycle to Cycle Jitter
tj_c2c_rms=std(diff(T));
%% Compute least squares line
n=length(t);
i=(0:n-1);
T_id=(sum(i.*t)-(n-1)/2*sum(t))/((n^2-1)*n/12);
t_off=sum(t)/n-T_id*(n-1)/2;
F_id=1/T_id;
%% Absolute jitter
t_id=t_off+(0:T_id:(n-1)*T_id);
tj=t-t_id;
tj=tj-mean(tj);
% Standard Deviation Absolute Jitter
tj_rms=std(tj);
% Peak to Peak Absolute Jitter
tj_pp=max(tj)-min(tj);
%% Compute Phase Noise
phi_e=tj*2*pi/T_id;
npsd=2^(nextpow2(length(phi_e)/4)-1); 
Fpsd=1/(npsd*T_id)
fPHN=0:Fpsd:Fpsd*(floor(npsd/2) -1);
nwind=32;
w=hann(npsd,'periodic')';
U2=sum(w.^2);
I=zeros(1,npsd);
for i=1:nwind
start=1+floor((n-npsd)/(nwind-1))*(i-1);
stop=start+npsd -1;
xtmp=phi_e(start:stop);
v=xtmp.*w;
I=I+abs(fft(v,npsd)).^2;
end
PHN=I/(nwind*U2/T_id);
PHN=PHN(1:floor(npsd/2));
