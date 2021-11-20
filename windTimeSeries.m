function [V_t,V_sum] = windTimeSeries(f, t)
    global wind
    deltaF = f(2) - f(1);
    Sw = (4*wind.I^2*wind.V10*wind.l)./(1 + 6.*f.*wind.l./wind.V10).^(5/3);
    bp = sqrt(2.*Sw.*deltaF);
    ep = 2*pi*rand(1, length(f));
    wp = 2*pi.*f;
    V_sum = zeros(1, length(t));
    for ti = 1:length(t)
        V_sum(ti) = wind.V10 + sum(bp.*cos(wp.*t(ti) + ep));
    end
    
    M = length(t);
    V_t= wind.V10+ M*real(ifft(pad2( bp.*exp(1i.*ep) ,M))); 
end