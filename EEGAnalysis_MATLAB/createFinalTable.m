function [ table ] = createFinalTable( data, positionOfElecs, namesOfCycles, numOfCycles )
%CREATEFINALTABLE Summary of this function goes here
%   Detailed explanation goes here
  
    
    tableRow = numOfCycles*2*size(positionOfElecs,1);
    tableCol = 56;
    
    table = zeros(tableRow,tableCol);
    
    for NOC = 1 : 1 : numOfCycles
        name = namesOfCycles{NOC,1};
        for NOE = 1 : 1 : size(positionOfElecs,1)
            table(((NOE-1)*numOfCycles*2+NOC),:) = data.(name).dataMEAN(positionOfElecs(NOE,1),:);
            table(((NOE-1)*numOfCycles*2+(numOfCycles+NOC)),:) = data.(name).dataSD(positionOfElecs(NOE,1),:);
        end    
    end

    assignin('base','table',table)
    
end

