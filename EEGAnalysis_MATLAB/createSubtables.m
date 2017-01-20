function [ data ] = createSubtables(data, dataNames)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
        [numOfRow, numOfCol] = size(data.(dataNames).data01.std);
        dataSD = zeros(numOfRow,4*numOfCol);        % *4 odpovídají ètyøi èasy mìøení
        data.(dataNames).dataSD = dataSD;           
        dataMEAN = zeros(numOfRow,4*numOfCol);
        data.(dataNames).dataMEAN = dataMEAN;       
        
        for numOfElecs = 1 : 1 : numOfRow
            for numOfFreq = 1 : 1 : numOfCol
                data.(dataNames).dataSD(numOfElecs,4*(numOfFreq-1)+1) = data.(dataNames).data01.std(numOfElecs,numOfFreq);
                data.(dataNames).dataSD(numOfElecs,4*(numOfFreq-1)+2) = data.(dataNames).data02.std(numOfElecs,numOfFreq);
                data.(dataNames).dataSD(numOfElecs,4*(numOfFreq-1)+3) = data.(dataNames).data03.std(numOfElecs,numOfFreq);
                data.(dataNames).dataSD(numOfElecs,4*(numOfFreq-1)+4) = data.(dataNames).data04.std(numOfElecs,numOfFreq);
                
                data.(dataNames).dataMEAN(numOfElecs,4*(numOfFreq-1)+1) = data.(dataNames).data01.mean(numOfElecs,numOfFreq);
                data.(dataNames).dataMEAN(numOfElecs,4*(numOfFreq-1)+2) = data.(dataNames).data02.mean(numOfElecs,numOfFreq);
                data.(dataNames).dataMEAN(numOfElecs,4*(numOfFreq-1)+3) = data.(dataNames).data03.mean(numOfElecs,numOfFreq);
                data.(dataNames).dataMEAN(numOfElecs,4*(numOfFreq-1)+4) = data.(dataNames).data04.mean(numOfElecs,numOfFreq);
            end
        end
       
    

end

