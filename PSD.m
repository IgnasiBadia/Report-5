function [psd, fpsd] =  PSD(t, signal)
    df = 1/(t(end)-t(1)); % Frequency resolution
    fpsd= df*(0:length(t)-1); % Frequency vector starts from zero, as long as t
    signalhat = fft(signal)/length(t); % Fourier amplitudes
    signalhat(1) = 0; % Discard first value (mean)
    signalhat(round(length(fpsd)/2):end) = 0; % Discard all above Nyquist freq
    signalhat= 2*signalhat; % Make amplitudes one-sided
    psd= abs(signalhat).^2/2/df; % Calculate spectrum
end
