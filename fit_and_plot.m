function [ rmse ] = fit_and_plot(x,y,exc,type,clr)
% this function will take x, y, exclude certain x range, and then plot results.
% 
%         - inputs :
%                     1- x data points
%                     2- y data points
%                     3- exclude index
%                     4- type, if == 1 exclude <=, if 2 =>
%                           1 = rhs
%                           2= LHS
%                             
%          - outputs: 
%                     1- plot
%                     2- rmse
                    
                    
[xData, yData] = prepareCurveData( x, y );
% Set up fittype and options.
ft = fittype( 'poly1' );


if type == 1
    
    excludedPoints = xData < exc;

    
elseif type == 2
    
    excludedPoints = xData > exc;

    
    
end



opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Exclude = excludedPoints;
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.



if type ==1


        x_plot = [exc:length(x)];
y_plot = fitresult(x_plot);
plot(x_plot,y_plot,'-.sk','MarkerSize',7,'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6],'LineWidth',1.5)

elseif type ==2 %
    

    x_plot = [1:exc];
y_plot = fitresult(x_plot);

    plot(x_plot,y_plot,'-.dk','MarkerSize',7,'MarkerEdgeColor',[1 0.5 0],...
    'MarkerFaceColor',[ 1 0.9 0 ],'LineWidth',1.5)

    
end


rmse = gof.rmse;


end