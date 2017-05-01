function varargout = eecs_Project(varargin)
% EECS_PROJECT MATLAB code for eecs_Project.fig
%      EECS_PROJECT, by itself, creates a new EECS_PROJECT or raises the existing
%      singleton*.
%
%      H = EECS_PROJECT returns the handle to a new EECS_PROJECT or the handle to
%      the existing singleton*.
%
%      EECS_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EECS_PROJECT.M with the given input arguments.
%
%      EECS_PROJECT('Property','Value',...) creates a new EECS_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eecs_Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eecs_Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eecs_Project

% Last Modified by GUIDE v2.5 18-Apr-2017 21:41:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eecs_Project_OpeningFcn, ...
                   'gui_OutputFcn',  @eecs_Project_OutputFcn, ...
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


% --- Executes just before eecs_Project is made visible.
function eecs_Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eecs_Project (see VARARGIN)

% Choose default command line output for eecs_Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eecs_Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eecs_Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function message_send_Callback(hObject, eventdata, handles)
% hObject    handle to message_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 

% Hints: get(hObject,'String') returns contents of message_send as text
%        str2double(get(hObject,'String')) returns contents of message_send as a double


% --- Executes during object creation, after setting all properties.
function message_send_CreateFcn(hObject, eventdata, handles)
% hObject    handle to message_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in crypto_it.
function crypto_it_Callback(hObject, eventdata, handles)
% hObject    handle to crypto_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
message = get(handles.message_send,'String'); %edit1 being Tag of ur edit box
 if isempty(message)
     msgbox('You Should Enter Your Message');
 else
	%% Create a random password
    SET = char(['a':'z']) ;
    NSET = length(SET) ;
    N = 15; % pick N numbers
    i = ceil(NSET*rand(1,N)) ; % with repeat
    R = SET(i);
    password = R;
    password=password-97;
    [notused size_of_message] = size(message);
    [notused size_of_password] = size(password);
    pos = 1;
    output=[];
    for i=1:size_of_message
        output(i) = message(i)+password(pos);
        pos = pos + 1;
        if (pos>size_of_password);
            pos = 1;
        end
    end
    crypto_message=sprintf('%s',output);

    %% crypting the password
    duble = double(R);
    rshp = reshape(duble, 3, 5);
    %creating certain matrix to crypto the password
    m = [1 5 3; 2 11 8; 4 24 21];
    %ASCII codes in the range 32 to 126, we must first adjust the 3 × 5
    %message matrix by subtracting 32 from every element:
    ncode = mod(m*(rshp - 32),95) + 32;
    %m*(rshp - 32) This transformed matrix does not contain printable ASCII codes, but we can
    %take care of that via mod 95. then we have to add 32 to print as ASCII
    %codes.
    crypted_password = reshape(char(ncode),1,length(R));
    set(handles.crypted_message,'String',crypto_message);
    fprintf('password was %s\n',R);
    fprintf('crypted password is %s',crypted_password)
    handles.crypted_password = crypted_password
    handles.crypto_message = crypto_message
    guidata(hObject, handles);
 end


% --- Executes on button press in decrypto_it.
function decrypto_it_Callback(hObject, eventdata, handles)
% hObject    handle to decrypto_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

m = [1 5 3; 2 11 8; 4 24 21];
crypto_message = handles.crypto_message;
crypted_password = handles.crypted_password;
rshp2 = reshape(double(crypted_password), 3, 5);
nmatrix = mod(inv(m)*(rshp2-32),95) + 32;
decrpyted_password = reshape(char(nmatrix),1,length(crypted_password));

password = decrpyted_password;
password=password-97;
message = crypto_message;
[notused size_of_message] = size(message);
[notused size_of_password] = size(password);
pos = 1;
output=[];
for i=1:size_of_message
    output(i) = message(i)+password(pos).*(-1);
    pos = pos + 1;
    if (pos>size_of_password);
        pos = 1;
    end
end
de_message=sprintf('%s',output);
set(handles.decrypted_message,'String',de_message);



function crypted_message_Callback(hObject, eventdata, handles)
% hObject    handle to crypted_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crypted_message as text
%        str2double(get(hObject,'String')) returns contents of crypted_message as a double


% --- Executes during object creation, after setting all properties.
function crypted_message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crypted_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function decrypted_message_Callback(hObject, eventdata, handles)
% hObject    handle to decrypted_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of decrypted_message as text
%        str2double(get(hObject,'String')) returns contents of decrypted_message as a double


% --- Executes during object creation, after setting all properties.
function decrypted_message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to decrypted_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function first_divider_Callback(hObject, eventdata, handles)
% hObject    handle to first_divider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of first_divider as text
%        str2double(get(hObject,'String')) returns contents of first_divider as a double



% --- Executes during object creation, after setting all properties.
function first_divider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_divider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function second_divider_Callback(hObject, eventdata, handles)
% hObject    handle to second_divider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of second_divider as text
%        str2double(get(hObject,'String')) returns contents of second_divider as a double


% --- Executes during object creation, after setting all properties.
function second_divider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to second_divider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function columns_multiplier_Callback(hObject, eventdata, handles)
% hObject    handle to columns_multiplier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of columns_multiplier as text
%        str2double(get(hObject,'String')) returns contents of columns_multiplier as a double


% --- Executes during object creation, after setting all properties.
function columns_multiplier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to columns_multiplier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rows_multiplier_Callback(hObject, eventdata, handles)
% hObject    handle to rows_multiplier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rows_multiplier as text
%        str2double(get(hObject,'String')) returns contents of rows_multiplier as a double


% --- Executes during object creation, after setting all properties.
function rows_multiplier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rows_multiplier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
