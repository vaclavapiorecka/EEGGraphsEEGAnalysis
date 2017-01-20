function [ ] = exportTable( data, dataS, rows, names, path, sheet )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % Write MEANS
    xlswrite(path,rows,sheet,'A3')
    xlswrite(path,names,sheet,'C1')
    xlswrite(path,data,sheet,'C3')
    
    % Write STD
    xlswrite(path,rows,sheet,'A72')
    xlswrite(path,names,sheet,'C70')
    xlswrite(path,dataS,sheet,'C72')

end

