function varargout = featureext(varargin)
% FEATUREEXT M-file for featureext.fig
%      FEATUREEXT, by itself, creates a new FEATUREEXT or raises the existing
%      singleton*.
%
%      H = FEATUREEXT returns the handle to a new FEATUREEXT or the handle to
%      the existing singleton*.
%
%      FEATUREEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEATUREEXT.M with the given input arguments.
%
%      FEATUREEXT('Property','Value',...) creates a new FEATUREEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before featureext_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to featureext_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help featureext

% Last Modified by GUIDE v2.5 12-Nov-2016 00:22:06

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @featureext_OpeningFcn, ...
                   'gui_OutputFcn',  @featureext_OutputFcn, ...
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


% --- Executes just before featureext is made visible.
function featureext_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to featureext (see VARARGIN)

% Choose default command line output for featureext
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes featureext wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = featureext_OutputFcn(hObject, eventdata, handles) 
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
close all
page1;
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;

% M_im0 = aviread('im1.avi');  %   background, 1 sample
% M_im1 = aviread('im1.avi');
x=rgb2gray(in_img6);
% y=rgb2gray(M_im1(1).cdata);
J = imnoise(x,'salt & pepper',0.02);
axes(handles.axes1);
% axes(handles.axes1);
imshow(J);
title('Noise Addition Image');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;

x=rgb2gray(in_img6);
J = imnoise(x,'salt & pepper',0.02);

L = medfilt2(J,[3 3]);
axes(handles.axes1);
imshow(L);
title('Filtered Image');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');
x=rgb2gray(M_im0(1).cdata);
y=rgb2gray(M_im1(1).cdata);
diff = double(imabsdiff(y,x));
axes(handles.axes1);
subimage(diff);
title('Bgd Subtraction Image');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');
x=rgb2gray(M_im0(1).cdata);
y=rgb2gray(M_im1(1).cdata);
im_bw = zeros(size(y(:,:,1)));
diff = double(imabsdiff(y,x));
im_bw(find(diff > 20)) = 1;
axes(handles.axes1);
subimage(im_bw);
title('Binary Image');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');
x=rgb2gray(M_im0(1).cdata);
y=rgb2gray(M_im1(1).cdata);
im_bw = zeros(size(y(:,:,1)));
diff = double(imabsdiff(y,x));
im_bw(find(diff > 20)) = 1;

im_bw = bwmorph(im_bw,'open');
axes(handles.axes1);
subimage(im_bw);
title('Process Image');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


M_im0 = aviread('im0.avi');  %   background, 1 sample
M_im1 = aviread('im1.avi');
x=rgb2gray(M_im0(1).cdata);
y=rgb2gray(M_im1(1).cdata);
im_bw = zeros(size(y(:,:,1)));
diff = double(imabsdiff(y,x));
im_bw(find(diff > 20)) = 1;

im_bw = bwmorph(im_bw,'open');

[nb_line nb_col] = size(im_bw);
sum_line = sum(im_bw')';
sum_col = sum(im_bw);
%===== Finding y_min =====
if min(sum_line) == 0
    y_min = min(find(sum_line ~= 0));
else
    y_min = 1;
end
%===== Finding x_min =====
lap = [-1 1]';
im_temp = zeros(nb_line+2,nb_col);
im_temp(2:end-1,:) = im_bw;
edge = conv2(im_temp,lap,'same');
nb_edges = sum(abs(edge));
col = min(find(sum_col == max(sum_col)));
left = 0;
right = 0;
flag = 0;
count = 0;
while left*right == 0
    if (nb_edges(col)==2)
        col = col+1;
        right = 1;
    end
    if (nb_edges(col)>2)
        col = col-1;
        left = 1;
    end
    if col == 0
        break
    end
    if count > 2*nb_col
        im_out = 0;
        return
    end
    count = count + 1;
end
x_min = max([col 1]);

%===== Finding x_max =====
sc = sum_col(x_min:nb_col);
if min(sc) == 0
    x_max = min(find(sc == 0))-1+x_min;
else
    x_max = nb_col;
end

%===== Finding y_max =====
sum_line = sum(im_bw(:, x_min:x_max)')';
y_max = max(find(sum_line ~= 0));   

%===== Collecting the releavant picture =====
s1 = x_max-x_min;
s2 = y_max-y_min;
if s1 > 2/3*s2
    im_out = im_bw(y_min:y_max, x_min:x_max);
else
%    length = 2.5 * s1; 
    length = 2*s1;
    im_out = zeros(s2+1,length);
    im_out(:,1:s1+1) = im_bw(y_min:y_max, x_min:x_max);
end
axes(handles.axes1);
subimage(im_out);
title('Zoom-in Image');

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;
x=rgb2gray(in_img6);
J = imnoise(x,'salt & pepper',0.02);

L = medfilt2(J,[3 3]);
I = imresize(L,[80 64],'bicubic');
axes(handles.axes1);
imshow(I);
title('Resize Image');
%imshow(im_out2);


% --- Executes on button press in Input_btn_img.
function Input_btn_img_Callback(hObject, eventdata, handles)
% hObject    handle to Input_btn_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;
[fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
in_img6 = imread([pn,fn]); % read the image
% in_img6 = imread('five.jpg'); % read the image

% display the results
handles.in_img6 = in_img6;
axes(handles.axes2);
imshow(in_img6);
title('Test GS');


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img6;
x=rgb2gray(in_img6);
J = imnoise(x,'salt & pepper',0.02);

L = medfilt2(J,[3 3]);
I = imresize(L,[80 64],'bicubic');
BW = edge(I,'canny',0.25);
axes(handles.axes1);
imshow(BW);
title('Resize Image');
