% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% June 10, 2022

% Figure 2b
clear; clc; close all;

dp = logspace(-3,3,1000)'; dp=dp*(1e-6);
%
eb1 = 0.2; eb2 = -0.667; ustar = 0.05; 
vd_l1 = depland(eb1,eb2,ustar,dp);
%
eb1 = 0.2; eb2 = -0.667; ustar = 0.20; 
vd_l2 = depland(eb1,eb2,ustar,dp);
%
eb1 = 1; eb2 = -0.55; ustar = 0.05; 
vd_o1 = depocean(eb1,eb2,ustar,dp);
%
eb1 = 1; eb2 = -0.55; ustar = 0.20; 
vd_o2 = depocean(eb1,eb2,ustar,dp);

%
set(findall(gcf,'-property','FontSize'),'FontSize',12)
n1=logspace(-4,4,1000); n2=ones(size(n1))*0.02;
v1=logspace(-4,4,1000); v2=ones(size(v1))*0.125;
c1=logspace(-4,4,1000); c2=ones(size(c1))*250;
figure(1); 
loglog(1e6*dp,vd_l1*100,'-','color',[0,128,0]./255,'linew',3); hold on;
loglog(1e6*dp,vd_l2*100,'-','color',[0,255,0]./255,'linew',3); hold on;
loglog(1e6*dp,vd_o1*100,'-','color',[0,0,200]./255,'linew',3); hold on;
loglog(1e6*dp,vd_o2*100,'-','color',[30,144,255]./255,'linew',3); hold on;
loglog(v2,v1,'--','color',[255,165,0]./255,'linew',3); 
loglog(n2,n1,'--','color',[255,20,147]./255,'linew',3); loglog(c2,c1,'--','color',[.6 .6 .6],'linew',3);
ylim([0.001 1000]); xlim([0.001 500]);
hy=ylabel('\bf Deposition velocity [cm/s]'); 
hx=xlabel('\bf Particle diameter [\mum]');
legend('Land - u_*=0.05m/s','Land - u_*=0.20m/s',...
    'Ocean - u_*=0.05m/s','Ocean - u_*=0.20m/s','FontSize',10,'location','southeast')

set(gcf,'paperunits','inches') 
set(gcf, 'PaperPositionMode','manual');
set(gcf,'papersize',[7,6])
set(gcf,'paperposition',[0,0,7,6])
print('data_figure2b.png','-dpng','-r300');

clc;
dd=1e6*dp;
vd_l1=vd_l1*100;
vd_l2=vd_l2*100;
vd_o1=vd_o1*100;
vd_o2=vd_o2*100;