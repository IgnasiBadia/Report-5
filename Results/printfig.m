function [] = printfig(X, Y,name, shouldprint)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if shouldprint== 1
        set(gcf,'PaperUnits','centimeters','PaperSize',[X Y])
        fig = gcf;fig.PaperUnits = 'centimeters'; 
        fig.PaperPosition = [0 0 X Y];fig.Units = 'centimeters';
        fig.PaperSize=[X Y];
        print(fig,name,'-dpdf','-r200')
else 
    
end
end

