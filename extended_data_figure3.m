% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% June 10, 2022

% Extended Data Figure 3
clear; clc; close all;
load data_extended_figure3.mat;

ll=linspace(-4,25,29*365)';
ll_nano=linspace(0,10,10*365)';
ll_coarse=linspace(0,1,1*365)';
%
figure(1)
semilogy(ll,cd_o_dust,'color',[251,163,26]./255,'linew',3); hold on;
semilogy(ll_nano,cd_o_nanodust,'-','color',[.6 .6 .6],'linew',3); hold on;
semilogy(ll_coarse,cd_o_coarsedust,'-k','linew',3); hold on;
ylim([1e1 1e18]); yticks([1e2 1e4 1e6 1e8 1e10 1e12 1e14 1e16]);
xlim([-2 25]); xticks(-4:1:25);
hy=ylabel('\bf [kg]'); hx=xlabel('\bf Time after impact [yrs]');
title('\bf Global column-integrated fine-grained ejecta mass');
legend('Tanis K-Pg silicate dust (this study)','Dust nanoparticles (Toon et al. 2016)',...
    'Dust type 2 coarse spherules (Toon et al. 2016)','FontSize',16,'location','northeast');

set(gcf,'paperunits','inches') 
set(gcf, 'PaperPositionMode','manual');
set(gcf,'papersize',[15,5])
set(gcf,'paperposition',[0,0,15,5])
set(findall(gcf,'-property','FontSize'),'FontSize',16)
print('data_extended_figure3.png','-dpng','-r300');