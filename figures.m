set(0,'defaulttextInterpreter','latex'); 
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(0,'defaultAxesFontSize',12);
set(0, 'DefaultLineLineWidth', 1.1);
set(0, 'DefaultFigureRenderer', 'painters');
set(0,'DefaultFigureWindowStyle','docked') % docked
clear all; close all; clc;
%% Question 10:
load('Q10.mat')
peak_PSD=findpeaks(psd_pitch(:,1));
peak_pitch(1) = find(psd_pitch(:,1)==peak_PSD(1));
peak_pitch(2) = find(psd_pitch(:,1)==peak_PSD(2));
peak_PSD=findpeaks(psd_surge(:,1));
peak_surge(1) = find(psd_surge(:,1)==peak_PSD(1));
peak_surge(2) = find(psd_surge(:,1)==peak_PSD(2));
figure(1)
subplot(2,1,1)
    yyaxis left
    plot(tspan,q_surge(:,1),'k')
    ylabel('$x_0$ [m]')
    yyaxis right
    plot(tspan,q_surge(:,2),'r')
    ylabel('$\theta$ [rad]')
    legend('Surge, $x_0$','Pitch, $\theta$')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    grid on;box on; 
    title('Decay test in surge: $x_0(0)=1$ m')
subplot(2,1,2)
    plot(fpsd_surge,psd_surge(:,1),'b');hold on;
    hold on; xline(fpsd_pitch(peak_surge(1)),'--k')
    hold on; xline(fpsd_pitch(peak_surge(2)),'--k')
    xlim([0 0.05])
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
    text(fpsd_pitch(peak_surge(1))+0.0005,max(psd_surge(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_surge(1))) 'Hz'])
    text(fpsd_pitch(peak_surge(2))+0.0005,max(psd_surge(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_surge(2))) 'Hz'])
printfig(18,12,'Q10 - Surge decay test',0)
    figure(2)
subplot(2,1,1)
    yyaxis left
    plot(tspan,q_pitch(:,1),'k')
    ylabel('$x_0$ [m]')
    yyaxis right
    plot(tspan,q_pitch(:,2),'r')
    ylabel('$\theta$ [rad]')
    legend('Surge, $x_0$','Pitch, $\theta$')
    ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
    grid on;box on; 
    title('Decay test in pitch: $\theta(0)=0.1$ rad')
subplot(2,1,2)
    plot(fpsd_pitch,psd_pitch(:,1),'b');hold on; 
    xline(fpsd_pitch(peak_pitch(1)),'--k')
    hold on; xline(fpsd_pitch(peak_pitch(2)),'--k')
    xlim([0 0.05])
    xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]'); box on; grid on;
    text(fpsd_pitch(peak_pitch(1))+0.0005,max(psd_pitch(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_pitch(1))) 'Hz'])
    text(fpsd_pitch(peak_pitch(2))+0.0005,max(psd_pitch(:,1))*0.9,['$f_2=$' num2str(fpsd_pitch(peak_pitch(2))) 'Hz'])
printfig(18,12,'Q10 - Pitch decay test',0)
    