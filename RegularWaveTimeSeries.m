function [eta, u, a] = RegularWaveTimeSeries(t, data)
global wave
x =0; % data.DSpar/2; % ?
T = wave.Tp;
H = wave.Hs;
h = data.h;
omega = 2*pi/T;

f = 1/T;               
k=kSolve(f,data.g, h); %wave number[1/m]

% W_parameters = 0;  %Still water level
eta = H/2*cos(omega.*t-k.*x);    % Surface elevation 
for i= 1:data.N
    u(i,:) = (omega*H)/2.*cosh(k.*(wave.z(i)+h))./(sinh(k*h)).*cos(omega.*t-k*x); %Horizontal velocity
    a(i,:) = -(omega^2*H)/2.*cosh(k.*(wave.z(i)+h))./(sinh(k*h)).*sin(omega.*t-k*x); %Horizontal acceleration
end
end