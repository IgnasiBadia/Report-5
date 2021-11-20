function [eta, u, a] = RegularWaveTimeSeries(t, data)
global wave
x = data.DSpar/2;
T = wave.Tp;
H = wave.Hs;
h = -data.zBot;
omega = 2*pi/T;

f = 1/T;               
k=kSolve(f,data.g, h); %wave number[1/m]

W_parameters = 0;  %Still water level
eta = H/2*cos(omega.*t-k.*x);    % Surface elevation 
u = (omega*H)/2*cosh(k*(W_parameters+h))/(sinh(k*h))*cos(omega.*t-k*x); %Horizontal velocity
a = -(omega^2*H)/2*cosh(k*(W_parameters+h))/(sinh(k*h))*sin(omega.*t-k*x); %Horizontal velocity
end