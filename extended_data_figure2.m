% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% June 10, 2022

% Extended Data Figure 2
clear; clc; close all;
load data_extended_figure2.mat;

x_i=dust_kpg(1,:)';
dQ_3=(dust_kpg(2,:)');
ni=size(x_i,1);

Q_3 = zeros(ni,1);
for i=1:ni
    Q_3(i,1)=min(sum(dQ_3(1:i,1)),100);
end

% semilogx(x_i,Q_3,'-*','linew',2); hold on;

dx_i = zeros(ni-1,1);
for i=1:(ni-1)
    dx_i(i,1)=x_i(i+1)-x_i(i);
end

q_3 = zeros(ni-1,1);
for i=1:(ni-1)
    q_3(i,1)=(dQ_3(i+1)/dx_i(i))/100;
end

x_c = zeros(ni-1,1);
for i=1:(ni-1)
    x_c(i,1)=0.5*(x_i(i+1)+x_i(i));
end

dlogxi = zeros(ni-1,1);
qstar_3 = zeros(ni-1,1);
for i=1:(ni-1)
    dlogxi(i,1)=log10((x_i(i+1))/(x_i(i)));
    qstar_3(i,1)=(dQ_3(i+1)/dlogxi(i,1))/100;
end

g_tr = (pi/6)*power(x_i,3);

Q_0tr = Q_3 ./ g_tr;
Q_0tr_sum = sum(Q_0tr);
Q_0tr_norm = Q_0tr ./ Q_0tr_sum;

Q_0 = zeros(ni,1);
for i=1:ni
    Q_0(i,1)=min(100*sum(Q_0tr_norm(1:i,1)),100);
end

dQ_0 = zeros(ni,1);
for i=1:(ni-1)
    dQ_0(i+1,1)=Q_0(i+1,1)-Q_0(i,1);
end

ll=logspace(min(log10(x_i))-1,max(log10(x_i)),100);
yy1=linspace(0.005,0.06,10);
yy2=linspace(0.65,8,10);

dlnxi = zeros(ni-1,1);
qstar_0 = zeros(ni-1,1);
for i=1:(ni-1)
    dlnxi(i,1)=log10((x_i(i+1))/(x_i(i)));
    qstar_0(i,1)=(dQ_0(i+1)/dlnxi(i,1))/100;
end

%
x_cd=dust_kpg_q3(:,1);
nii=size(x_cd,1);

qstar_o_3=dust_kpg_q3(:,2);
qstar_e_3=qstar_o_3./2.303;

g_trd = (pi/6)*power(x_cd,3);

qstar_e_0=qstar_e_3 ./ g_trd;

qstar_e_0_tpz = trapz(x_cd,qstar_e_0)
qstar_e_0_norm = qstar_e_0 ./ qstar_e_0_tpz;
qstar_e_3_tpz = trapz(x_cd,qstar_e_3);
qstar_e_3_norm = qstar_e_3 ./ qstar_e_3_tpz;

tpz0_check=trapz(x_cd,qstar_e_0_norm)
tpz3_check=trapz(x_cd,qstar_e_3_norm)

%
x_log=logspace(-2,3,1000);

w3 = 0.148;
mu3 = 2.88;
nu_eff3=4.43
sigma3 = exp(sqrt(log(1+nu_eff3)))
log_sigma3 = log(sigma3)
a1 = (log(x_log/mu3)).^2;
a2 = 2*((log_sigma3)^2);
dNdD_3_norm = (w3/(sqrt(2*pi)*log_sigma3)) * exp(-a1/a2);

w0 = 7.24;% 4.71;
mu0 = 0.125;% 0.19;
nu_eff0 = 0.22;% 0.25
sigma0 = exp(sqrt(log(1+nu_eff0)))
log_sigma0 = log(sigma0)
a1 = (log(x_log/mu0)).^2;
a2 = 2*((log_sigma0)^2);
dNdD_0_norm = (w0/(sqrt(2*pi)*log_sigma0)) * exp(-a1/a2);

tpzlog3_check=trapz(x_log,dNdD_3_norm)
clc
tpzlog0_check=trapz(x_log,dNdD_0_norm)
mu0_ref = mu0 * exp(4.5*power(log_sigma0,2))

%
figure(1);
ha = tight_subplot(1,2,[.07 .06],[.12 .1],[.07 .03]);
axes(ha(1))
semilogx(x_cd,qstar_e_3_norm,'o','color',[255,165,0]./255,'MarkerFaceColor',[255,140,0]./255,'linew',1.5); hold on;
semilogx(x_log,dNdD_3_norm,'-k','linew',1.5); hold on;
semilogx(2.88.*ones(size(yy1)),yy1,'--k','linew',1.00); hold on;
xlim([1e-2 1000]); yticks(0:0.01:0.05);
ylim([0 0.06]);
legend('n_q(D_p)dD_p (measured)','n_q(D_p)dD_p (modelled)','location','northeast');
xlabel('\bf Particle size, D_p [\mum]');
ylabel('\bf Mass density spectrum [\mum^{-1}]');
title('\bf n_q(D_p)dD_p = f(\omega_3, \mu_3, ln\sigma_{g,3})');
text(0.03,0.042,'\bf \omega_3=0.148','Color','black');
text(0.03,0.036,'\bf D_{pg,3}=2.88 \rightarrow','Color','black');
text(0.03,0.030,'\bf ln\sigma_{g,3}=1.3','Color','black');
text(1.5,0.003,'\bf D_{pg,3}','Color','black');

%
axes(ha(2))
semilogx(x_cd,qstar_e_0_norm,'co','MarkerFaceColor',[0,191,255]./255); hold on;
semilogx(x_log,dNdD_0_norm,'-b','linew',2.5); hold on;
semilogx(0.125.*ones(size(yy2)),yy2,'--k','linew',1.00); hold on;
xlim([1e-2 1000]); yticks(0:1:7);
ylim([0 8]);
legend('n_N(D_p)dD_p (transformed)','n_N(D_p)dD_p (modelled)','location','northeast');
xlabel('\bf Particle size, D_p [\mum]');
ylabel('\bf Number density spectrum [\mum^{-1}]');
title('\bf n_N(D_p)dD_p = f(\omega_0, \mu_0, ln\sigma_{g,0})');
text(0.28,5.6,'\bf \omega_0=7.24','Color','black');
text(0.23,4.8,'\bf \leftarrow D_{pg,0}=0.125','Color','black');
text(0.28,4.,'\bf ln\sigma_{g,0}=0.446','Color','black');
text(0.06,0.4,'\bf D_{pg,0}','Color','black');

set(gcf,'paperunits','inches') 
set(gcf, 'PaperPositionMode','manual');
set(gcf,'papersize',[6.5,3.5])
set(gcf,'paperposition',[0,0,6.5,3.5])
set(gcf, 'renderer', 'OpenGL');
set(findall(gcf,'-property','FontSize'),'FontSize',7)
print('data_extended_figure2.png','-dpng','-r300');