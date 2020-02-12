F0=1e9;
L1=-110;
f1=5e6;
npoints=1e6;
sigma_l=(f1/F0)*sqrt(10^(L1/10)/F0);
t_id=1/F0*(0:npoints-1);
l=sigma_l*randn(1,npoints);
j=cumsum(l);
t=t_id+j;

