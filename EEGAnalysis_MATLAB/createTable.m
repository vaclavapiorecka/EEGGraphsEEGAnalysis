function [ data ] = createTable(FileName,FilePath,typeOfData)
% CREATETABLE - Get data from sourcefile (for now just coherence).
% Detailed explanation goes here

    numOfFiles = size(FileName,2);
    
    switch typeOfData
    case 'Coherence'
        for nof = 1 : 1 : numOfFiles
            name = FileName{1,nof};
            wholeFile = strcat(FilePath,name);
        
            [dataMatrix, electrodeNames, frequencyBands] = importCoherence(wholeFile);
            name = ['data' num2str(nof)];
            data.(name).data = dataMatrix;
            data.(name).electrodes = electrodeNames;
            data.(name).frequency = frequencyBands;
        end
     case 'AbsolutePowerBands'
        for nof = 1 : 1 : numOfFiles
            name = FileName{1,nof};
            wholeFile = strcat(FilePath,name);
        
            [dataMatrix, electrodeNames, frequencyBands] = importAbsolutePowerBands(wholeFile);
            name = ['data' num2str(nof)];
            data.(name).data = dataMatrix;
            data.(name).electrodes = electrodeNames;
            data.(name).frequency = frequencyBands;
        end
     case 'AbsolutePower1Hz'
        for nof = 1 : 1 : numOfFiles
            name = FileName{1,nof};
            wholeFile = strcat(FilePath,name);
        
            [dataMatrix, electrodeNames, frequencyBands] = importAbsolutePower1Hz(wholeFile);
            name = ['data' num2str(nof)];
            data.(name).data = dataMatrix;
            data.(name).electrodes = electrodeNames;
            data.(name).frequency = frequencyBands;
        end
     case 'BVA1Hz'
        for nof = 1 : 1 : numOfFiles
            name = FileName{1,nof};
            wholeFile = strcat(FilePath,name);
        
            [dataMatrix, frequencyBands, electrodeNames] = importdataBVA(wholeFile);
            name = ['data' num2str(nof)];
            data.(name).data = dataMatrix;
            data.(name).electrodes = electrodeNames;
            data.(name).frequency = frequencyBands;
        end
end
