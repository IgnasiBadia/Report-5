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
set(0,'DefaultFigureWindowStyle','normal') % docked

%% Data definition
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

% Question 6
% Added mass

A = zeros(2,2);
A(1,1) = -data.rho*data.Cm*data.zBot*data.A;
A(1,2) = -data.rho*data.Cm*data.zBot^2*data.A/2;
A(2,1) = A(1,2);
A(2,2) = -data.rho*data.Cm*data.zBot^3*data.A/3;

