function [ data, statData ] = statisticData( data )
%STATISTICCOHERENCE Summary of this function goes here
%   Detailed explanation goes here

    names = fieldnames(data);
    numNames = size(names,1);
    numOfElecs = size(data.data1.data,1);
    
    for numOfData = 1 : 1 : numOfElecs
        for numOfNames = 1 : 1 : numNames
            helpName = char(names(numOfNames,1));
            helpHelp = data.(helpName).data;
            helpData(numOfNames,:) = helpHelp(numOfData,:);
        end
        
        data.statData(:,:,numOfData) = helpData;
        
        mean1 = mean(helpData);
        data.mean(numOfData,:) = mean1;
        
        std1 = std(helpData);
        data.std(numOfData,:) = std1;
        
    end
    
end

