% Plot PSD
subplot(1,2,2), plot(fpsd,psd), hold on, xlim([0 0.5])
xlabel('Frequency [Hz]'), ylabel('PSD_{\eta} [m^2/Hz]')