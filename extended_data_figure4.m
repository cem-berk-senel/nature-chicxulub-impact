% Coded by: Cem Berk Senel
% for Nature Chicxulub Impact manuscript
% Reference Systems & Planetology Department, Royal Observatory of Belgium
% June 10, 2022

% Extended Data Figure 4
clear; clc; close all;
load data_extended_figure4.mat;

nrow=size(ts_preimp,1);
ncol=size(ts_preimp,2);

tt1=reshape(ts_preimp,[64 36 24 365]);
tt2=squeeze(mean(tt1,3));
tr=273.14;
ts_global = squeeze(mean(tt2,3))-tr;
ts_g = mean(ts_global,1);
ts_summer=squeeze(mean(tt2(:,:,172:266),3))-tr;
ts_wint1=squeeze(mean(tt2(:,:,355:end),3))-tr;
ts_wint2=squeeze(mean(tt2(:,:,1:79),3))-tr;
ts_winter=0.5*(ts_wint1+ts_wint2);

vlatt=latitude(1,:);
vlonn=longitude(:,1);        

Ts_l = zeros(3,ncol-1);
Ts_o = zeros(3,ncol);

%
t=1;
sum_l=0; counter_l=0;
sum_o=0; counter_o=0;
for j=1:(ncol-1)
    for i=1:nrow
        if (xland(i,j)==1)
            sum_l=sum_l+ts_global(i,j);
            counter_l=counter_l+1;
        end
    end
    mean_l=sum_l/counter_l;
    Ts_l(t,j)=mean_l; 
    sum_l=0; counter_l=0;
end
for j=1:ncol
    for i=1:nrow
        if (xland(i,j)==2)
            sum_o=sum_o+ts_global(i,j);
            counter_o=counter_o+1;
        end
    end
    mean_o=sum_o/counter_o;
    Ts_o(t,j)=mean_o;   
    sum_o=0; counter_o=0;    
end

%
t=2;
sum_l=0; counter_l=0;
sum_o=0; counter_o=0;
for j=1:(ncol-1)
    for i=1:nrow
        if (xland(i,j)==1)
            sum_l=sum_l+ts_summer(i,j);
            counter_l=counter_l+1;
        end
    end
    mean_l=sum_l/counter_l;
    Ts_l(t,j)=mean_l; 
    sum_l=0; counter_l=0;
end
for j=1:ncol
    for i=1:nrow
        if (xland(i,j)==2)
            sum_o=sum_o+ts_summer(i,j);
            counter_o=counter_o+1;
        end
    end
    mean_o=sum_o/counter_o;
    Ts_o(t,j)=mean_o;   
    sum_o=0; counter_o=0;    
end

%
t=3;
sum_l=0; counter_l=0;
sum_o=0; counter_o=0;
for j=1:(ncol-1)
    for i=1:nrow
        if (xland(i,j)==1)
            sum_l=sum_l+ts_winter(i,j);
            counter_l=counter_l+1;
        end
    end
    mean_l=sum_l/counter_l;
    Ts_l(t,j)=mean_l; 
    sum_l=0; counter_l=0;
end
for j=1:ncol
    for i=1:nrow
        if (xland(i,j)==2)
            sum_o=sum_o+ts_winter(i,j);
            counter_o=counter_o+1;
        end
    end
    mean_o=sum_o/counter_o;
    Ts_o(t,j)=mean_o;   
    sum_o=0; counter_o=0;    
end

xl1=linspace(-30,50,10); yl1=zeros(size(xl1));
yl2=linspace(-90,90,10); xl2=zeros(size(xl1));

yy_l=vlatt(1:(ncol-1)); yy_o=vlatt(1:ncol); yy_g=vlatt(1:ncol); 

figure(1);
er=errorbar(upchurch2015(:,6),upchurch2015(:,4),upchurch2015(:,7),upchurch2015(:,8),'horizontal','o','MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k'); er.Color = 'k'; hold on;
lo=Ts_l(3,:); hi=Ts_l(2,:);
plot(lo,yy_l,'--g', 'linew', 1.25); hold on;
plot(hi,yy_l,'-g', 'linew', 1.25); hold on;
x2_l = [fliplr(yy_l),yy_l]; inBetween_l = [fliplr(hi),lo];
lo=Ts_o(3,:); hi=Ts_o(2,:);
plot(lo,yy_o,'--b', 'linew', 1.25); hold on;
plot(hi,yy_o,'-b', 'linew', 1.25); hold on;
x2_o = [fliplr(yy_o),yy_o]; inBetween_o = [fliplr(hi),lo];
plot(ts_g(1,:),yy_g,'k-','MarkerSize',5,'MarkerFaceColor','b','linew',3); hold on;
fill(inBetween_l,x2_l,'g','LineStyle','none','FaceAlpha',0.1);
fill(inBetween_o,x2_o,'b','LineStyle','none','FaceAlpha',0.2);
hl=legend('Proxy observations','GCM land - mean winter','GCM land - mean summer',...
    'GCM ocean - mean winter','GCM ocean - mean summer',...
    'GCM global - annual','location','west'); hl.Box='off';
xlabel('\bf T_s [{\circ}C]'); xlim([-30 45]); xticks(-30:10:50);
ylabel('\bf Latitude [{\circ}]'); ylim([-82.5 82.5]); yticks(-90:15:90);

set(gcf,'paperunits','inches') 
set(gcf, 'PaperPositionMode','manual');
set(gcf,'papersize',[8,10])
set(gcf,'paperposition',[0,0,8,10])
set(findall(gcf,'-property','FontSize'),'FontSize',16)
print('data_extended_figure4.png','-dpng','-r300');