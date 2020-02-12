F0=1e9;
fmin=1e1;
fmax=1e8;
L1_flicker=-80;
f1_flicker=3e3;
L1_white=-100;
f1_white=30e3;
L0_pll=-100;
f3dB_pll=2e6;
L0_flat=-130;
npoints=1e8;
t_id=1/F0*(0:npoints-1);
gamma=abs(sqrt(10)/(1+j*10)+1/(1+j)+sqrt(10)/(10+j))^2;
sigma_l_flicker=sqrt(10^(L1_flicker/10)*f1_flicker^3...
/(F0^3*fmin*gamma));
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
t=t_id+j_flicker+j_white+j_pll+j_flat;
