%% info:

%{ lab 2, for more info, go ti ./Info 

%}

%% housekeepin

clear
clc
close all

%% read data

addpath('./Info');
addpath('./Data');

Raw = importdata('3112labgroup1'); % raw data


% note: all units converted from english to SI
LoadingCase =  Raw.data(:,1);
F0 = Raw.data(:,2).*4.44822; % Load cell 1, N
F1 = Raw.data(:,3).*4.44822; % Load cell 2, N
F2 = Raw.data(:,4).*4.44822; % Load cell 3, N
F3D = Raw.data(:,5).*4.44822; % inline load cell, N
LVDT = Raw.data(:,6).*25.4; % LVDT in inches

% note: every 10 data points are a case:

freq = 0:10:length(F0);


for i = 1:length(freq)-1
    
    F0_av(i) = mean(F0((freq(i)+1):freq(i+1)));
    F1_av(i) = mean(F1((freq(i)+1):freq(i+1)));
    F2_av(i) = mean(F2((freq(i)+1):freq(i+1)));
    F3D_av(i) = mean(F3D((freq(i)+1):freq(i+1)));
    LVDT_av(i) = mean(LVDT((freq(i)+1):freq(i+1)));

end

x_values = 1:length(LVDT_av);

%% plotting

% the following section is for all plots:


%% figure 1: Load cell 0:

figure(1)
plot(F0_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_F0 ] = fit_and_plot(x_values,F0_av,6,2);
[ rmse_right_F0 ] = fit_and_plot(x_values,F0_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(F0_av)-0.2 max(F0_av)+5])

title('Load cell 1 force measurments for different loading cases');
xlabel('Loading case')
ylabel('Force [N]');
grid minor

%   saveas(figure(1),'figure1.jpg');
  
  print(gcf,'figure1.png','-dpng','-r300');


%% figure 2: load cell 1

figure(2)
plot(F1_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_F1 ] = fit_and_plot(x_values,F1_av,6,2);
[ rmse_right_F1 ] = fit_and_plot(x_values,F1_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(F1_av)-0.2 max(F1_av)+0.7])


title('Load cell 2 force measurments for different loading cases');
xlabel('Loading case')
ylabel('Force [N]');
grid minor

  print(gcf,'figure2.png','-dpng','-r300');



%% figure 3 : load cell 2

figure(3)

plot(F2_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_F2 ] = fit_and_plot(x_values,F2_av,6,2);
[ rmse_right_F2 ] = fit_and_plot(x_values,F2_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(F2_av)-0.2 max(F2_av)+0.7])


title('Load cell 3 force measurments for different loading cases');
xlabel('Loading case')
ylabel('Force [N]');
grid minor


  print(gcf,'figure3.png','-dpng','-r300');

%% figure 4: Total cells

figure(4)

plot(F2_av+F1_av+F0_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_F_total ] = fit_and_plot(x_values,F2_av+F1_av+F0_av,6,2);
[ rmse_right_F_total ] = fit_and_plot(x_values,F2_av+F1_av+F0_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(F2_av+F1_av+F0_av)-0.2 max(F2_av+F1_av+F0_av)+0.7])



title('Sum of all load cells force measurments for different loading cases');
xlabel('Loading case')
ylabel('Force [N]');
grid minor

  print(gcf,'figure4.png','-dpng','-r300');

%% figure 5: Internal force cell

figure(5)


plot(F3D_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_F3D ] = fit_and_plot(x_values,F3D_av,6,2);
[ rmse_right_F3D ] = fit_and_plot(x_values,F3D_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(F3D_av)-0.2 max(F3D_av)+30])

title('Internal forces load cell');
xlabel('Loading case')
ylabel('Force [N]');
grid minor


  print(gcf,'figure5.png','-dpng','-r300');


%% Figure 6: LVDT Results

figure(6)


plot(LVDT_av,'-ok','MarkerSize',7,'MarkerEdgeColor','blue',...
    'MarkerFaceColor',[ 0 0.5 1 ],'LineWidth',1.5)

hold on
[ rmse_left_LVDT ] = fit_and_plot(x_values,LVDT_av,6,2);
[ rmse_right_LVDT ] = fit_and_plot(x_values,LVDT_av,6,1);

hold off
legend('Experimental data','Left side fit','right side fit')
ylim([min(LVDT_av)-0.02 max(LVDT_av)+0.02])


title('LVDT measurments ');
xlabel('Loading case')
ylabel('LVDT Displacement [mm]');
grid minor
  print(gcf,'figure6.png','-dpng','-r300');


%% output rmse in table:

RHS_RMSE = [ rmse_right_F0 ;rmse_right_F1 ;rmse_right_F2;rmse_right_F_total ;rmse_right_F3D; rmse_right_LVDT ] ;
LHS_RMSE = [ rmse_left_F0; rmse_left_F1; rmse_left_F2; rmse_left_F_total; rmse_left_F3D; rmse_left_LVDT ] ;
Names = { 'F0';'F1';'F2';'Ftotal';'F3D';'LVDT'};

table(Names,RHS_RMSE,LHS_RMSE)

