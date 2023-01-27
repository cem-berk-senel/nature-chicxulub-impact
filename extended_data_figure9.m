rr = logspace(-3,2,1000);
rm = 0.11;
nu_eff=0.247
sigma = sqrt(log(1+nu_eff))
exp(sigma)

a1 = (log(rr/rm)).^2;
a2 = 2*((sigma)^2);

dN_rr = (1/(sqrt(2*pi)*sigma)) * exp(-a1/a2);

close all;
figure(9);
semilogx(rr,dN_rr,'linew',3)
xlim([5e-3 10]);
