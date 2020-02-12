
F0=1e9;
L0=-110;
npoints=1e6;
sigma=sqrt(10^(L0/10)/F0)/(2*pi);
t_id=1/F0*(0:npoints-1);
j=sigma*randn(1,npoints);
t=t_id+j;

