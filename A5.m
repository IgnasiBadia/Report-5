% ===================================================================
% ===================================================================
% Course 46211
% Offshore Wind Energy 
% Assignment 5
% Written by. 
% Ignasi Badia (s202637@student.dtu.dk) and Asier Barbeito (s202422@student.dtu.dk)
% DTU Wind Energy
% ===================================================================
clear all; close all; clc;
% ===================================================================
set(0,'defaulttextInterpreter','latex'); 
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(0,'defaultAxesFontSize',12);
set(0, 'DefaultLineLineWidth', 1.1);
set(0, 'DefaultFigureRenderer', 'painters');
set(0,'DefaultFigureWindowStyle','docked') % docked

%% Data definition
global system wave data wind tspan mode tspan_climates controller

% Masses: 
data.Mf = 1.0897e7;  % [kg]
data.MTower = 5.4692e5; % kg
data.MNacelle = 446036; % kg    
data.MRotor = 227962; % kg

% Stiffness: 
data.KMoor = 66700; %N/m

% Center of mass:
data.z_CMf = - 105.95; % m
data.z_CMTower = 56.40; % m

% Inertia CM:
data.I_CMf = 1.1627e10; % kg m2
data.I_CMTower = 4.2168e8; % kg m2

% Geometry:
data.zHub = 119; % m
data.DSpar = 11.2; % m
data.zBot = -120; % m
data.h = 320; % m water depth
data.zMoor = -60; % m
data.A = pi*data.DSpar^2/4; % m^2

% Turbine
data.R = 178/2; %m rotor diameter
data.Arotor = pi*data.R^2;
data.Vrated = 11.4; %m/s
data.a = 0.5;
data.b = 0.65;
data.Ct_0 = 0.81;
data.rho_air = 1.22; %K/m^3

% Parameters:
data.Cm = 1.0;
data.CD = 0.6;
data.rho = 1025; %kg/m3
data.g = 9.81; % m/s2
%% Part 1: 
% Question 1
data.MTot = data.Mf + data.MNacelle + data.MRotor + data.MTower;
data.z_CMTot = (data.Mf*data.z_CMf + data.MTower*data.z_CMTower + ...
    data.MNacelle*data.zHub + data.MRotor*data.zHub)/data.MTot;
data.I_OTot = data.I_CMf + data.Mf*data.z_CMf^2 + data.I_CMTower +...
    data.MTower* data.z_CMTower^2 + (data.MNacelle+data.MRotor)*data.zHub^2;  

%Question 4 -- dalta demo report
data.Ix = (pi*data.DSpar^4)/64;
tau_boy = data.rho*data.g*data.Ix + data.MTot*data.g*(data.z_CMTot - data.zBot /2);

% Question 6
% Mass matrix
system.M = zeros(2,2);
system.M(1,1) = data.MTot;
system.M(1,2) = data.MTot*data.z_CMTot;
system.M(2,1) = system.M(1,2);
system.M(2,2) = data.I_OTot; 

% Added mass Matrix
system.A = zeros(2,2);
system.A(1,1) = -data.rho*data.Cm*data.zBot*data.A;
system.A(1,2) = -data.rho*data.Cm*data.zBot^2*data.A/2;
system.A(2,1) = system.A(1,2);
system.A(2,2) = -data.rho*data.Cm*data.zBot^3*data.A/3;

% Stiffness Matrix
system.C(1,1) = data.KMoor;
system.C(1,2)= data.KMoor*data.zMoor;
system.C(2,1) = system.C(1,2);
system.C(2,2)= data.KMoor*data.zMoor^2 - tau_boy;

% Stiffness Matrix
system.B = zeros(2,2);
system.B(1,1) = 2e5;

% Question 7 - Eigen value problem
[eigenvector, eigenvalue]=eig(system.C,system.A+system.M);
freq = sqrt(diag(eigenvalue))/(2*pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TDur = 1200;
deltaf = 1/TDur;
f = deltaf:deltaf:0.5;
deltaT = 0.1;
tspan= 0:deltaT:TDur - deltaT; %s
mode.controller = 0;

%% Question 10 - Decay test 
mode.decaytest = 1; % 1 if GF is for decay test 0
q0 = [1; 0; 0; 0];
q_surge = ode4(@dqdt, tspan, q0);
[psd_surge, fpsd_surge] = PSD(tspan, q_surge(:,1:2)); 
q0 = [0; 0.1; 0; 0];
q_pitch = ode4(@dqdt, tspan, q0);
[psd_pitch, fpsd_pitch] = PSD(tspan, q_pitch(:,1:2));
save('results/Q10.mat','q_pitch','q_surge','psd_pitch','fpsd_pitch','psd_surge',...
    'fpsd_surge','tspan')

%% Wave climate data
deltaT_climates = 0.05;
tspan_climates= 0:deltaT_climates:TDur - deltaT_climates; %s
wave.Hs = 6; %m
wave.Tp = 10; %s
wave.gamma = 3.3;
data.N = -data.zBot + 1; % Number of sections of draft
wave.z = linspace(data.zBot,0,data.N);
wind.V10 = 8; %mean steady wind at hub
wind.I = 0.14; %turbulence intensity
wind.l = 340.2; %m

%% Question 11 - inlcude hydrodinamic forcing
%Q11-a
mode.decaytest = 0; %GF calculation
mode.Wind = 0;
a = -data.zBot + 1; % Number of sections of draft
wave.z = linspace(data.zBot,0,a);
wave.U = zeros(length(wave.z), length(tspan_climates)); 
wave.dUdt = zeros(length(wave.z), length(tspan_climates));
q0 = [1; 0; 0; 0];
q_surge = ode4(@dqdt, tspan, q0);
[psd_surge, fpsd_surge] = PSD(tspan,q_surge(:,1:2)); 
q0 = [0; 0.1; 0; 0];
q_pitch = ode4(@dqdt, tspan, q0);
[psd_pitch, fpsd_pitch] = PSD(tspan, q_pitch(:,1:2));
save('results/Q11a.mat', 'q_pitch','q_surge','psd_pitch','fpsd_pitch','psd_surge',...
    'fpsd_surge','tspan')

%Q11-b
mode.decaytest = 1; %Fhyrdo disabled
q0 = [0; 1; 0; 0];
q_pitch_2 = ode4(@dqdt, tspan, q0);
[psd_pitch, fpsd_pitch] = PSD(tspan, q_pitch_2(:,1:2));
save('results/Q11b.mat','q_pitch_2', 'q_pitch','q_surge','psd_pitch','fpsd_pitch','psd_surge',...
    'fpsd_surge','tspan')

%% Question 12 - Regular waves and no wind
mode.decaytest = 0; %GF calculation if 0
mode.controller = 0;
mode.Wind = 0;
[wave.eta, wave.U,wave.dUdt] = RegularWaveTimeSeries(tspan_climates, data);
eta = wave.eta;

q0 = [0; 0; 0; 0];
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2)); 
[psd_eta, fpsd_eta] = PSD(tspan_climates(12000:end), wave.eta(12000:end)); 
save('results/Q12.mat','psd','fpsd','q','tspan','tspan_climates','psd_eta','fpsd_eta','eta')
%% Question 13 - Regular Waves and steady wind
mode.decaytest = 0; %GF calculation
mode.Wind = 1; % Wind force calc
mode.controller = 0;
%Steady wind
wind.V10 = 8; %mean steady wind at hub
wind.V_t = ones(1,length(tspan_climates))*wind.V10;
vt = wind.V_t;

q0 = [0; 0; 0; 0];
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2));
[psd_vt, fpsd_vt] = PSD(tspan_climates(12000:end), wind.V_t(12000:end)); 
[psd_eta, fpsd_eta] = PSD(tspan_climates(12000:end), wave.eta(12000:end)); 
save('results/Q13.mat','psd','fpsd','q','tspan','tspan_climates','psd_eta','psd_vt','eta','fpsd_vt','fpsd_eta','vt')
%% Question 14 - Irregular waves and steady wind
mode.decaytest = 0; %GF calculation
mode.Wind = 1; % Wind force calc
mode.controller = 0;
%wave time series
[wave.A, wave.eta, wave.U, wave.dUdt] = waveTimeSeries(f, tspan_climates, data);
eta = wave.eta;

q0 = [0; 0; 0; 0];
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2));
[psd_eta, fpsd_eta] = PSD(tspan_climates(12000:end), wave.eta(12000:end)); 
save('results/Q14.mat','psd','fpsd','q','tspan','tspan_climates','psd_eta','fpsd_eta','eta')
%% Question 15 - Irregular waves and unsteady wind (turbulence)
mode.Wind = 1; % Wind force calc
mode.decaytest = 0; %GF calculation
mode.controller = 0;
%Wind time series
[wind.V_t,wind.V_sum] = windTimeSeries(f, tspan_climates);
vt = wind.V_t;
% Wave time series
[wave.A, wave.eta, wave.U, wave.dUdt] = waveTimeSeries(f, tspan_climates, data);

q0 = [0; 0; 0; 0];
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2));
[psd_eta, fpsd_eta] = PSD(tspan_climates(12000:end), wave.eta(12000:end)); 
[psd_vt, fpsd_vt] = PSD(tspan_climates(12000:end), wind.V_t(12000:end)); 
save('results/Q15.mat','psd','eta','psd_eta','fpsd_eta','fpsd','q','tspan','tspan_climates','psd_vt','fpsd_vt','vt')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%PITCH CONTROL FOR DYNAMIC STABILITY%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Question 16 - no waves and steady wind 
V10 = [10, 16]; %mean steady wind at hub
mode.wind = 1; 
mode.controller = 0;
wave.U = zeros(length(wave.z), length(tspan_climates)); 
wave.dUdt = zeros(length(wave.z), length(tspan_climates));

q0 = [0; 0; 0; 0];
q = zeros(length(V10), length(tspan), 4);
for vi = 1:length(V10)
    wind.V10 = V10(vi); 
    wind.V_t = ones(1,length(tspan_climates))*wind.V10; 
    vt(vi,:) = wind.V_t;
    q(vi,:,:) = ode4(@dqdt, tspan, q0);
end
[psd, fpsd] = PSD(tspan(6000:end), q(:,6000:end,1:2));
save('results/Q16.mat','psd','fpsd','q','tspan','tspan_climates', 'vt')

%% Question 17 
controller.gamma = 2;
mode.controller = 1;
mode.wind = 1; 

q0 = [0; 0; 0; 0; 0];
wind.V10 = V10(2); 
wind.V_t = ones(1,length(tspan_climates))*wind.V10; 
vt = wind.V_t;
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2));
save('results/Q17.mat','psd','fpsd','q','tspan','tspan_climates','vt')

%% Question 18
controller.gamma = 0.4;
gamma = controller.gamma;
mode.controller = 1;
V10 = [10, 16]; %mean steady wind at hub
mode.wind = 1; 
wave.U = zeros(length(wave.z), length(tspan_climates)); 
wave.dUdt = zeros(length(wave.z), length(tspan_climates));

q0 = [0; 0; 0; 0; 0];
wind.V10 = V10(2); 
wind.V_t = ones(1,length(tspan_climates))*wind.V10; 
vt = wind.V_t;
q = ode4(@dqdt, tspan, q0);
[psd, fpsd] = PSD(tspan(6000:end), q(6000:end,1:2));
save('results/Q18.mat','psd','fpsd','q','tspan','tspan_climates','vt', 'gamma')


