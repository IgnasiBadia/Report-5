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
% load('Q10.mat')
% peak_PSD=findpeaks(psd_pitch(:,1));
% peak_pitch(1) = find(psd_pitch(:,1)==peak_PSD(1));
% peak_pitch(2) = find(psd_pitch(:,1)==peak_PSD(2));
% peak_PSD=findpeaks(psd_surge(:,2));
% peak_surge(1) = find(psd_surge(:,2)==peak_PSD(1));
% peak_surge(2) = find(psd_surge(:,2)==peak_PSD(2));
% 
% % SURGE decay test 
% figure()
% subplot(2,1,1)
%     yyaxis left
%     plot(tspan,q_surge(:,1),'k')
%     ylabel('$x_0$ [m]')
%     yyaxis right
%     plot(tspan,q_surge(:,2),'r')
%     ylabel('$\theta$ [rad]'); xlabel('t [s]')
%     legend('Surge, $x_0$','Pitch, $\theta$')
%     ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
%     grid on;box on; 
%     title('Decay test in surge: $x_0(0)=1$ m')
% subplot(2,1,2)
%     yyaxis left
%     plot(fpsd_surge,psd_surge(:,1),'k');hold on;
%     xlim([0 0.05])
%     xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
%     text(fpsd_pitch(peak_surge(1))+0.0005,max(psd_surge(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_surge(1))) 'Hz'])
%     text(fpsd_pitch(peak_surge(2))+0.0005,max(psd_surge(:,1))*0.5,['$f_2=$' num2str(fpsd_pitch(peak_surge(2))) 'Hz'])
%     yyaxis right
%     plot(fpsd_surge,psd_surge(:,2),'r');hold on;
%     ylabel('PSD [rad$^2$/Hz]'); ylim([0 7e-6])
%     hold on; xline(fpsd_pitch(peak_surge(1)),'--k')
%     hold on; xline(fpsd_pitch(peak_surge(2)),'--k')
%     legend('Surge, $x_0$','Pitch, $\theta$','Location','best')
%     ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
%     grid on;box on; 
%     printfig(18,12,'Q10 - Surge decay test',0)
% 
% figure()
% subplot(2,1,1)
%     yyaxis left
%     plot(tspan,q_pitch(:,1),'k')
%     ylabel('$x_0$ [m]')
%     yyaxis right
%     plot(tspan,q_pitch(:,2),'r')
%     ylabel('$\theta$ [rad]'); xlabel('t [s]')
%     legend('Surge, $x_0$','Pitch, $\theta$')
%     ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
%     grid on;box on; 
%     title('Decay test in pitch: $\theta(0)=0.1$ rad')
% subplot(2,1,2)
%     yyaxis left
%     plot(fpsd_pitch,psd_pitch(:,1),'k');hold on; 
%     xlim([0 0.05])
%     xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]'); box on; grid on;
%     text(fpsd_pitch(peak_pitch(1))+0.0005,max(psd_pitch(:,1))*0.9,['$f_1=$' num2str(fpsd_pitch(peak_pitch(1))) 'Hz'])
%     text(fpsd_pitch(peak_pitch(2))-0.008,max(psd_pitch(:,1))*0.9,['$f_2=$' num2str(fpsd_pitch(peak_pitch(2))) 'Hz'])
%     yyaxis right
%     plot(fpsd_pitch,psd_pitch(:,2),'r')
%     xline(fpsd_pitch(peak_pitch(1)),'--k')
%     hold on; xline(fpsd_pitch(peak_pitch(2)),'--k')
%     ax = gca; ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'r';
%     legend('Surge, $x_0$','Pitch, $\theta$','Location','best')
%     ylabel('PSD [rad$^2$/Hz]')
%     printfig(18,12,'Q10 - Pitch decay test',0)
 end
clear all;
%% Question 11
for i=1
% Q10 = load('Q10.mat');
% Q11 = load('Q11.mat');
% tspan = Q10.tspan;
% peak_PSD=findpeaks(Q10.psd_pitch(:,1));
% peak_pitch(1) = find(Q10.psd_pitch(:,1)==peak_PSD(1));
% peak_pitch(2) = find(Q10.psd_pitch(:,1)==peak_PSD(2));
% peak_PSD=findpeaks(Q10.psd_surge(:,2));
% peak_surge(1) = find(Q10.psd_surge(:,2)==peak_PSD(1));
% peak_surge(2) = find(Q10.psd_surge(:,2)==peak_PSD(2));
% 
% % SURGE decay test 
% figure()
% subplot(2,2,1)
%     plot(tspan,Q10.q_surge(:,1),'k');hold on;
%     plot(tspan,Q11.q_surge(:,1),'g');
%     xlabel('t [s]')
%     ylabel('$x_0$ [m]');grid on;box on; 
%     legend('No Hydro force','Hydro force','Location','best')
%     title('Surge and Pitch time series')
% subplot(2,2,3)
%     plot(tspan,Q10.q_surge(:,2),'k'); hold on; 
%     plot(tspan,Q11.q_surge(:,2),'g');
%     ylabel('$\theta$ [rad]'); xlabel('t [s]')
%     grid on;box on; 
% subplot(2,2,2)
%     plot(Q10.fpsd_surge,Q10.psd_surge(:,1),'k');hold on;
%     plot(Q11.fpsd_surge,Q10.psd_surge(:,1),'g');
%     hold on; xline(Q10.fpsd_pitch(peak_surge(1)),'--k')
%     title('Surge and Pitch PSD')
%     xlim([0 0.05]); grid on; box on
%     xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
%     text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_surge(:,1))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_surge(1))) 'Hz'])
% subplot(2,2,4)
%     plot(Q10.fpsd_surge,Q10.psd_surge(:,2),'k');hold on;
%     plot(Q10.fpsd_surge,Q11.psd_surge(:,2),'g');
%     text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_surge(:,2))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_surge(1))) 'Hz'])
%     text(Q10.fpsd_pitch(peak_surge(2))+0.0005,max(Q10.psd_surge(:,2))*0.5,['$f_2=$' num2str(Q10.fpsd_pitch(peak_surge(2))) 'Hz'])
%     ylabel('PSD [rad$^2$/Hz]'); ylim([0 7e-6])
%     hold on; xline(Q10.fpsd_pitch(peak_surge(1)),'--k')
%     hold on; xline(Q10.fpsd_pitch(peak_surge(2)),'--k');xlim([0 0.05])
%     grid on;box on; 
%     printfig(23,12,'Q11 - Surge decay test comparison',1)
% 
% % Pitch decay test 
% figure()
% subplot(2,2,1)
%     plot(tspan,Q10.q_pitch(:,1),'k');hold on;
%     plot(tspan,Q11.q_pitch(:,1),'g');
%     xlabel('t [s]')
%     ylabel('$x_0$ [m]');grid on;box on; 
%     legend('No Hydro force','Hydro force','Location','best')
%     title('Surge and Pitch time series')
% subplot(2,2,3)
%     plot(tspan,Q10.q_pitch(:,2),'k'); hold on; 
%     plot(tspan,Q11.q_pitch(:,2),'g');
%     ylabel('$\theta$ [rad]');  xlabel('t [s]')
%     grid on;box on; 
% subplot(2,2,2)
%     plot(Q10.fpsd_pitch,Q10.psd_pitch(:,1),'k');hold on;
%     plot(Q11.fpsd_pitch,Q10.psd_pitch(:,1),'g');
%     hold on; xline(Q10.fpsd_pitch(peak_pitch(1)),'--k')
%     title('Surge and Pitch PSD')
%     xlim([0 0.05]); grid on; box on
%     xlabel('Frequency [Hz]'), ylabel('PSD [m$^2$/Hz]');box on; grid on;
%     text(Q10.fpsd_pitch(peak_surge(1))+0.0005,max(Q10.psd_pitch(:,1))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_pitch(1))) 'Hz'])
% subplot(2,2,4)
%     plot(Q10.fpsd_surge,Q10.psd_pitch(:,2),'k');hold on;
%     plot(Q10.fpsd_surge,Q11.psd_pitch(:,2),'g');
%     text(Q10.fpsd_pitch(peak_pitch(1))+0.0005,max(Q10.psd_pitch(:,2))*0.9,['$f_1=$' num2str(Q10.fpsd_pitch(peak_pitch(1))) 'Hz'])
%     text(Q10.fpsd_pitch(peak_pitch(2))+0.0005,max(Q10.psd_pitch(:,2))*0.5,['$f_2=$' num2str(Q10.fpsd_pitch(peak_pitch(2))) 'Hz'])
%     ylabel('PSD [rad$^2$/Hz]');
%     hold on; xline(Q10.fpsd_pitch(peak_pitch(1)),'--k')
%     hold on; xline(Q10.fpsd_pitch(peak_pitch(2)),'--k');xlim([0 0.05])
%     grid on;box on; 
%     printfig(23,12,'Q11 - Pitch decay test comparison',1)
end    
%% Question ...