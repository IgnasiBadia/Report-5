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
global system

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
data.h = 320; % m
data.zMoor = -60; % m
data.A = pi*data.DSpar^2/4; % m^2
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

%% Part 2
TDur = 600;
deltaT = 0.1;
deltaf = 1/TDur;
f = deltaf:deltaf:0.5;
tspan= 0:deltaT:TDur - deltaT; %s

%Question 10
q0 = [1; 0; 0; 0];
q_surge = ode4(@dqdt, tspan, q0, system);
[psd_surge, fpsd_surge] = PSD(tspan, q_surge); 
q0 = [0; 0.1; 0; 0];
q_pitch = ode4(@dqdt, tspan, q0, system);
[psd_pitch, fpsd_pitch] = PSD(tspan, q_pitch);

%Question 11 - inlcude hydrodinamic forcing



