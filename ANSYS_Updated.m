%% Info:

%{ this code will extend the analysis to ANSYS model }%.

clear
clc
close all


%% ANSYS:

% assuming linear elastic behavior:
type_support = 'E = 70 GPa, hollow cross-section with 1% random variation, increased area, to account for';
type_support2 = ' error in displacements and areas, left side pin support, and right side roller'; % Waht support type used for ANSYS
addpath('./Updated ANSYS Results/Left_Pinned_Right_Roller'); % add ansys files to path,

Internal_force_filename = 'forces_E_70_A_increased_hollow_nodes_displaced.csv';
Reaction_force_filename = 'reac_forces_E_70_A_increased_hollow_nodes_displaced.csv';
Displacement_filename = 'disp_E_70_A_increased_hollow_nodes_displaced.csv';
%% internal force in bars:

% we want node 58 which is at line 405
Internal = ANSYS_Force(Internal_force_filename,[405 406]); % read whatever lines from internal force 

MidElm = Internal{:,:}; % element in the middel
% col 1 : node
% col 2 3 4 : force in x y z.
InternalF = sqrt(MidElm(1,2)^2 + MidElm(1,3)^2 + MidElm(1,4)^2 );
%InternalF = InternalF.*10^3; % convert to N from KN;

LoadingCase = [ 1 6 11 ] ;
figure(1)

plot(LoadingCase, [0 InternalF 0],'-.ok','MarkerSize',7,'MarkerEdgeColor',[0 0.8 0.2],...
    'MarkerFaceColor',[ 0 0.6 0.1],'LineWidth',1.5);

grid minor

xlabel('Loading Case')
ylabel('Internal Force [N]')
title({'Internal forces in midspan bar predicted by ANSYS model for', type_support,type_support2})
print(gcf,['Internal_ANSYS_' type_support type_support2 '.png'],'-dpng','-r300');

%% midspan displacement

% midspan is also 58:
Displacement = ANSYS_Force(Displacement_filename,[78 79]); % read whatever lines from internal force 
MidElm = Displacement{:,:}; % element in the middel
% col 1 : node
% col 2 3 4 : force in x y z.
MidDsplacement = MidElm(1,4);


LoadingCase = [ 1 6 11 ] ;
figure(2)

plot(LoadingCase, abs([0 MidDsplacement 0]),'-.ok','MarkerSize',7,'MarkerEdgeColor',[0 0.8 0.2],...
    'MarkerFaceColor',[ 0 0.6 0.1],'LineWidth',1.5);

grid minor

xlabel('Loading Case')
ylabel('Displacement [mm]')
title({'Midspan nodal displacement as predicted by ANSYS model for', type_support,type_support2})
print(gcf,['Displacement_ANSYS_ ' type_support type_support2 '.png'],'-dpng','-r300');


%% reaction forces:

% we will only consider total reaction forces:

% midspan is also 58:
Reactions = ANSYS_Force(Reaction_force_filename,[18 19]); % read whatever lines from internal force 
TotalRections = Reactions{:,:}; % element in the middel
% col 1 : node
% col 2 3 4 : force in x y z.
TotalRections = TotalRections(1,4);


LoadingCase = [ 1 6 11 ] ;
figure(3)

plot(LoadingCase, abs([0 TotalRections 0]),'-.ok','MarkerSize',7,'MarkerEdgeColor',[0 0.8 0.2],...
    'MarkerFaceColor',[ 0 0.6 0.1],'LineWidth',1.5);

grid minor

xlabel('Loading Case')
ylabel('Reaction force [N]')
title({'Total reaction forces as predicted by ANSYS model for', type_support, type_support2})
print(gcf,['Reactions_ANSYS_ ' type_support type_support2 '.png'],'-dpng','-r300');
