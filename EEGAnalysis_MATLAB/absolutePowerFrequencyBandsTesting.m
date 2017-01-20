function varargout = absolutePowerFrequencyBandsTesting(varargin)
% ABSOLUTEPOWERFREQUENCYBANDSTESTING MATLAB code for absolutePowerFrequencyBandsTesting.fig
%      ABSOLUTEPOWERFREQUENCYBANDSTESTING, by itself, creates a new ABSOLUTEPOWERFREQUENCYBANDSTESTING or raises the existing
%      singleton*.
%
%      H = ABSOLUTEPOWERFREQUENCYBANDSTESTING returns the handle to a new ABSOLUTEPOWERFREQUENCYBANDSTESTING or the handle to
%      the existing singleton*.
%
%      ABSOLUTEPOWERFREQUENCYBANDSTESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABSOLUTEPOWERFREQUENCYBANDSTESTING.M with the given input arguments.
%
%      ABSOLUTEPOWERFREQUENCYBANDSTESTING('Property','Value',...) creates a new ABSOLUTEPOWERFREQUENCYBANDSTESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before absolutePowerFrequencyBandsTesting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to absolutePowerFrequencyBandsTesting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help absolutePowerFrequencyBandsTesting

% Last Modified by GUIDE v2.5 23-Aug-2016 19:32:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @absolutePowerFrequencyBandsTesting_OpeningFcn, ...
                   'gui_OutputFcn',  @absolutePowerFrequencyBandsTesting_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before absolutePowerFrequencyBandsTesting is made visible.
function absolutePowerFrequencyBandsTesting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to absolutePowerFrequencyBandsTesting (see VARARGIN)

% Choose default command line output for absolutePowerFrequencyBandsTesting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes absolutePowerFrequencyBandsTesting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = absolutePowerFrequencyBandsTesting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function filesNames01_Callback(hObject, eventdata, handles)
% hObject    handle to filesNames01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filesNames01 as text
%        str2double(get(hObject,'String')) returns contents of filesNames01 as a double


% --- Executes during object creation, after setting all properties.
function filesNames01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filesNames01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importData01.
function importData01_Callback(hObject, eventdata, handles)
% hObject    handle to importData01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName01 PathName01 data01

try
    PathName01 = evalin('base','PathName01');  
    PathName01 = strcat(PathName01,'*.tdt');
    [FileName01,PathName01,FilterIndex] = uigetfile(PathName01,'MultiSelect','on');
        assignin('base','FileName01',FileName01)
        assignin('base','PathName01',PathName01)
catch

        [FileName01,PathName01,FilterIndex] = uigetfile('*.tdt*','(*.tdt)','MultiSelect','on');
        assignin('base','FileName01',FileName01)
        assignin('base','PathName01',PathName01)
end


set(handles.filesNames01,'String',FileName01);

data01 = createTable(FileName01,PathName01,'AbsolutePowerBands');       % 
assignin('base','data01',data01)

global numOfFiles
numOfFiles = size(fieldnames(data01),1);
assignin('base','numOfFiles',numOfFiles)


% --- Executes on button press in createTable.
function createTable_Callback(hObject, eventdata, handles)
% hObject    handle to createTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ukládání souborù (místo a název tabulky)

[fileNameOfResult,pathOfResult] = uiputfile('*.xlsx','Save Data As');
savingPath = strcat(pathOfResult,fileNameOfResult);

global data01 data02 data03 data04 data FileName01 FileName02 FileName03 FileName04

sizeData = size(data01.data1.data,1);
numOfMeasurment = size(data01,1);

if sizeData ~= 12
    errordlg('Soubor *.TDT byl vyexportován v jiném než obvyklém formátu. Zkontrolujte data. ','File Error')
else
    
data01 = statisticData(data01);
assignin('base','data01',data01)
exportTable(data01.mean, data01.std, data01.data1.electrodes, data01.data1.frequency, savingPath, 'baseline' )

data02 = statisticData(data02);
assignin('base','data02',data02)
exportTable(data02.mean, data02.std, data02.data1.electrodes, data02.data1.frequency, savingPath, '20_30' )

data03 = statisticData(data03);
assignin('base','data03',data03)
exportTable(data03.mean, data03.std, data03.data1.electrodes, data03.data1.frequency, savingPath, '50_60' )

data04 = statisticData(data04);
assignin('base','data04',data04)
exportTable(data04.mean, data04.std, data04.data1.electrodes, data04.data1.frequency, savingPath, '80_90' )



[pathstr,dataName,ext] = fileparts(fileNameOfResult);
data.(dataName).data01 = data01;
data.(dataName).data02 = data02;
data.(dataName).data03 = data03;
data.(dataName).data04 = data04;

    filesNames = [FileName01; FileName02; FileName03; FileName04];
    exportFile = strcat(pathOfResult,fileNameOfResult,'AnalyzedFiles.txt');
    
    formatSpec = '%s \t';
    fileID = fopen(exportFile,'w');
    [nrows,ncols] = size(filesNames);
    for row = 1:nrows
        fprintf(fileID,formatSpec,filesNames{row,:});
    end

[ data ] = createSubtables(data,dataName);

evalin('base','clear data01 data02 data03 data04 FileName01 FileName02 FileName03 FileName04')
set(handles.filesNames01, 'String', ''); 
set(handles.filesNames02, 'String', '');
set(handles.filesNames03, 'String', '');
set(handles.filesNames04, 'String', '');

assignin('base','data',data)

names = fieldnames(data);
set(handles.listbox5,'String',names)
end


% --- Executes on button press in importData02.
function importData02_Callback(hObject, eventdata, handles)
% hObject    handle to importData02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName02 PathName02 data02 numOfFiles
PathName01 = evalin('base','PathName01');
PathName01 = strcat(PathName01,'*.tdt');

[FileName02,PathName02,FilterIndex] = uigetfile(PathName01,'MultiSelect','on');
assignin('base','FileName02',FileName02)

set(handles.filesNames02,'String',FileName02);

numOfFiles = evalin('base','numOfFiles');
if numOfFiles==size(FileName02,2)
    data02 = createTable(FileName02,PathName02,'AbsolutePowerBands');
    assignin('base','data02',data02)
else
    errordlg('Je nutné, aby jednotlivé èasy mìly stejný poèet souborù!!!','File Error')
end



% --- Executes on selection change in filesNames02.
function filesNames02_Callback(hObject, eventdata, handles)
% hObject    handle to filesNames02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filesNames02 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filesNames02


% --- Executes during object creation, after setting all properties.
function filesNames02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filesNames02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importData03.
function importData03_Callback(hObject, eventdata, handles)
% hObject    handle to importData03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName03 PathName03 data03

PathName01 = evalin('base','PathName01');
PathName01 = strcat(PathName01,'*.tdt');

[FileName03,PathName03,FilterIndex] = uigetfile(PathName01,'MultiSelect','on');
assignin('base','FileName03',FileName03)

set(handles.filesNames03,'String',FileName03);

numOfFiles = evalin('base','numOfFiles');
if numOfFiles==size(FileName03,2)
    data03 = createTable(FileName03,PathName03,'AbsolutePowerBands');
    assignin('base','data03',data03)
else
    errordlg('Je nutné, aby jednotlivé èasy mìly stejný poèet souborù!!!','File Error')
end


% --- Executes on selection change in filesNames03.
function filesNames03_Callback(hObject, eventdata, handles)
% hObject    handle to filesNames03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filesNames03 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filesNames03


% --- Executes during object creation, after setting all properties.
function filesNames03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filesNames03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importData04.
function importData04_Callback(hObject, eventdata, handles)
% hObject    handle to importData04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName04 PathName04 data04

PathName01 = evalin('base','PathName01');
PathName01 = strcat(PathName01,'*.tdt');

[FileName04,PathName04,FilterIndex] = uigetfile(PathName01,'MultiSelect','on');
assignin('base','FileName04',FileName04)


set(handles.filesNames04,'String',FileName04);

numOfFiles = evalin('base','numOfFiles');
if numOfFiles==size(FileName04,2)
    data04 = createTable(FileName04,PathName04,'AbsolutePowerBands');
    assignin('base','data04',data04)
else
    errordlg('Je nutné, aby jednotlivé èasy mìly stejný poèet souborù!!!','File Error')
end


% --- Executes on selection change in filesNames04.
function filesNames04_Callback(hObject, eventdata, handles)
% hObject    handle to filesNames04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filesNames04 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filesNames04


% --- Executes during object creation, after setting all properties.
function filesNames04_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filesNames04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% NOT VISIBLE
% % --- Executes on button press in FinalTable.
% function FinalTable_Callback(hObject, eventdata, handles)
% % hObject    handle to FinalTable (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global data
% 
% namesOfCycles = fieldnames(data);
% 
% assignin('base','namesOfCycles',namesOfCycles)
% numOfCycles = size(namesOfCycles,1);
% 
% % Zapíše jména jednotlivých souborù do tabulky
% for i = 1 : 1 : 4
%     helping = char(namesOfCycles(i));
%     nameOfCycles{i} = helping;
% end
% 
% for noe = 1 : 1 : 72
%     nameToTable((4*(noe-1)+1):(4*(noe-1)+4),1) = nameOfCycles; 
% end
% 
% PathName01 = 'C:\Program Files\NUDZ\EEGCoherence\application\';
% [FileName,PathName,FilterIndex] = uigetfile({'*.xlsx','XLS';...
%                                         '*.*','All Files' },'Open XLSX template',...
%                                         PathName01);
%                                     
% [fileNameRes,pathOfRes,FilterIndex] = uiputfile('*.xlsx','Save Data As');
% 
% wholeNameOrig = strcat(PathName,FileName);
% wholeNameRes = strcat(pathOfRes,fileNameRes);
% copyfile(wholeNameOrig,wholeNameRes,'f')
% 
% xlswrite(wholeNameRes,nameToTable,'List1','E6:E293')
% 
% positionOfElecs = elecsPos(data,namesOfCycles);
% 
% tableToCompare = createFinalTable(data, positionOfElecs, namesOfCycles, numOfCycles);
% xlswrite(wholeNameRes,tableToCompare,'List1','F6:BI293')
% 
% msgbox({'Final table was create.' 'You can find the table in directory:' wholeNameRes },'Success');


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importXLSX.
function importXLSX_Callback(hObject, eventdata, handles)
% hObject    handle to importXLSX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data pathImportTable

try
    data = evalin('base','data');
end


try
    pathImportTable = evalin('base','pathImportTable');  
    pathImportTable = strcat(pathImportTable,'*.xlsx');
    
    [FileName,pathImportTable,FilterIndex] = uigetfile(pathImportTable);
    assignin('base','pathImportTable',pathImportTable) 
catch
    [FileName,pathImportTable,FilterIndex] = uigetfile('*.xlsx','Load data');
    assignin('base','pathImportTable',pathImportTable)
end

getPath = strcat(pathImportTable,FileName);
[pathstr,FileName,ext] = fileparts(FileName);
[finalFile, sheets] = xlsfinfo(getPath);

   
data.(FileName).data01.dataMEAN = xlsread(getPath,'baseline','C3:AZ14');
data.(FileName).data01.dataSD  = xlsread(getPath,'baseline','C72:AZ83');

data.(FileName).data02.dataMEAN = xlsread(getPath,'20_30','C3:AZ14');
data.(FileName).data02.dataSD  = xlsread(getPath,'20_30','C72:AZ83');

data.(FileName).data03.dataMEAN = xlsread(getPath,'50_60','C3:AZ14');
data.(FileName).data03.dataSD  = xlsread(getPath,'50_60','C72:AZ83');

data.(FileName).data04.dataMEAN = xlsread(getPath,'80_90','C3:AZ14');
data.(FileName).data04.dataSD  = xlsread(getPath,'80_90','C72:AZ83');



        dataSD = zeros(12,200);
        data.(FileName).dataSD = dataSD;           % 56 = 4*14 (14 fr. pásem, po 4 èasech)
        dataMEAN = zeros(12,200);
        data.(FileName).dataMEAN = dataMEAN;       % 56 = 4*14 (14 fr. pásem, po 4 èasech)
        
        for numOfElecs = 1 : 1 : 12
            for numOfFreq = 1 : 1 : 50
                data.(FileName).dataSD(numOfElecs,4*(numOfFreq-1)+1) = data.(FileName).data01.dataSD(numOfElecs,numOfFreq);
                data.(FileName).dataSD(numOfElecs,4*(numOfFreq-1)+2) = data.(FileName).data02.dataSD(numOfElecs,numOfFreq);
                data.(FileName).dataSD(numOfElecs,4*(numOfFreq-1)+3) = data.(FileName).data03.dataSD(numOfElecs,numOfFreq);
                data.(FileName).dataSD(numOfElecs,4*(numOfFreq-1)+4) = data.(FileName).data04.dataSD(numOfElecs,numOfFreq);
                
                data.(FileName).dataMEAN(numOfElecs,4*(numOfFreq-1)+1) = data.(FileName).data01.dataMEAN(numOfElecs,numOfFreq);
                data.(FileName).dataMEAN(numOfElecs,4*(numOfFreq-1)+2) = data.(FileName).data02.dataMEAN(numOfElecs,numOfFreq);
                data.(FileName).dataMEAN(numOfElecs,4*(numOfFreq-1)+3) = data.(FileName).data03.dataMEAN(numOfElecs,numOfFreq);
                data.(FileName).dataMEAN(numOfElecs,4*(numOfFreq-1)+4) = data.(FileName).data04.dataMEAN(numOfElecs,numOfFreq);
            end
        end

assignin('base','data',data)

names = fieldnames(data);
set(handles.listbox5,'String',names)


% --- Executes on button press in finalTableRD.
function finalTableRD_Callback(hObject, eventdata, handles)
% Export surových dat mimo šablonu.

global data

namesOfCycles = fieldnames(data);
assignin('base','namesOfCycles',namesOfCycles)

numOfCycles = size(namesOfCycles,1);
numOfTimes = 4;

namesOfTimes = {'baseline', '20-30 min.', '50-60 min.', '80-90 min.' };   

% Zapíše jména jednotlivých souborù do tabulky
for i = 1 : 1 : numOfCycles
    helping = char(namesOfCycles(i));
    nameOfCycles{i} = helping;
end

sizeOfData = size(data.(helping).dataSD,1);                                                            % Poèet elektrodových párù pro analýzu
statisticParams = {'Prùmìr';'SD'};
% namesOfElecs = {'F4-LE';'C4-LE';'P4-LE';'P6-LE';'T4-LE';'T6-LE';'F3-LE';'C3-LE';'P3-LE';'P5-LE';'T3-LE';'T5-LE'};
% namesOfBands = {'1 Hz' '2 Hz' '3 Hz' '4 Hz' '5 Hz' '6 Hz' '7 Hz' '8 Hz' '9 Hz' '10 Hz' '11 Hz' '12 Hz' '13 Hz' '14 Hz' '15 Hz' '16 Hz' '17 Hz' '18 Hz' '19 Hz' '20 Hz' '21 Hz' '22 Hz' '23 Hz' '24 Hz' '25 Hz' '26 Hz' '27 Hz' '28 Hz' '29 Hz' '30 Hz' '31 Hz' '32 Hz' '33 Hz' '34 Hz' '35 Hz' '36 Hz' '37 Hz' '38 Hz' '39 Hz' '40 Hz' '41 Hz' '42 Hz' '43 Hz' '44 Hz' '45 Hz' '46 Hz' '47 Hz' '48 Hz' '49 Hz' '50 Hz'};
namesOfElecs = {'F4-LE';'C4-LE';'P4-LE';'P6-LE';'T4-LE';'T6-LE';'F3-LE';'C3-LE';'P3-LE';'P5-LE';'T3-LE';'T5-LE'};
namesOfBands ={'Delta' 'Theta' 'Alpha' 'Beta' 'High Beta' 'Gamma' 'High Gamma' 'Alpha 1' 'Alpha 2' 'Beta 1' 'Beta 2' 'Beta 3' 'Gamma 1' 'Gamma 2';'1.0 - 4.0 Hz' '4.0 - 8.0 Hz' '8.0 - 12.0 Hz' '12.0 - 25.0 Hz' '25.0 - 30.0 Hz' '30.0 - 40.0 Hz' '40.0 - 50.0 Hz' '8.0 - 10.0 Hz' '10.0 - 12.0 Hz' '12.0 - 15.0 Hz' '15.0 - 18.0 Hz' '18.0 - 25.0 Hz' '30.0 - 35.0 Hz' '35.0 - 40.0 Hz'};
helpNames = [namesOfCycles; namesOfCycles]';

nameToTableE = cell(2*numOfCycles*sizeOfData,1);
nameToTableS = cell(2*numOfCycles*sizeOfData,1);

for noe = 1 : 1 : sizeOfData                                                        % Pouze 36 vybraných párù do tabulky. Dva vybrané statistické parametry: prùmìr, smìr. odchylka.
    nameToTableE(2*numOfCycles*(noe-1)+1) = namesOfElecs(noe);
    nameToTableF((2*numOfCycles*(noe-1)+1):(2*numOfCycles*(noe-1)+numOfCycles*2),1) = helpNames;                 
    nameToTableS((2*numOfCycles*(noe-1)+1)) = statisticParams(1,:); 
    nameToTableS((2*numOfCycles*(noe-1)+1+numOfCycles)) = statisticParams(2,:);
end

columnData1 = cell(numOfTimes*14,2);
for nof = 1 : 1 : 14                % 14 frekvenèních pásem
    columnData1((numOfTimes*(nof-1)+1),:) = namesOfBands(1,nof)';
    columnData2((numOfTimes*(nof-1)+1):(numOfTimes*(nof-1)+numOfTimes)) = namesOfTimes;
end

columnData1 = columnData1';

nameToTable = [nameToTableE nameToTableF nameToTableS];
assignin('base','nameToTable',nameToTable)
columnData = [columnData1; columnData2];
[fileNameRes,pathOfRes,FilterIndex] = uiputfile('*.xlsx','Save Data As');
wholeNameRes = strcat(pathOfRes,fileNameRes);


%tableToCompare = createFinalTable(data, positionOfElecs, namesOfCycles, numOfCycles);
    tableRow = numOfCycles*2*12;
    tableCol = 4*14;
    
    tableToCompare = zeros(tableRow,tableCol);
    
    for NOC = 1 : 1 : numOfCycles
        name = namesOfCycles{NOC,1};
        for NOE = 1 : 1 : 12
            tableToCompare(((NOE-1)*numOfCycles*2+NOC),:) = data.(name).dataMEAN(NOE,:);
            tableToCompare(((NOE-1)*numOfCycles*2+(numOfCycles+NOC)),:) = data.(name).dataSD(NOE,:);
        end    
    end

    assignin('base','table',tableToCompare)
    
% Zápis dat - jména øádkù
sheet = 1;
xlRange = 'A4';
xlswrite(wholeNameRes,nameToTable,sheet,xlRange)

% Zápis dat - jména sloupcù
sheet = 1;
xlRange = 'D1';
xlswrite(wholeNameRes,columnData,sheet,xlRange)

% Zápis dat - jména sloupcù
sheet = 1;
xlRange = 'D4';
xlswrite(wholeNameRes,tableToCompare,sheet,xlRange)

msgbox({'Final table was create.' 'You can find the table in directory:' wholeNameRes },'Success');


% --- Executes on button press in createStatisticData.
function createStatisticData_Callback(hObject, eventdata, handles)
% hObject    handle to createStatisticData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Vytvoøení souboru s pùvodními hodnotami. Urèené pro statistické
% zhodnocení.
[fileNameOfResult,pathOfResult] = uiputfile('*.xlsx','Save Statistic Data As');
savingPath = strcat(pathOfResult,fileNameOfResult);

[pathstr,fileNameOfResult,ext] = fileparts(savingPath);

global data01 data02 data03 data04 statdata FileName01 FileName02 FileName03 FileName04

sizeData = size(data01.data1.data,1);
names = fieldnames(data01);
numOfMeasurment = size(names,1);

frequencyBandsHelp = data01.data1.frequency;
numOfFrequency = size(frequencyBandsHelp,2);
namesOfTimes = {'baseline'; '20-30 min.'; '50-60 min.'; '80-90 min.' };
namesOfElecs = data01.data1.electrodes;

%namesOfElecs = cell(sizeData,1);

if sizeData ~= 12
    errordlg('Soubor *.TDT byl vyexportován v jiném než obvyklém formátu. Zkontrolujte data. ','File Error')
else
    
    data01 = statisticData(data01);
    assignin('base','data01',data01)

    data02 = statisticData(data02);
    assignin('base','data02',data02)

    data03 = statisticData(data03);
    assignin('base','data03',data03)

    data04 = statisticData(data04);
    assignin('base','data04',data04)
    
    % alokoce promìnných
    finalStatData = zeros(numOfMeasurment,4*numOfMeasurment,sizeData);
    finalNames = cell(1,4*numOfFrequency);
    nameOfTreatment = cell(4*numOfMeasurment,1);
    
    for nom = 1 : 1 : numOfMeasurment
        nameOfTreatment{nom,1} = fileNameOfResult;
    end
    
    for not = 1 : 1 : 4
        finalNames(1,(not-1)*numOfFrequency+1) = namesOfTimes(not,:);
        frequencyBands(:,((not-1)*numOfFrequency+1):(not*numOfFrequency)) = frequencyBandsHelp(:,:);
    end
    
    for noe = 1 : 1 : sizeData
        helpData(:,:,1) = data01.statData(:,:,noe);
        helpData(:,:,2) = data02.statData(:,:,noe);
        helpData(:,:,3) = data03.statData(:,:,noe);
        helpData(:,:,4) = data04.statData(:,:,noe);
        
    
        for not = 1 : 1 : 4
            finalStatData(:,((not-1)*numOfFrequency+1):(not*numOfFrequency),noe) = helpData(:,:,not);
            finalNames(1,(not-1)*numOfFrequency+1) = namesOfTimes(not,:);
            frequencyBands(:,((not-1)*numOfFrequency+1):(not*numOfFrequency)) = frequencyBandsHelp(:,:);
        end
        
    end
    
    statdata.(fileNameOfResult).data = finalStatData;
    statdata.(fileNameOfResult).frequencyBands = frequencyBands;
    statdata.(fileNameOfResult).finalNames = finalNames;
    statdata.(fileNameOfResult).nameOfTreatment = nameOfTreatment;
    statdata.(fileNameOfResult).namesOfElecs = namesOfElecs;
    
    
    filesNames = [FileName01; FileName02; FileName03; FileName04];
    exportFile = strcat(pathOfResult,fileNameOfResult,'AnalyzedFiles.txt');
    
    formatSpec = '%s \t';
    fileID = fopen(exportFile,'w');
    [nrows,ncols] = size(filesNames);
    for row = 1:nrows
        fprintf(fileID,formatSpec,filesNames{row,:});
    end


    assignin('base','statdata',statdata)

    names = fieldnames(statdata);
    set(handles.namesOfDataStat,'String',names)

    for noe = 1 : 1 : sizeData
        sheet = char(namesOfElecs{noe});
        xlRange = 'B1';
        xlswrite(savingPath,finalNames,sheet,xlRange)
        
        xlRange = 'B2';
        xlswrite(savingPath,frequencyBands,sheet,xlRange)
        
        xlRange = 'B3';
        xlswrite(savingPath,finalStatData(:,:,noe),sheet,xlRange)
        
        xlRange = 'A3';
        xlswrite(savingPath,nameOfTreatment,sheet,xlRange)
        
    end
    
    
    % Ukládá .mat soubor do stejné složky pro jednu medikaci ve ètyøech èasech
    
    helpNameOfResult = char(fileNameOfResult);
    fileNameOfResult = statdata.(fileNameOfResult);
    
    assignin('base',helpNameOfResult,fileNameOfResult)
    assignin('base','helpNameOfResult',helpNameOfResult)

    matNameRes = char(strcat(pathOfResult,helpNameOfResult,'.mat'));
    assignin('base','matNameRes',matNameRes)
    
    
    evalin('base', ['save(matNameRes,helpNameOfResult)'])

    evalin('base','clear data01 data02 data03 data04 FileName01 FileName02 FileName03 FileName04')
    set(handles.filesNames01, 'String', ''); 
    set(handles.filesNames02, 'String', '');
    set(handles.filesNames03, 'String', '');
    set(handles.filesNames04, 'String', '');

    msgbox({'Table was create.' 'You can find the table in directory:' savingPath },'Success');
end


% --- Executes on button press in finalStatisticTable.
function finalStatisticTable_Callback(hObject, eventdata, handles)
% hObject    handle to finalStatisticTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global statdata

statdata = evalin('base','statdata');
namesOfCycles = fieldnames(statdata);
assignin('base','namesOfCycles',namesOfCycles)
numOfCycles = size(namesOfCycles,1);

numOfTimes = 4;
helpName = char(namesOfCycles(1));
sizeData = size(statdata.(helpName).data,3);

finalNames = statdata.(helpName).finalNames;
frequencyBands = statdata.(helpName).frequencyBands;
numOfFreq = size(frequencyBands,2);
namesOfElecs = statdata.(helpName).namesOfElecs;

numOfMeasurment = zeros(numOfCycles,1);
% Poèet jednotlivých mìøeních ve skupinách
for noc = 1 : 1 : numOfCycles
    helpName = char(namesOfCycles(noc));
    numOfMeasurment(noc) = size(statdata.(helpName).data,1);
end

sum(numOfMeasurment,1)
finalStatData = zeros(sum(numOfMeasurment,1),numOfFreq,sizeData);
% Zapíše jména jednotlivých souborù do tabulky
for noc = 1 : 1 : numOfCycles
    helpName = char(namesOfCycles(noc));
    if noc==1
        finalStatData(1:(numOfMeasurment(noc)),:,:) = statdata.(helpName).data;
        nameOfTreatment(1:(numOfMeasurment(noc)),:,:) = statdata.(helpName).nameOfTreatment(1:(numOfMeasurment(noc)));
    else
        finalStatData((sum(numOfMeasurment(1:(noc-1)))+1):sum(numOfMeasurment(1:noc)),:,:) = statdata.(helpName).data;
        nameOfTreatment((sum(numOfMeasurment(1:(noc-1)))+1):sum(numOfMeasurment(1:noc)),:,:) = statdata.(helpName).nameOfTreatment(1:(numOfMeasurment(noc)));
    end
end

[fileNameRes,pathOfRes,FilterIndex] = uiputfile('*.xlsx','Save Statistic Data As');
wholeNameRes = strcat(pathOfRes,fileNameRes);

    [pathstr,fileNameOfResult,ext] = fileparts(wholeNameRes);
    matNameRes = strcat(pathOfRes,fileNameOfResult,'.mat')
    save(matNameRes,'statdata') 
    
    for noe = 1 : 1 : sizeData
        sheet = char(namesOfElecs{noe});
        xlRange = 'B1';
        xlswrite(wholeNameRes,finalNames,sheet,xlRange)
        
        xlRange = 'B2';
        xlswrite(wholeNameRes,frequencyBands,sheet,xlRange)
        
        xlRange = 'B3';
        xlswrite(wholeNameRes,finalStatData(:,:,noe),sheet,xlRange)
        
        xlRange = 'A3';
        xlswrite(wholeNameRes,nameOfTreatment,sheet,xlRange)
        
    end

msgbox({'Final table was create.' 'You can find the table in directory:' wholeNameRes },'Success');


% --- Executes on selection change in namesOfDataStat.
function namesOfDataStat_Callback(hObject, eventdata, handles)
% hObject    handle to namesOfDataStat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns namesOfDataStat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from namesOfDataStat


% --- Executes during object creation, after setting all properties.
function namesOfDataStat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to namesOfDataStat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importMAT.
function importMAT_Callback(hObject, eventdata, handles)
% hObject    handle to importMAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName,FilterIndex] = uigetfile({'*.mat','MAT Files'},...
                                            'MultiSelect','on');

global statdata

if ~iscell(FileName)
    helpName = char(FileName);
    clear FileName
    FileName{1} = helpName;
end

[numOfRow numOfCol] = size(FileName);

for i = 1 : 1 : numOfCol
    helpName = char(strcat(PathName,FileName{i}));
    [path variableName extension]= fileparts(helpName);
    data = load(strcat(PathName,variableName,'.mat'),'-mat');
    statdata.(variableName).data = data.(variableName).data;    
    statdata.(variableName).frequencyBands = data.(variableName).frequencyBands;
    statdata.(variableName).finalNames = data.(variableName).finalNames;
    statdata.(variableName).nameOfTreatment = data.(variableName).nameOfTreatment;
    statdata.(variableName).namesOfElecs = data.(variableName).namesOfElecs;
end

assignin('base','statdata',statdata)

names = fieldnames(statdata);
set(handles.namesOfDataStat,'String',names)


% --- Executes on button press in clearData.
function clearData_Callback(hObject, eventdata, handles)
% hObject    handle to clearData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data statdata

try
    namesOfCycles = fieldnames(statdata);
    statdata = rmfield(statdata,namesOfCycles);
    assignin('base','statdata',statdata)
catch
    
end

try
    namesOfData = fieldnames(data);
    data = rmfield(data,namesOfData);
    assignin('base','data',data)
catch
    
end



evalin('base','clear data01 data02 data03 data04 FileName01 FileName02 FileName03 FileName04')

set(handles.filesNames01, 'String', ''); 
set(handles.filesNames02, 'String', '');
set(handles.filesNames03, 'String', '');
set(handles.filesNames04, 'String', '');
set(handles.listbox5,'String','');
set(handles.namesOfDataStat,'String','');
