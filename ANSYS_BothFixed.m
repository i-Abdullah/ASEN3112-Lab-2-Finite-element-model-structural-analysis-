%% Info:

%{ this code will extend the analysis to ANSYS model }%.

clear
clc
close all


%% ANSYS:

% assuming linear elastic behavior:
type_support = 'both fixed'; % Waht support type used for ANSYS
addpath('./ANSYS Results/'); % add ansys files to path,
addpath('./ANSYS Results/Both Fixed'); % add ansys files to path,

%% internal force in bars:

% we want node 58 which is at line 405
Internal = ANSYS_Force('forces.csv',[405 406]); % read whatever lines from internal force 

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
title(['Internal forces in midspan bar predicted by ANSYS model for ' type_support])
print(gcf,['Internal_ANSYS_' type_support '.png'],'-dpng','-r300');

%% midspan displacement

% midspan is also 58:
Displacement = ANSYS_Force('displacement.csv',[78 79]); % read whatever lines from internal force 
MidElm = Displacement{:,:}; % element in the middel
% col 1 : node
% col 2 3 4 : force in x y z.
MidDsplacement = MidElm(1,4);


LoadingCase = [ 1 6 11 ] ;
figure(2)

plot(LoadingCase, [0 MidDsplacement 0],'-.ok','MarkerSize',7,'MarkerEdgeColor',[0 0.8 0.2],...
    'MarkerFaceColor',[ 0 0.6 0.1],'LineWidth',1.5);

grid minor

xlabel('Loading Case')
ylabel('Displacement [mm]')
title(['Midspan nodal displacement as predicted by ANSYS model for ' type_support])
print(gcf,['Displacement_ANSYS_ ' type_support '.png'],'-dpng','-r300');
