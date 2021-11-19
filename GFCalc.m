function [GF] = GFCalc(x0Dot, pitchDot)
global data wave
%FORCES CALULATION
%Hydro
Fhydro = 0.5*data.rho*data.DSpar*data.CD *...
    trapz(wavz, (wave.u -(x0Dot + wave.z*pitchDot))*abs(wave.u -(x0Dot + wave.z*pitchDot)));
tau_hydro = 0.5*data.rho*data.DSpar*data.CD *...
    trapz(z, z*((wave.u -(x0Dot + wave-z*pitchDot))*abs(wave.u -(x0Dot + wave.z*pitchDot))));
GF = [Fhydro; tau_hydro];
end
