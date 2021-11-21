function [F_wind] =Fwind(x0Dot, pitchDot,ti)
global data wind mode tspan_climates 

V = interp1(tspan_climates,wind.V_t,ti); % Interpolate as the time... 
% climate time series has different numer of time steps than tspan

% Steady wind
% Thrust coefficient
if wind.V10 <= data.Vrated
    Ct  = data.Ct_0;
else
    Ct = data.Ct_0*exp(-data.a*(wind.V10 - data.Vrated)^...
        (data.b));
end

F_mean = 0.5*data.rho_air*data.Arotor*Ct*wind.V10^2;
    
Vhub_rel = V - (x0Dot + data.zHub*pitchDot);

if Vhub_rel <= data.Vrated
    Ct  = data.Ct_0;
else
    Ct = data.Ct_0*exp(-data.a*(Vhub_rel - data.Vrated)^...
        (data.b));
end
F_wind_tilde = 0.5*data.rho_air*data.Arotor.*Ct.*abs(Vhub_rel).*...
                (Vhub_rel);
            
if mode.Wind==1 % Steady wind
    F_wind = F_wind_tilde;
elseif mode.Wind==2 % Unsteady wind
    if wind.V10 <= data.Vrated
        fref = 0.54;
    else
        fref = 0.54 + 0.027*(wind.V10 - data.Vrated);
    end
    F_wind = F_mean + fref.*(F_wind_tilde - F_mean);
end    

end