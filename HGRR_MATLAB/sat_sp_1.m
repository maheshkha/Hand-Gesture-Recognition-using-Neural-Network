function varargout = sat_sp_1(varargin)
% SAT_SP_1 Application M-file for sat_sp_1.fig
%    FIG = SAT_SP_1 launch sat_sp_1 GUI.
%    SAT_SP_1('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 11-Nov-2016 00:31:38

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


% --------------------------------------------------------------------
function varargout = pushbutton1_Callback(h, eventdata, handles, varargin)
global in_img1;
% [fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
% in_img1 = imread([pn,fn]); % read the image
in_img1 = imread('A1.jpg'); % read the image
% display the results
handles.in_img1 = in_img1;
axes(handles.axes2);
imshow(in_img1);
title('GS1');
% --------------------------------------------------------------------
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img2;
% [fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
% in_img2 = imread([pn,fn]); % read the image
in_img2 = imread('B1.jpg'); % read the image

% display the results
handles.in_img2 = in_img2;
axes(handles.axes5);
imshow(in_img2);
title('GS2');
% --------------------------------------------------------------------
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global in_img3;
% [fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
% in_img3 = imread([pn,fn]); % read the image
in_img3 = imread('C1.jpg'); % read the image

% display the results
handles.in_img3 = in_img3;
axes(handles.axes10);
imshow(in_img3);
title('GS3');

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global in_img4;
% [fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
% in_img4 = imread([pn,fn]); % read the image
in_img4 = imread('D1.jpg'); % read the image
handles.in_img4 = in_img4;
axes(handles.axes6);
imshow(in_img4);
title('GS4');
guidata(hObject, handles);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global in_img5;
% [fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
% in_img5 = imread([pn,fn]); % read the image
in_img5 = imread('E1.jpg'); % read the image
% display the results
handles.in_img5 = in_img5;
axes(handles.axes7);
imshow(in_img5);
title('GS5');

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global in_img6;
[fn,pn] = uigetfile('*.jpg','The file name should have jpg extension.');
in_img6 = imread([pn,fn]); % read the image
% in_img6 = imread('five.jpg'); % read the image

% display the results
handles.in_img6 = in_img6;
axes(handles.axes9);
imshow(in_img6);
title('Test GS');

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% display the results
close all
page1;
