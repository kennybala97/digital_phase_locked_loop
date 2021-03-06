function [j_phn] = f_generate_1_f3_phn(F0, fmin, fmax, L1, f1,npoints)
%     F0=1e9; % temporal frequency
%     fmin=1e1; % Minimum frequency
%     fmax=1e8; % Maximum Frequency
%     L1=-80;   % Phase Noise power in dB
%     f1=10e3;
%     npoints=1e7;
    t_id=1/F0*(0:npoints-1);
    gamma=abs(sqrt(10)/(1+j*10)+1/(1+j)+sqrt(10)/(10+j))^2;
    sigma_l=sqrt(10^(L1/10)*f1^3/(F0^3*fmin*gamma));
    l=sigma_l*randn(1,npoints);
    fcorner=logspace(log10(fmin),log10(fmax),8);
    [B1,A1] = butter(1,2*fcorner(1)/F0);
    [B2,A2] = butter(1,2*fcorner(2)/F0);
    [B3,A3] = butter(1,2*fcorner(3)/F0);
    [B4,A4] = butter(1,2*fcorner(4)/F0);
    [B5,A5] = butter(1,2*fcorner(5)/F0);
    [B6,A6] = butter(1,2*fcorner(6)/F0);
    [B7,A7] = butter(1,2*fcorner(7)/F0);
    [B8,A8] = butter(1,2*fcorner(8)/F0);
    l1_filtered=filter(B1,A1,l);
    l_final = l1_filtered; clear l1_filtered;
    l2_filtered=filter(B2,A2,l/sqrt(10));
    l_final = l_final+l2_filtered; clear l2_filtered;
    l3_filtered=filter(B3,A3,l/sqrt(10)^2);
    l_final = l_final+l3_filtered; clear l3_filtered;
    l4_filtered=filter(B4,A4,l/sqrt(10)^3);
    l_final = l_final+l4_filtered; clear l4_filtered;
    l5_filtered=filter(B5,A5,l/sqrt(10)^4);
    l_final = l_final+l5_filtered; clear l5_filtered;
    l6_filtered=filter(B6,A6,l/sqrt(10)^5);
    l_final = l_final+l6_filtered; clear l6_filtered;
    l7_filtered=filter(B7,A7,l/sqrt(10)^6);
    l_final = l_final+l7_filtered; clear l7_filtered;
    l8_filtered=filter(B8,A8,l/sqrt(10)^7);
    l_final = l_final+l8_filtered; clear l8_filtered; clear l;
    %j1=l1_filtered+l2_filtered+l3_filtered+l4_filtered+...
    %l5_filtered+l6_filtered+l7_filtered+l8_filtered;
    j1 = l_final; clear l_final;
    j_phn=cumsum(j1); clear j1;
end

