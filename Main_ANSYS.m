%% Info:

%{ this code will extend the analysis to ANSYS model }%.

clear
clc
close all


%% ANSYS:

% assuming linear elastic behavior:


%% internal force in bars:

% we want node 58 which is at line 505
addpath('./ANSYS Results/'); % add ansys files to path,
Internal = ANSYS_Force('Internal Bar Forces.csv',[505 506]); % read whatever lines from internal force 

MidElm = Internal{:,:}; % element in the middel
% col 1 : node
% col 2 3 4 : force in x y z.
InternalF = sqrt(MidElm(1,2)^2 + MidElm(1,3)^2 + MidElm(1,4)^2 );
InternalF = InternalF.*10^3; % convert to N from KN;

LoadingCase = [ 1 6 11 ] ;
figure(1)

plot(LoadingCase, [0 InternalF 0],'-.ok','MarkerSize',7,'MarkerEdgeColor',[0 0.8 0.2],...
    'MarkerFaceColor',[ 0 0.6 0.1],'LineWidth',1.5);

grid minor

xlabel('Loading Case')
ylabel('Internal Force [N]')
title('Internal forces in midspan bar predicted by ANSYS model')

%% reation forces
