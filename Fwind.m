function [F_wind] =Fwind(x0Dot, pitchDot, indx)
global data wind
if wind.V10 <= data.Vrated
    Ct  = data.Ct_0;
else
    Ct = data.Ct_0*exp(-data.a*(wind.V10 - data.Vrated)^...
        (data.b));
end
F_mean = 0.5*data.rho_air*data.Arotor*Ct*wind.V10^2;
    

Vhub_real = wind.V_t(indx) - (x0Dot + data.zHub*pitchDot);
if Vhub_real <= data.Vrated
    Ct  = data.Ct_0;
else
    Ct = data.Ct_0*exp(-data.a*(Vhub_real - data.Vrated)^...
        (data.b));
end
F_wind_tilde = 0.5*data.rho_air*data.Arotor.*Ct.*abs(Vhub_real).*...
                (Vhub_real);


if wind.V10 <= data.Vrated
    fred = 0.54;
else
    fred = 0.54 + 0.027*(wind.V10 - data.Vrated);
end
F_wind = F_mean + fred.*(F_wind_tilde - F_mean);
    
    
end