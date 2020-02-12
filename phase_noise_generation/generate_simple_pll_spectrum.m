
F0=1e9;
L0=-110;
f3dB=1e6;
npoints=1e7;
sigma=sqrt(10^(L0/10)/F0)/(2*pi)
t_id=1/F0*(0:npoints-1);
j=sigma*randn(1,npoints);
[B,A] = butter(1,2*f3dB/F0);
j_filtered=filter(B,A,j);
t=t_id+j_filtered;

