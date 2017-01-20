function [ position ] = elecsPos(data,dataNames)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    namesOfElecs = ['F4-C4'; 'F4-P4'; 'F4-P6'; 'F4-T4'; 'F4-T6'; 'F4-T4'; 'C4-P4'; 'C4-P6'; 'C4-T4'; 'C4-T6'; 'P4-P6'; 'P4-T4'; 'P4-T6'; 'P6-T4'; 'P6-T6'; 'T4-T6'; 'F3-C3'; 'F3-P3'; 'F3-P5'; 'F3-T3'; 'F3-T5'; 'F4-T4'; 'C3-P3'; 'C3-P5'; 'C3-T3'; 'C3-T5'; 'P3-P5'; 'P3-T3'; 'P3-T5'; 'P5-T3'; 'P5-T5'; 'T3-T5'; 'F4-F3'; 'P4-P3'; 'T4-T3'; 'C4-C3'; 'P6-P5'; 'T6-T5'];
    
    help = char(dataNames(1,1));
    
%     try
%         for i = 1 : 1 : size(namesOfElecs,1)
%             position(i,:) = find(ismember(data.(help).data01.data1.electrodes,namesOfElecs(i,:),'rows'));
%         end
%     catch
        position = [1; 2; 3; 4; 5; 12; 13; 14; 15; 22; 23; 24; 31; 32; 39; 52; 53; 54; 55; 56; 57; 58; 59; 60; 61; 62; 63; 64; 65; 66; 6; 27; 44; 17; 36; 51 ];
%     end
    
end

