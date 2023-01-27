% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% Jan 26, 2023

% Extended Data Figure 6
clear; clc; close all;

load data_extended_figure6.mat;

figure(1);
time=linspace(-4,25,29*365)';
ha = tight_subplot(2,1,[.1 .07],[.08 .05],[.08 .03]);
%
axes(ha(1))
plot(time,sw_n_revdust,'color',[251,163,26]./255,'linew',3); hold on;
plot(time,sw_n_revsulfur,'-c','linew',3); hold on;
plot(time,sw_n_revsoot,'color',[.7 .7 .7],'linew',3); hold on;
plot(time,sw_n_combined,'-k','linew',4); hold on;
xlim([-2 25]); xticks(-4:1:25);
ylim([-10 240]); yticks(0:40:240);
hy=ylabel('\bf [W/m^2]'); %hx=xlabel('\bf Time after impact [yrs]');
title('\bf Global-average surface net shortwave radiation');
legend('Dust','Sulfur','Soot','Combined','location','east');
%
axes(ha(2))
plot(time,lw_n_revdust,'color',[251,163,26]./255,'linew',3); hold on;
plot(time,lw_n_revsulfur,'-c','linew',3); hold on;
plot(time,lw_n_revsoot,'color',[.7 .7 .7],'linew',3); hold on;
plot(time,lw_n_combined,'-k','linew',4); hold on;
xlim([-2 25]); xticks(-4:1:25);
ylim([-80 10]); yticks(-100:10:20);
hy=ylabel('\bf [W/m^2]'); hx=xlabel('\bf Time after impact [years]');
title('\bf Global-average surface net longwave radiation');

set(gcf,'paperunits','inches') 
set(gcf, 'PaperPositionMode','manual');
set(gcf,'papersize',[15,11])
set(gcf,'paperposition',[0,0,15,11])
set(findall(gcf,'-property','FontSize'),'FontSize',20)
print('data_extended_figure6.png','-dpng','-r300');
