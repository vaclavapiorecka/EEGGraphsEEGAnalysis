function varargout = EEGGraphs(varargin)
% EEGGRAPHS MATLAB code for EEGGraphs.fig
%      EEGGRAPHS, by itself, creates a new EEGGRAPHS or raises the existing
%      singleton*.
%
%      H = EEGGRAPHS returns the handle to a new EEGGRAPHS or the handle to
%      the existing singleton*.
%
%      EEGGRAPHS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEGGRAPHS.M with the given input arguments.
%
%      EEGGRAPHS('Property','Value',...) creates a new EEGGRAPHS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EEGGraphs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EEGGraphs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EEGGraphs

% Last Modified by GUIDE v2.5 27-Jul-2016 11:54:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEGGraphs_OpeningFcn, ...
                   'gui_OutputFcn',  @EEGGraphs_OutputFcn, ...
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


% --- Executes just before EEGGraphs is made visible.
function EEGGraphs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EEGGraphs (see VARARGIN)

% Choose default command line output for EEGGraphs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes EEGGraphs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EEGGraphs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in namesOfData.
function namesOfData_Callback(hObject, eventdata, handles)
% hObject    handle to namesOfData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns namesOfData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from namesOfData


% --- Executes during object creation, after setting all properties.
function namesOfData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to namesOfData (see GCBO)
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
global data

try
    numOfImportData = size(fieldnames(data));
catch
    numOfImportData = 0;
    data = struct;
end

if numOfImportData == 4
    errordlg('Variable reach a maximal number of variables.','File Error');
else
    [FileName,PathName,FilterIndex] = uigetfile({'*.mat','MAT Files'},...
                                            'MultiSelect','on');
end

assignin('base','FileName',FileName)
assignin('base','PathName',PathName)

[numOfRow numOfCol] = size(FileName);

if iscell(FileName)
    if numOfCol + numOfImportData > 4
        errordlg('Variable reach a maximal number of variables.','File Error');
        uiwait(gcf); 
    else
        numOfImportData = numOfCol + numOfImportData;
    end
    
    for NOD = 1 : 1 : numOfCol
        helpdata = load(char(strcat(PathName,FileName{NOD})),'-mat');
        [path variableName extension]= fileparts(FileName{NOD});
        data.(variableName).data = helpdata.(variableName).data;    
        data.(variableName).frequencyBands = helpdata.(variableName).frequencyBands;
        data.(variableName).finalNames = helpdata.(variableName).finalNames;
        data.(variableName).nameOfTreatment = helpdata.(variableName).nameOfTreatment;
        data.(variableName).namesOfElecs = helpdata.(variableName).namesOfElecs;
    end
else
    helpName = char(strcat(PathName,FileName));
    [path variableName extension]= fileparts(helpName);
    helpdata = load(helpName,'-mat');
    data.(variableName).data = helpdata.(variableName).data;    
    data.(variableName).frequencyBands = helpdata.(variableName).frequencyBands;
    data.(variableName).finalNames = helpdata.(variableName).finalNames;
    data.(variableName).nameOfTreatment = helpdata.(variableName).nameOfTreatment;
    data.(variableName).namesOfElecs = helpdata.(variableName).namesOfElecs;
end

assignin('base','data',data)

names = fieldnames(data);
set(handles.namesOfData,'String',names)

numOfDataNames = size(names,1);


switch numOfDataNames
    case 1
        set(handles.firstGroup,'String','');  
        set(handles.secondGroup,'String',''); 
        set(handles.thirdGroup,'String',''); 
        set(handles.fourthGroup,'String',names(1,:));  
    case 2
        set(handles.firstGroup,'String','');  
        set(handles.secondGroup,'String',''); 
        set(handles.thirdGroup,'String',names(2,:)); 
        set(handles.fourthGroup,'String',names(1,:));  
    case 3
        set(handles.firstGroup,'String','');  
        set(handles.secondGroup,'String',names(3,:)); 
        set(handles.thirdGroup,'String',names(2,:)); 
        set(handles.fourthGroup,'String',names(1,:)); 
    case 4
        set(handles.firstGroup,'String',names(4,:));  
        set(handles.secondGroup,'String',names(3,:)); 
        set(handles.thirdGroup,'String',names(2,:)); 
        set(handles.fourthGroup,'String',names(1,:)); 
end

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

set(handles.namesOfData,'String','');
 


% --- Executes on button press in showGraph.
function showGraph_Callback(hObject, eventdata, handles)
% hObject    handle to showGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Show example of data plot. Just for one electrodes pair.
global data

namesOfData = fieldnames(data);
numOfData = size(namesOfData,1);
sumOfRows = 0;

for i = 1 : 1 : numOfData
    helpData(:,1) = data.(namesOfData{i}).data(:,1,1);      % data(:,1,1) ... baseline dané látky pro všechna mìøení, 1 elektrodový pár
    helpData(:,2) = data.(namesOfData{i}).data(:,15,1);     % data(:,15,1) ... 20-30 minut dané látky pro všechna mìøení, 1 elektrodový pár
    helpData(:,3) = data.(namesOfData{i}).data(:,29,1);     % data(:,29,1) ... 50-60 minut dané látky pro všechna mìøení, 1 elektrodový pár
    helpData(:,4) = data.(namesOfData{i}).data(:,43,1);     % data(:,43,1) ... 80-90 minut dané látky pro všechna mìøení, 1 elektrodový pár
    
    rows = size(helpData,1);
    if i == 1
        exampleData = [helpData];
        group = [repmat(i, rows, 1) repmat(i+numOfData, rows, 1) repmat(i+2*numOfData, rows, 1) repmat(i+3*numOfData, rows, 1)];
    else
        exampleData = [exampleData; helpData];
        group = [group; repmat(i, rows, 1) repmat(i+numOfData, rows, 1) repmat(i+2*numOfData, rows, 1) repmat(i+3*numOfData, rows, 1)];
    end
    clear helpData;
    sumOfRows = sumOfRows + rows;
end

assignin('base','exampleData',exampleData)
assignin('base','group',group)

switch numOfData
    case 1
        positions = [1 1.25 1.50 1.75];
        color = repmat(get(handles.fourthGroup,'BackgroundColor'),4,1);
        xTickPosition = positions;
        
        group = reshape(group,sumOfRows*4,1);
        exampleData = reshape(exampleData,sumOfRows*4,1);
        
    case 2
        positions = [1 1.50 3 3.50	5 5.50  7 7.50 ];
        color = [repmat([get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],8,1)];
        xTickPosition = [mean(positions(1:2)) mean(positions(3:4)) mean(positions(5:6)) mean(positions(7:8))];
        
        group = reshape(group,sumOfRows*4,1);
        exampleData = reshape(exampleData,sumOfRows*4,1);
        
    case 3
        positions = [1 1.25 1.50   3 3.25 3.50    5 5.25 5.50    7 7.25 7.50];
        color = [repmat([ get(handles.secondGroup,'BackgroundColor'); get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],12,1)];
        xTickPosition = [mean(positions(1:3)) mean(positions(4:6)) mean(positions(7:9)) mean(positions(10:12))];
        
        group = reshape(group,sumOfRows*4,1);
        exampleData = reshape(exampleData,sumOfRows*4,1);
        
    case 4 
        positions = [1 1.25 1.50 1.75   3 3.25 3.50 3.75    5 5.25 5.50 5.75    7 7.25 7.50 7.75 ];
        color = [repmat([get(handles.firstGroup,'BackgroundColor');  get(handles.secondGroup,'BackgroundColor'); get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],16,1)];
        xTickPosition = [mean(positions(1:4)) mean(positions(5:8)) mean(positions(9:12)) mean(positions(13:16))];
        
        group = reshape(group,sumOfRows*4,1);
        exampleData = reshape(exampleData,sumOfRows*4,1);
end

assignin('base','exampleData',exampleData)
assignin('base','group',group)

boxplot(exampleData,group,'position',positions,'parent',handles.axes1);

set(gca,'xtick',xTickPosition)
set(gca,'xticklabel',{'baseline' '20 - 30 min' '50 - 60 min' '80 - 90 min'})

h = findobj(gca,'Tag','Box');
length(h)
for j=1:length(h)
   patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.5);
end

c = get(gca, 'Children');
 
hleg1 = legend(c(1:4), namesOfData, 'Location','eastoutside');
xlabel('Time of measurment')
ylabel('Coherence [%]')

title('Example of boxplot')

switch get(get(handles.uibuttongroup3,'SelectedObject'),'Tag')
    case 'globalMaxMin'
        
    case 'regionalMaxMin'
        
    case 'setYLimits'
        yMin = str2num(get(handles.YMin,'string'));
        yMax = str2num(get(handles.YMax,'string'));
        ylim([yMin yMax])  
end




% --- Executes on button press in exportGraphs.
function exportGraphs_Callback(hObject, eventdata, handles)
% hObject    handle to exportGraphs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data

[fileNameOfResult,pathOfResult] = uiputfile('*.png','Save Data As');
savingPath = strcat(pathOfResult,fileNameOfResult);


namesOfData = fieldnames(data);
numOfData = size(namesOfData,1);
sumOfRows = 0;

[numOfMeasurment numOfFrequency numOfElectrodes]= size(data.(namesOfData{1}).data);

frequency = {'Delta' 'Theta' 'Alpha' 'Beta' 'High Beta' 'Gamma' 'High Gamma' 'Alpha 1' 'Alpha 2' 'Beta 1' 'Beta 2' 'Beta 3' 'Gamma 1' 'Gamma 2';'1.0 - 4.0 Hz' '4.0 - 8.0 Hz' '8.0 - 12.0 Hz' '12.0 - 25.0 Hz' '25.0 - 30.0 Hz' '30.0 - 40.0 Hz' '40.0 - 50.0 Hz' '8.0 - 10.0 Hz' '10.0 - 12.0 Hz' '12.0 - 15.0 Hz' '15.0 - 18.0 Hz' '18.0 - 25.0 Hz' '30.0 - 35.0 Hz' '35.0 - 40.0 Hz'};
electrodes = {'F4' 'C4';'F4' 'P4';'F4' 'P6';'F4' 'T4';'F4' 'T6';'F4' 'F3';'F4' 'C3';'F4' 'P3';'F4' 'P5';'F4' 'T3';'F4' 'T5';'C4' 'P4';'C4' 'P6';'C4' 'T4';'C4' 'T6';'C4' 'F3';'C4' 'C3';'C4' 'P3';'C4' 'P5';'C4' 'T3';'C4' 'T5';'P4' 'P6';'P4' 'T4';'P4' 'T6';'P4' 'F3';'P4' 'C3';'P4' 'P3';'P4' 'P5';'P4' 'T3';'P4' 'T5';'P6' 'T4';'P6' 'T6';'P6' 'F3';'P6' 'C3';'P6' 'P3';'P6' 'P5';'P6' 'T3';'P6' 'T5';'T4' 'T6';'T4' 'F3';'T4' 'C3';'T4' 'P3';'T4' 'P5';'T4' 'T3';'T4' 'T5';'T6' 'F3';'T6' 'C3';'T6' 'P3';'T6' 'P5';'T6' 'T3';'T6' 'T5';'F3' 'C3';'F3' 'P3';'F3' 'P5';'F3' 'T3';'F3' 'T5';'C3' 'P3';'C3' 'P5';'C3' 'T3';'C3' 'T5';'P3' 'P5';'P3' 'T3';'P3' 'T5';'P5' 'T3';'P5' 'T5';'T3' 'T5'};

for NOE = 1 : 1 : numOfElectrodes
    for NOF = 1 : 1 : (numOfFrequency/4)
        for i = 1 : 1 : numOfData
            helpData(:,1) = data.(namesOfData{i}).data(:,NOF,NOE);        % data(:,1,1) ... baseline dané látky pro všechna mìøení, 1 elektrodový pár
            helpData(:,2) = data.(namesOfData{i}).data(:,NOF+14,NOE);     % data(:,15,1) ... 20-30 minut dané látky pro všechna mìøení, 1 elektrodový pár
            helpData(:,3) = data.(namesOfData{i}).data(:,NOF+28,NOE);     % data(:,29,1) ... 50-60 minut dané látky pro všechna mìøení, 1 elektrodový pár
            helpData(:,4) = data.(namesOfData{i}).data(:,NOF+42,NOE);     % data(:,43,1) ... 80-90 minut dané látky pro všechna mìøení, 1 elektrodový pár
    
            rows = size(helpData,1);
            
            if i == 1
                exampleData = [helpData];
                group = [repmat(i, rows, 1) repmat(i+numOfData, rows, 1) repmat(i+2*numOfData, rows, 1) repmat(i+3*numOfData, rows, 1)];
            else
                exampleData = [exampleData; helpData];
                group = [group; repmat(i, rows, 1) repmat(i+numOfData, rows, 1) repmat(i+2*numOfData, rows, 1) repmat(i+3*numOfData, rows, 1)];
            end
            clear helpData;
            sumOfRows = sumOfRows + rows;
        end

        assignin('base','exampleData',exampleData)
        assignin('base','group',group)

        switch numOfData
            case 1
                positions = [1 1.25 1.50 1.75];
                color = repmat(get(handles.fourthGroup,'BackgroundColor'),4,1);
                xTickPosition = positions;
        
                group = reshape(group,sumOfRows*4,1);
                exampleData = reshape(exampleData,sumOfRows*4,1);
        
            case 2
                positions = [1 1.50 3 3.50	5 5.50  7 7.50 ];
                color = [repmat([get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],8,1)];
                xTickPosition = [mean(positions(1:2)) mean(positions(3:4)) mean(positions(5:6)) mean(positions(7:8))];
        
                group = reshape(group,sumOfRows*4,1);
                exampleData = reshape(exampleData,sumOfRows*4,1);
        
            case 3
                positions = [1 1.25 1.50   3 3.25 3.50    5 5.25 5.50    7 7.25 7.50];
                color = [repmat([ get(handles.secondGroup,'BackgroundColor'); get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],12,1)];
                xTickPosition = [mean(positions(1:3)) mean(positions(4:6)) mean(positions(7:9)) mean(positions(10:12))];
        
                group = reshape(group,sumOfRows*4,1);
                exampleData = reshape(exampleData,sumOfRows*4,1);
        
            case 4 
                positions = [1 1.25 1.50 1.75   3 3.25 3.50 3.75    5 5.25 5.50 5.75    7 7.25 7.50 7.75 ];
                color = [repmat([get(handles.firstGroup,'BackgroundColor');  get(handles.secondGroup,'BackgroundColor'); get(handles.thirdGroup,'BackgroundColor'); get(handles.fourthGroup,'BackgroundColor')],16,1)];
                xTickPosition = [mean(positions(1:4)) mean(positions(5:8)) mean(positions(9:12)) mean(positions(13:16))];
        
                group = reshape(group,sumOfRows*4,1);
                exampleData = reshape(exampleData,sumOfRows*4,1);
        end

        assignin('base','exampleData',exampleData)
        assignin('base','group',group)
        
        figure(1)
        boxplot(exampleData,group,'position',positions);

        set(gca,'xtick',xTickPosition)
        set(gca,'xticklabel',{'baseline' '20 - 30 min' '50 - 60 min' '80 - 90 min'})

        h = findobj(gca,'Tag','Box');
        length(h)
        for j=1:length(h)
            patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.5);
        end

        c = get(gca, 'Children');
 
        hleg1 = legend(c(1:4), namesOfData, 'Location','eastoutside');
        xlabel('Time of measurment')
        ylabel('Coherence [%]')
        
        str=sprintf('Frequency %s , electrodes %s - %s', frequency{2,NOF}, electrodes{NOE,1}, electrodes{NOE,2})
        title(str)

        switch get(get(handles.uibuttongroup3,'SelectedObject'),'Tag')
            case 'globalMaxMin'
        
            case 'regionalMaxMin'
        
            case 'setYLimits'
                yMin = str2num(get(handles.YMin,'string'));
                yMax = str2num(get(handles.YMax,'string'));
                ylim([yMin yMax])  
        end
        
        fileSave = strcat(pathOfResult,str,'.png');
        saveas(1, fileSave);
        
        
        clear group;
        clear exampleData;
        sumOfRows = 0;
        clf;
    end
end

function YMin_Callback(hObject, eventdata, handles)
% hObject    handle to YMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YMin as text
%        str2double(get(hObject,'String')) returns contents of YMin as a double


% --- Executes during object creation, after setting all properties.
function YMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in firstGroup.
function firstGroup_Callback(hObject, eventdata, handles)
% hObject    handle to firstGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = uisetcolor();
set(handles.firstGroup, 'BackgroundColor', rgb);

% --- Executes on button press in secondGroup.
function secondGroup_Callback(hObject, eventdata, handles)
% hObject    handle to secondGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = uisetcolor();
set(handles.secondGroup, 'BackgroundColor', rgb);

% --- Executes on button press in thirdGroup.
function thirdGroup_Callback(hObject, eventdata, handles)
% hObject    handle to thirdGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = uisetcolor();
set(handles.thirdGroup, 'BackgroundColor', rgb);

% --- Executes on button press in fourthGroup.
function fourthGroup_Callback(hObject, eventdata, handles)
% hObject    handle to fourthGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb = uisetcolor();
set(handles.fourthGroup, 'BackgroundColor', rgb);



function YMax_Callback(hObject, eventdata, handles)
% hObject    handle to YMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YMax as text
%        str2double(get(hObject,'String')) returns contents of YMax as a double


% --- Executes during object creation, after setting all properties.
function YMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
