function varargout = testing_gui(varargin)
% TESTING_GUI M-file for testing_gui.fig
%      TESTING_GUI, by itself, creates a new TESTING_GUI or raises the existing
%      singleton*.
%
%      H = TESTING_GUI returns the handle to a new TESTING_GUI or the handle to
%      the existing singleton*.
%
%      TESTING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTING_GUI.M with the given input arguments.
%
%      TESTING_GUI('Property','Value',...) creates a new TESTING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testing_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testing_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help testing_gui

% Last Modified by GUIDE v2.5 22-Mar-2008 19:27:17

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_gui_OutputFcn, ...
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


% --- Executes just before testing_gui is made visible.
function testing_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testing_gui (see VARARGIN)

% Choose default command line output for testing_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testing_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testing_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% % --- Executes on button press in pushbutton1.
% function pushbutton1_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% page1;

% M_im1 = aviread('im1.avi');
% x=rgb2gray(M_im1(1).cdata);
% axes(handles.axes2);
% subimage(x);
% title('Original Image');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

page1;
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;
global Sign;
feature_extraction = [];
feature_extra = [];
k=1;
j1=1;
j2=1;

[fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
in_img6 = imread([pn,fn]); % read the image
axes(handles.axes2);
imshow(in_img6);
title('Unknown Image');

        x=rgb2gray(in_img6);%image toolbox dependent
    %     imshow(uint8(x));
    x=double(x);
    I = imresize(x,[80 64],'bicubic');
        Hi=imhist(I);

     BW = edge(I,'canny',0.25); %finding edges 
    [imx,imy]=size(BW);
    msk=[0 0 0 0 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 1 1 1 0;
         0 0 0 0 0;];
    B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components
    bw_7050=imresize(B,[70,50]);
    for cnt=1:7
        for cnt2=1:5
            Atemp=sum(bw_7050((cnt*10-9:cnt*10),(cnt2*10-9:cnt2*10)));
            lett((cnt-1)*5+cnt2)=sum(Atemp);
        end
    end

    lett=((100-lett)/100);
    lett=lett;

%         feature = [Hi'];
        feature = [lett];
        feature_extra = [feature_extra; feature];
%         data_target(j1,j2) = 1;
        j2 = j2+1;
        k = k+1;

%         j2 = j2+1;
        j1 = j1+1;
% load total_feature_16may09_5_signs_40samples_new_1
% here load training net file
% load network_50epochs_2may_final
% load network_50epochs_17may1_first_5_of_40_samples_2
load network_50epochs_gesture_lett;
%input
% P = [0 1 2 3 4 5 6 7 8 9 10];
P = feature_extra';
[m n]=size(feature_extra);
% T = data_target;

% [m N_test] = size(T);
Testing_Error = NaN * zeros(1,11);
%   Simulating the testing set
Sim_test = sim(net,P);% Simulation using the testing set
% Result_test = find(compet(Sim_test));
% Target_test = find(compet(T));
% Number_of_Errors = sum(Result_test ~= Target_test)% Calculating the number of errors
% Norm_Number_of_Error = Number_of_Errors / (3*N_test) % Normalizing the number of errors


nb_gesture = mod(find(compet(Sim_test)),5)
tab_asl = [ 'A' 'B' 'C' 'D' 'E'];% 'f' 'g' 'h' 'i' 'j']';
tab_asl1 = [ 1 2 3 4 0];% 6 7 8 9 0]';

[m n]=size(nb_gesture);
[m1 n1]=size(tab_asl1);
for i=1:m
    for j=1:n1
        if(nb_gesture(i)== tab_asl1(j))
            disp(tab_asl(j));
            Sign=num2str(j);
%             set(handles.edit1,'String',tab_asl(j));
 set(handles.edit1,'String',num2str(j));
%tab_asl = [ 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z']';
        elseif (nb_gesture(i)== tab_asl1(n1))
            disp(['May be false result' tab_asl(j)]);
        end
    end
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Sign;
set(handles.edit1,'String',Sign);   





