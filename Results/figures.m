set(0,'defaulttextInterpreter','latex'); 
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(0,'defaultAxesFontSize',12);
set(0, 'DefaultLineLineWidth', 1.1);
set(0, 'DefaultFigureRenderer', 'painters');
set(0,'DefaultFigureWindowStyle','docked') % docked
clear all; close all; clc;
%% Question 10:
for i=1
load('Q10.mat')
peak_PSD=findpeaks(psd_pitch(:,1));
peak_pitch(1) = find(psd_pitch(:,1)==peak_PSD(1));
peak_pitch(2) = find(psd_pitch(:,1)==peak_PSD(2));
peak_PSD=findpeaks(psd_surge(:,2));
peak_surge(1) = find(psd_surge(:,2)==peak_PSD(1));
peak_surge(2) = find(psd_surge(:,2)==peak_PSD(2));

% SURGE decay test 
figure()
subplot(2,1,1)
    yyaxis left
    plot(tspan,q_surge(:,1),'k')
    ylabel('$x_0$ [m]')
    yyaxis right
    plot(tspan,q_surge(:,2),'r')
    ylabel('$\theta$ [rad]'); xlabel('t [s]')
    legend('Surge, $x_0$','Pitch, $\theta$')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    grid on;box on; 
    title('Decay test in surge: $x_0(0)=1$ m')
subplot(2,1,2)
    yyaxis left
    plot(fpsd_surge,psd_surge(:,1),'k');hold on;
    xlim([0 0.05])
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
    text(fpsd_pitch(peak_surge(1))+0.0005,max(psd_surge(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_surge(1))) 'Hz'])
    text(fpsd_pitch(peak_surge(2))+0.0005,max(psd_surge(:,1))*0.5,['$f_2=$' num2str(fpsd_pitch(peak_surge(2))) 'Hz'])
    yyaxis right
    plot(fpsd_surge,psd_surge(:,2),'r');hold on;
    ylabel('PSD [rad$^2$/Hz]'); ylim([0 7e-6])
    hold on; xline(fpsd_pitch(peak_surge(1)),'--k')
    hold on; xline(fpsd_pitch(peak_surge(2)),'--k')
    legend('Surge, $x_0$','Pitch, $\theta$','Location','best')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    grid on;box on; 
    printfig(18,12,'..\figures\Q10 - Surge decay test',0)

figure()
subplot(2,1,1)
    yyaxis left
    plot(tspan,q_pitch(:,1),'k')
    ylabel('$x_0$ [m]')
    yyaxis right
    plot(tspan,q_pitch(:,2),'r')
    ylabel('$\theta$ [rad]'); xlabel('t [s]')
    legend('Surge, $x_0$','Pitch, $\theta$')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    grid on;box on; 
    title('Decay test in pitch: $\theta(0)=0.1$ rad')
subplot(2,1,2)
    yyaxis left
    plot(fpsd_pitch,psd_pitch(:,1),'k');hold on; 
    xlim([0 0.05])
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]'); box on; grid on;
    text(fpsd_pitch(peak_pitch(1))+0.0005,max(psd_pitch(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_pitch(1))) 'Hz'])
    text(fpsd_pitch(peak_pitch(2))-0.008,max(psd_pitch(:,1))*0.9,['$f_2=$' num2str(fpsd_pitch(peak_pitch(2))) 'Hz'])
    yyaxis right
    plot(fpsd_pitch,psd_pitch(:,2),'r')
    xline(fpsd_pitch(peak_pitch(1)),'--k')
    hold on; xline(fpsd_pitch(peak_pitch(2)),'--k')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    legend('Surge, $x_0$','Pitch, $\theta$','Location','best')
    ylabel('PSD [rad$^2$/Hz]')
    printfig(18,12,'..\figures\Q10 - Pitch decay test',0)
 end
clear all;
%% Question 11
for i=1
Q10 = load('Q10.mat');
Q11 = load('Q11a.mat');
tspan = Q10.tspan;
peak_PSD=findpeaks(Q10.psd_pitch(:,1));
peak_pitch(1) = find(Q10.psd_pitch(:,1)==peak_PSD(1));
peak_pitch(2) = find(Q10.psd_pitch(:,1)==peak_PSD(2));
peak_PSD=findpeaks(Q10.psd_surge(:,2));
peak_surge(1) = find(Q10.psd_surge(:,2)==peak_PSD(1));
peak_surge(2) = find(Q10.psd_surge(:,2)==peak_PSD(2));

% SURGE decay test 
figure()
subplot(2,2,1)
    plot(tspan,Q10.q_surge(:,1),'k');hold on;
    plot(tspan,Q11.q_surge(:,1),'g');
    xlabel('t [s]')
    ylabel('$x_0$ [m]');grid on;box on; 
    legend('No Hydro force','Hydro force','Location','best')
    title('Surge and Pitch time series')
subplot(2,2,3)
    plot(tspan,Q10.q_surge(:,2),'k'); hold on; 
    plot(tspan,Q11.q_surge(:,2),'g');
    ylabel('$\theta$ [rad]'); xlabel('t [s]')
    grid on;box on; 
subplot(2,2,2)
    plot(Q10.fpsd_surge,Q10.psd_surge(:,1),'k');hold on;
    plot(Q11.fpsd_surge,Q10.psd_surge(:,1),'g');
    hold on; xline(Q10.fpsd_pitch(peak_surge(1)),'--k')
    title('Surge and Pitch PSD')
    xlim([0 0.05]); grid on; box on
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
    text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_surge(:,1))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_surge(1))) 'Hz'])
subplot(2,2,4)
    plot(Q10.fpsd_surge,Q10.psd_surge(:,2),'k');hold on;
    plot(Q10.fpsd_surge,Q11.psd_surge(:,2),'g');
    text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_surge(:,2))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_surge(1))) 'Hz'])
    text(Q10.fpsd_pitch(peak_surge(2))+0.0005,max(Q10.psd_surge(:,2))*0.5,['$f_2=$' num2str(Q10.fpsd_pitch(peak_surge(2))) 'Hz'])
    ylabel('PSD [rad$^2$/Hz]'); ylim([0 7e-6])
    hold on; xline(Q10.fpsd_pitch(peak_surge(1)),'--k')
    hold on; xline(Q10.fpsd_pitch(peak_surge(2)),'--k');xlim([0 0.05])
    grid on;box on; 
    printfig(23,12,'..\figures\Q11 - Surge decay test comparison',1)

% Pitch decay test 
figure()
subplot(2,2,1)
    plot(tspan,Q10.q_pitch(:,1),'k');hold on;
    plot(tspan,Q11.q_pitch(:,1),'g');
    xlabel('t [s]')
    ylabel('$x_0$ [m]');grid on;box on; 
    legend('No Hydro force','Hydro force','Location','best')
    title('Surge and Pitch time series')
subplot(2,2,3)
    plot(tspan,Q10.q_pitch(:,2),'k'); hold on; 
    plot(tspan,Q11.q_pitch(:,2),'g');
    ylabel('$\theta$ [rad]');  xlabel('t [s]')
    grid on;box on; 
subplot(2,2,2)
    plot(Q10.fpsd_pitch,Q10.psd_pitch(:,1),'k');hold on;
    plot(Q11.fpsd_pitch,Q10.psd_pitch(:,1),'g');
    hold on; xline(Q10.fpsd_pitch(peak_pitch(1)),'--k')
    title('Surge and Pitch PSD')
    xlim([0 0.05]); grid on; box on
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
    text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_pitch(:,1))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_pitch(1))) 'Hz'])
subplot(2,2,4)
    plot(Q10.fpsd_surge,Q10.psd_pitch(:,2),'k');hold on;
    plot(Q10.fpsd_surge,Q11.psd_pitch(:,2),'g');
    text(Q10.fpsd_pitch(peak_pitch(1))+0.0005,max(Q10.psd_pitch(:,2))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_pitch(1))) 'Hz'])
    text(Q10.fpsd_pitch(peak_pitch(2))+0.0005,max(Q10.psd_pitch(:,2))*0.5,['$f_2=$' num2str(Q10.fpsd_pitch(peak_pitch(2))) 'Hz'])
    ylabel('PSD [rad$^2$/Hz]');
    hold on; xline(Q10.fpsd_pitch(peak_pitch(1)),'--k')
    hold on; xline(Q10.fpsd_pitch(peak_pitch(2)),'--k');xlim([0 0.05])
    grid on;box on; 
    printfig(23,12,'..\figures\Q11 - Pitch decay test comparison',0)
end  
clear all;
%% Question 12
fprintf('No wind and regular waves')
for i=1
load('Q12.mat')
[maxi,loc]=max(psd_eta); % Surface elevation
[maxi2,loc2]=max(psd(:,1)); % Surge 
[maxi3,loc3]=max(psd(:,2)); % Pitch
figure()
subplot(3,2,1)
    plot(tspan_climates,eta,'b'); hold on;
    plot(tspan_climates(1:(end/2)),eta(1:(end/2)),'c'); ylim([min(eta)*1.1 max(eta)*1.1]);
    xlabel('t [s]'); ylabel('$\eta$ [m]'); grid on; box on;
    title('Time series')
subplot(3,2,2)
    plot(fpsd_eta,psd_eta,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    text(fpsd_eta(loc)*1.1,maxi,[num2str(fpsd(loc)) ' Hz'])
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on; 
    title('PSDs')
subplot(3,2,3)
    plot(tspan,q(:,1),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),1),'c'); 
    xlabel('t [s]'); ylabel('Surge $x_0$ [m]'); grid on; box on;
subplot(3,2,4)
    plot(fpsd,psd(:,1),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    text(fpsd(loc2)*1.1,maxi2,[num2str(fpsd(loc2)) ' Hz'])    
    xlim([0 0.2]);ylim([0 max(psd(:,1))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on;
subplot(3,2,5)
    plot(tspan,q(:,2),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),2),'c'); 
    xlabel('t [s]'); ylabel('Pitch $\theta$ [rad]'); grid on; box on;
subplot(3,2,6)
    plot(fpsd,psd(:,2),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); hold on;
    text(fpsd(loc3)*1.1,maxi3,[num2str(fpsd(loc3)) ' Hz'])    
    xlim([0 0.2]); ylim([0 max(psd(:,2))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [rad$^2$/Hz]'); grid on; box on; 
printfig(20,15,'..\figures\Q12 - Eta, surge and pitch responses',0)
end   

titles = {'$\eta$ [m] &';'Surge $x_0$ [m]&';'Pitch $\theta$ [rad] &'};
loc_init = 6000; 
Mean = {[num2str(mean(eta(loc_init*2:end))) '&'] ;[num2str(mean(q(loc_init:end,1))) '&'];[num2str(mean(q(loc_init:end,2))) '&' ]};
MAX = {[num2str(max(eta(loc_init*2:end))) '&'];[num2str(max(q(loc_init:end,1))) '&'];[num2str(max(q(loc_init:end,2))) '&']};
STD ={[num2str(std(eta(loc_init*2:end)))];[num2str(std(q(loc_init:end,1)))];[num2str(std(q(loc_init:end,2)))]};
MIN = {[num2str(min(eta(loc_init*2:end))) '&'];[num2str(min(q(loc_init:end,1))) '&'];[num2str(min(q(loc_init:end,2))) '&']};
mltable = table(Mean,MAX,MIN,STD,'RowNames',titles)

clear all
%% Question 13   
fprintf('Steady wind and regular waves')
for i=1
load('Q13.mat')
[maxi,loc]=max(psd_eta); % Surface elevation
[maxi2,loc2]=max(psd(:,1)); % Surge 
[maxi3,loc3]=max(psd(:,2)); % Pitch
figure()
subplot(4,2,1)
    plot(tspan_climates,vt,'b'); hold on;
    plot(tspan_climates(1:(end/2)),vt(1:(end/2)),'c'); 
    xlabel('t [s]'); ylabel('$V_{\infty}$ [m/s]'); grid on; box on;
    title('Time series')
subplot(4,2,2)
    plot(fpsd_vt,psd_vt,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/s]'); grid on; box on; 
    title('PSDs')
subplot(4,2,3)
    plot(tspan_climates,eta,'b'); hold on;
    plot(tspan_climates(1:(end/2)),eta(1:(end/2)),'c'); ylim([min(eta)*1.1 max(eta)*1.1]);
    xlabel('t [s]'); ylabel('$\eta$ [m]'); grid on; box on;
subplot(4,2,4)
    plot(fpsd_eta,psd_eta,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    text(fpsd_eta(loc)*1.1,maxi*0.9,[num2str(fpsd(loc)) ' Hz'])
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on; 
subplot(4,2,5)
    plot(tspan,q(:,1),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),1),'c'); 
    xlabel('t [s]'); ylabel('Surge $x_0$ [m]'); grid on; box on;
subplot(4,2,6)
    plot(fpsd,psd(:,1),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    text(fpsd(loc2)*1.1,maxi2,[num2str(fpsd(loc2)) ' Hz'])    
    xlim([0 0.2]);ylim([0 max(psd(:,1))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on;
subplot(4,2,7)
    plot(tspan,q(:,2),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),2),'c'); 
    xlabel('t [s]'); ylabel('Pitch $\theta$ [rad]'); grid on; box on;
subplot(4,2,8)
    plot(fpsd,psd(:,2),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); hold on;
    text(fpsd(loc3)*1.1,maxi3,[num2str(fpsd(loc3)) ' Hz'])    
    xlim([0 0.2]); ylim([0 max(psd(:,2))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [rad$^2$/Hz]'); grid on; box on; 
printfig(20,15,'..\figures\Q13 - Vt, Eta, surge and pitch responses',0)

titles = {'V_t (m/s) &';'$\eta$ [m] &';'Surge $x_0$ [m] &';'Pitch $\theta$ [rad] &'};
loc_init = 6000; 
Mean = {[num2str(mean(vt(loc_init*2:end))) '&'] ;[num2str(mean(eta(loc_init*2:end))) '&'] ;[num2str(mean(q(loc_init:end,1))) '&'];[num2str(mean(q(loc_init:end,2))) '&' ]};
MAX = {[num2str(min(vt(loc_init*2:end))) '&'];[num2str(max(eta(loc_init*2:end))) '&'];[num2str(max(q(loc_init:end,1))) '&'];[num2str(max(q(loc_init:end,2))) '&']};
STD ={[num2str(min(vt(loc_init*2:end))) '&'];[num2str(std(eta(loc_init*2:end)))];[num2str(std(q(loc_init:end,1)))];[num2str(std(q(loc_init:end,2)))]};
MIN = {[num2str(min(vt(loc_init*2:end))) '&'];[num2str(min(eta(loc_init*2:end))) '&'];[num2str(min(q(loc_init:end,1))) '&'];[num2str(min(q(loc_init:end,2))) '&']};
mltable = table(Mean,MAX,MIN,STD,'RowNames',titles)

end
clear all
%% Question 14
fprintf('Steady wind and irregular waves')
for i=1
load('Q14.mat')
[maxi,loc]=max(psd_eta); % Surface elevation
[maxi2,loc2]=max(psd(:,1)); % Surge 
[maxi3,loc3]=max(psd(:,2)); % Pitch
figure()
subplot(3,2,1)
    plot(tspan_climates,eta,'b'); hold on;
    plot(tspan_climates(1:(end/2)),eta(1:(end/2)),'c'); ylim([min(eta)*1.1 max(eta)*1.1]);
    xlabel('t [s]'); ylabel('$\eta$ [m]'); grid on; box on;
    title('Time series')
subplot(3,2,2)
    plot(fpsd_eta,psd_eta,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
%     text(fpsd_eta(loc)*1.1,maxi,[num2str(fpsd(loc)) ' Hz'])
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on; 
    title('PSDs')
subplot(3,2,3)
    plot(tspan,q(:,1),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),1),'c'); 
    xlabel('t [s]'); ylabel('Surge $x_0$ [m]'); grid on; box on;
subplot(3,2,4)
    plot(fpsd,psd(:,1),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
%     text(fpsd(loc2)*1.1,maxi2,[num2str(fpsd(loc2)) ' Hz'])    
    xlim([0 0.2]);ylim([0 max(psd(:,1))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on;
subplot(3,2,5)
    plot(tspan,q(:,2),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),2),'c'); 
    xlabel('t [s]'); ylabel('Pitch $\theta$ [rad]'); grid on; box on;
subplot(3,2,6)
    plot(fpsd,psd(:,2),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); hold on;
%     text(fpsd(loc3)*1.1,maxi3,[num2str(fpsd(loc3)) ' Hz'])    
    xlim([0 0.2]); ylim([0 max(psd(:,2))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [rad$^2$/Hz]'); grid on; box on; 
printfig(20,15,'..\figures\Q14 - Eta, surge and pitch responses',0)

titles = {'$\eta$ [m] &';'Surge $x_0$ [m]&';'Pitch $\theta$ [rad] &'};
loc_init = 6000; 
Mean = {[num2str(mean(eta(loc_init*2:end))) '&'] ;[num2str(mean(q(loc_init:end,1))) '&'];[num2str(mean(q(loc_init:end,2))) '&' ]};
MAX = {[num2str(max(eta(loc_init*2:end))) '&'];[num2str(max(q(loc_init:end,1))) '&'];[num2str(max(q(loc_init:end,2))) '&']};
STD ={[num2str(std(eta(loc_init*2:end)))];[num2str(std(q(loc_init:end,1)))];[num2str(std(q(loc_init:end,2)))]};
MIN = {[num2str(min(eta(loc_init*2:end))) '&'];[num2str(min(q(loc_init:end,1))) '&'];[num2str(min(q(loc_init:end,2))) '&']};
mltable = table(Mean,MAX,MIN,STD,'RowNames',titles)
end   

clear all
%% Question 15
fprintf('Unsteady wind and irregular waves')
for i=1
load('Q15.mat')
[maxi,loc]=max(psd_eta); % Surface elevation
[maxi2,loc2]=max(psd(:,1)); % Surge 
[maxi3,loc3]=max(psd(:,2)); % Pitch
figure()
subplot(4,2,1)
    plot(tspan_climates,vt,'b'); hold on;
    plot(tspan_climates(1:(end/2)),vt(1:(end/2)),'c'); 
    xlabel('t [s]'); ylabel('$V_{\infty}$ [m/s]'); grid on; box on;
    title('Time series')
subplot(4,2,2)
    plot(fpsd_vt,psd_vt,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/s]'); grid on; box on; 
    title('PSDs')
subplot(4,2,3)
    plot(tspan_climates,eta,'b'); hold on;
    plot(tspan_climates(1:(end/2)),eta(1:(end/2)),'c'); ylim([min(eta)*1.1 max(eta)*1.1]);
    xlabel('t [s]'); ylabel('$\eta$ [m]'); grid on; box on;
subplot(4,2,4)
    plot(fpsd_eta,psd_eta,'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
%     text(fpsd_eta(loc)*1.1,maxi*0.9,[num2str(fpsd(loc)) ' Hz'])
    xlim([0 0.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on; 
subplot(4,2,5)
    plot(tspan,q(:,1),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),1),'c'); 
    xlabel('t [s]'); ylabel('Surge $x_0$ [m]'); grid on; box on;
subplot(4,2,6)
    plot(fpsd,psd(:,1),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); 
%     text(fpsd(loc2)*1.1,maxi2,[num2str(fpsd(loc2)) ' Hz'])    
    xlim([0 0.2]);ylim([0 max(psd(:,1))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [m$^2$/Hz]'); grid on; box on;
subplot(4,2,7)
    plot(tspan,q(:,2),'b'); hold on;
    plot(tspan(1:(end/2)),q(1:(end/2),2),'c'); 
    xlabel('t [s]'); ylabel('Pitch $\theta$ [rad]'); grid on; box on;
subplot(4,2,8)
    plot(fpsd,psd(:,2),'b'); 
    hold on; xline(0.00833,'--k'); hold on;xline(0.03167,'--r'); hold on;
%     text(fpsd(loc3)*1.1,maxi3,[num2str(fpsd(loc3)) ' Hz'])    
    xlim([0 0.2]); ylim([0 max(psd(:,2))*1.2])
    xlabel('Frequency [Hz]'); ylabel('$PSD$ [rad$^2$/Hz]'); grid on; box on; 
printfig(20,15,'..\figures\Q15 - Vt, Eta, surge and pitch responses',0)

titles = {'V_t (m/s) &';'$\eta$ [m] &';'Surge $x_0$ [m] &';'Pitch $\theta$ [rad] &'};
loc_init = 6000; 
Mean = {[num2str(mean(vt(loc_init*2:end))) '&'] ;[num2str(mean(eta(loc_init*2:end))) '&'] ;[num2str(mean(q(loc_init:end,1))) '&'];[num2str(mean(q(loc_init:end,2))) '&' ]};
MAX = {[num2str(min(vt(loc_init*2:end))) '&'];[num2str(max(eta(loc_init*2:end))) '&'];[num2str(max(q(loc_init:end,1))) '&'];[num2str(max(q(loc_init:end,2))) '&']};
STD ={[num2str(min(vt(loc_init*2:end))) '&'];[num2str(std(eta(loc_init*2:end)))];[num2str(std(q(loc_init:end,1)))];[num2str(std(q(loc_init:end,2)))]};
MIN = {[num2str(min(vt(loc_init*2:end))) '&'];[num2str(min(eta(loc_init*2:end))) '&'];[num2str(min(q(loc_init:end,1))) '&'];[num2str(min(q(loc_init:end,2))) '&']};
mltable = table(Mean,MAX,MIN,STD,'RowNames',titles)


end    
clear all        
        