function [GF] = GFCalc(x0Dot, pitchDot, ti)
global data tspan wave mode
%FORCES CALULATION
%Hydro
indx = round((ti - tspan(1))/(tspan(2)-tspan(1))) + 1;
Fhydro = 0.5*data.rho*data.DSpar*data.CD *...
    trapz(wave.z, (wave.U(:,indx)' - (x0Dot + wave.z*pitchDot)).*...
    abs(wave.U(:,indx)' -(x0Dot + wave.z*pitchDot)));

tau_hydro = 0.5*data.rho*data.DSpar*data.CD *...
    trapz(wave.z, wave.z.*((wave.U(:,indx)' -(x0Dot + wave.z*pitchDot)).*...
    abs(wave.U(:,indx)'-(x0Dot + wave.z*pitchDot))));

%Wind
if mode.Wind == 1
    F_wind = Fwind(x0Dot, pitchDot, indx);
    tau_wind = F_wind*data.zHub;
    GF = [Fhydro + F_wind ; tau_hydro + tau_wind];
else
    F_wind = 0;
    tau_wind = 0;
    GF = [Fhydro + F_wind ; tau_hydro + tau_wind];
end  
end
