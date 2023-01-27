% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% Jan 26, 2023

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

%% log-normal psd analysis
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
nn=400;
x_log=logspace(-2,3,nn);

w3_m1 = 0.125;
mu3_m1 = 2.6;
nu_eff3_m1=2.5;
sigma3_m1 = exp(sqrt(log(1+nu_eff3_m1)))
log_sigma3_m1 = log(sigma3_m1)
a1_m1 = (log(x_log/mu3_m1)).^2;
a2_m1 = 2*((log_sigma3_m1)^2);
dNdD_3_norm_m1 = (w3_m1/(sqrt(2*pi)*log_sigma3_m1)) * exp(-a1_m1/a2_m1);
%
w3_m2 = 0.002;
mu3_m2 = 0.18;
nu_eff3_m2=0.1;
sigma3_m2 = exp(sqrt(log(1+nu_eff3_m2)));
log_sigma3_m2 = log(sigma3_m2);
a1_m2 = (log(x_log/mu3_m2)).^2;
a2_m2 = 2*((log_sigma3_m2)^2);
dNdD_3_norm_m2 = (w3_m2/(sqrt(2*pi)*log_sigma3_m2)) * exp(-a1_m2/a2_m2);
%
w3_m3 = 0.01;
mu3_m3 = 30;
nu_eff3_m3=0.7;
sigma3_m3 = exp(sqrt(log(1+nu_eff3_m3)));
log_sigma3_m3 = log(sigma3_m3);
a1_m3 = (log(x_log/mu3_m3)).^2;
a2_m3 = 2*((log_sigma3_m3)^2);
dNdD_3_norm_m3 = (w3_m3/(sqrt(2*pi)*log_sigma3_m3)) * exp(-a1_m3/a2_m3);
%
dNdD_3_norm=dNdD_3_norm_m1+dNdD_3_norm_m2+dNdD_3_norm_m3;
tpzlog3_check=trapz(x_log,dNdD_3_norm);
%
w0 = 7.24;% 4.71;
mu0 = 0.125;% 0.19;
nu_eff0 = 0.22;% 0.25
sigma0 = exp(sqrt(log(1+nu_eff0)));
log_sigma0 = log(sigma0);
a1_m1 = (log(x_log/mu0)).^2;
a2_m1 = 2*((log_sigma0)^2);
dNdD_0_norm = (w0/(sqrt(2*pi)*log_sigma0)) * exp(-a1_m1/a2_m1);

tpzlog0_check=trapz(x_log,dNdD_0_norm);
mu0_ref = mu0 * exp(4.5*power(log_sigma0,2));

%% results
figure(1);
ha = tight_subplot(1,2,[.07 .06],[.12 .1],[.07 .03]);
axes(ha(1))
h = gobjects(6, 1);
h(1)=semilogx(x_cd,qstar_e_3_norm,'o','color',[255,165,0]./255,...
    'MarkerFaceColor',[255,140,0]./255,'linew',1.5,'DisplayName','n_q(D_p)dD_p (measured)'); hold on;
h(3)=semilogx(x_log,dNdD_3_norm_m1,'-c','linew',1.5); hold on;
h(4)=semilogx(x_log,dNdD_3_norm_m2,'-g','linew',1.5); hold on;
h(5)=semilogx(x_log,dNdD_3_norm_m3,'-m','linew',1.5); hold on;
h(6)=semilogx(2.88.*ones(size(yy1)),yy1,'--k','linew',2.5); hold on;
h(2)=semilogx(x_log,dNdD_3_norm,'-b','linew',2.5,'DisplayName','n_q(D_p)dD_p (modelled)'); hold on;
xlim([1e-1 100]); yticks(0:0.01:0.05);
ylim([0 0.06]);
legend(h([1 2]),'location','northeast');
xlabel('\bf Particle size, D_p [\mum]');
ylabel('\bf Mass density spectrum [\mum^{-1}]');
title('\bf n_q(D_p)dD_p = f(\omega_{3i}, \mu_{3i}, ln\sigma_{g,3i})');
text(1.5,0.003,'\bf D_{pg,3}','Color','black');
%
axes(ha(2))
semilogx(x_cd,qstar_e_0_norm,'co','MarkerFaceColor',[0,191,255]./255); hold on;
semilogx(x_log,dNdD_0_norm,'-b','linew',2.5); hold on;
semilogx(0.125.*ones(size(yy2)),yy2,'--k','linew',1.00); hold on;
xlim([1e-1 100]); yticks(0:1:7);
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
% Change font
set(findall(gcf,'-property','FontSize'),'FontSize',6)
% Export file
print('kpg_dust.png','-dpng','-r300');