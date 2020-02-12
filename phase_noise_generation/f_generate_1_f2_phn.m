function [j_phn] = f_generate_1_f2_phn(F0, L1, f1,npoints)
    sigma_l=(f1/F0)*sqrt(10^(L1/10)/F0);
    t_id=1/F0*(0:npoints-1);
    l=sigma_l*randn(1,npoints);
    j_phn=cumsum(l); clear l;
end

