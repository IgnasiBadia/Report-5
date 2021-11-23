function [GF] = GFCalc(x0Dot, pitchDot, ti)
global data tspan wave mode wind tspan_climates
%FORCES CALULATION

%Hydro
indx = round((ti - tspan(1))/(tspan(2)-tspan(1))) + 1; 


indx_c = round((ti - tspan_climates(1))/(tspan_climates(2)-...
    tspan_climates(1))) + 1; % Index inside the climate time series: dif...
    % lengths of tspan and tspan_climates 

Fhydro = data.rho*data.A*(data.Cm + 1)*trapz(wave.z, wave.dUdt(:,indx_c)') + ... 
        0.5*data.rho*data.DSpar*data.CD *...
        trapz(wave.z, (wave.U(:,indx_c)' - (x0Dot + wave.z*pitchDot)).*...
        abs(wave.U(:,indx_c)' -(x0Dot + wave.z*pitchDot)));

tau_hydro = data.rho*data.A*(data.Cm + 1)*trapz(wave.z, wave.z.*wave.dUdt(:,indx_c)') + ... 
        0.5*data.rho*data.DSpar*data.CD *...
        trapz(wave.z, wave.z.*((wave.U(:,indx_c)' -(x0Dot + wave.z*pitchDot)).*...
        abs(wave.U(:,indx_c)'-(x0Dot + wave.z*pitchDot))));
wave.F(indx) = Fhydro;
   
%Wind
if mode.Wind == 0 % No wind
    GF = [Fhydro; tau_hydro];
elseif mode.Wind == 1 %Fwind calculation
    F_wind = Fwind(x0Dot, pitchDot, ti);
    tau_wind = F_wind*data.zHub;
    GF = [Fhydro + F_wind ; tau_hydro + tau_wind];
    wind.F(indx) = F_wind;
end  

mode.GF(:,indx)=GF;
end
