function varargout = MainGUI(varargin)
% MAINGUI MATLAB code for MainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainGUI

% Last Modified by GUIDE v2.5 01-Nov-2016 18:30:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainGUI_OutputFcn, ...
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


% --- Executes just before MainGUI is made visible.
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI (see VARARGIN)

% Choose default command line output for MainGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainGUI wait for user response (see UIRESUME)
% uiwait(handles.figureMain);

global MainHandle;
MainHandle = handles;
Start();


% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
    

% --- Executes when figureMain is resized.
function figureMain_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figureMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SizeChangeCalled;

if(SizeChangeCalled == 0)
    SizeChangeCalled = 1;
    pause(0.1);
    SizeChangeCalled = 0;
    OnMainFigureSizeChanged();
end


% --- Executes when user attempts to close figureMain.
function figureMain_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figureMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Quit();


% --------------------------------------------------------------------
function menu_Help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_About_Callback(hObject, eventdata, handles)
% hObject    handle to menu_About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global AboutHandle;

if(isempty(AboutHandle) || ~ishandle(AboutHandle))
    AboutHandle = openfig('AboutGUI.fig', 'visible');
end
figure(AboutHandle);
movegui(AboutHandle,'center');


% --------------------------------------------------------------------
function menu_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Quit();


% --------------------------------------------------------------------
function menu_ParticleInBox_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ParticleInBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_ParticleInBox_1D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ParticleInBox_1D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(11);
Reset();

% --------------------------------------------------------------------
function menu_ParticleInBox_2D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ParticleInBox_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(12);
Reset();

% --------------------------------------------------------------------
function menu_HarmonicsOscillator_Callback(hObject, eventdata, handles)
% hObject    handle to menu_HarmonicsOscillator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonPlayPause.
function pushbuttonPlayPause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlayPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Simulate();

% --- Executes on button press in pushbuttonStepNext.
function pushbuttonStepNext_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStepNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonStepBack.
function pushbuttonStepBack_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStepBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonReset.
function pushbuttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Reset();


% --- Executes on slider movement.
function sliderTimeScale_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTimeScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetTimeScale(get(hObject, 'Value'));

% --- Executes during object creation, after setting all properties.
function sliderTimeScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTimeScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --------------------------------------------------------------------
function context_TimeScale_200x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_200x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(2.00);

% --------------------------------------------------------------------
function context_TimeScale_150x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_150x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(1.50);

% --------------------------------------------------------------------
function context_TimeScale_100x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_100x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(1.00);


% --------------------------------------------------------------------
function context_TimeScale_75x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_75x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(0.75);


% --------------------------------------------------------------------
function context_TimeScale_50x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_50x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(0.50);


% --------------------------------------------------------------------
function context_TimeScale_25x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_25x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(0.25);


% --------------------------------------------------------------------
function context_TimeScale_0x_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale_0x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTimeScale(0.00);


% --------------------------------------------------------------------
function MyContextMenu_Callback(hObject, eventdata, handles)
% hObject    handle to MyContextMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function context_TimeScale_Callback(hObject, eventdata, handles)
% hObject    handle to context_TimeScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function sliderC1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetWaveInC1(get(hObject, 'Value'));
if(GetWaveInC1Priority() ~= 3)
SetWaveInC1Priority(3);
SetWaveInC2Priority(GetWaveInC2Priority() - 1);
SetWaveInC3Priority(GetWaveInC3Priority() - 1);
end
NormalizeC();


% --- Executes during object creation, after setting all properties.
function sliderC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderC2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetWaveInC2(get(hObject, 'Value'));
if(GetWaveInC2Priority() ~= 3)
SetWaveInC1Priority(GetWaveInC1Priority() - 1);
SetWaveInC2Priority(3);
SetWaveInC3Priority(GetWaveInC3Priority() - 1);
end
NormalizeC();


% --- Executes during object creation, after setting all properties.
function sliderC2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderC3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetWaveInC3(get(hObject, 'Value'));
if(GetWaveInC3Priority() ~= 3)
SetWaveInC1Priority(GetWaveInC1Priority() - 1);
SetWaveInC2Priority(GetWaveInC2Priority() - 1);
SetWaveInC3Priority(3);
end
NormalizeC();


% --- Executes during object creation, after setting all properties.
function sliderC3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_HarmonicsOscillator_1D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_HarmonicsOscillator_1D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(21);
Reset();

% --------------------------------------------------------------------
function menu_HarmonicsOscillator_2D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_HarmonicsOscillator_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(22);
Reset();


% --------------------------------------------------------------------
function menu_FreeParticle_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FreeParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_FiniteSquareWell_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FiniteSquareWell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_FiniteSquareWell_1D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FiniteSquareWell_1D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(31);
Reset();


% --------------------------------------------------------------------
function menu_HydrogenAtom_Callback(hObject, eventdata, handles)
% hObject    handle to menu_HydrogenAtom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_HydrogenAtom_ProbabilityDensity_Callback(hObject, eventdata, handles)
% hObject    handle to menu_HydrogenAtom_ProbabilityDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetCurrentSimulation(51);
Reset();


% --------------------------------------------------------------------
function menu_FiniteSquareWell_2D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FiniteSquareWell_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_FreeParticle_1D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FreeParticle_1D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_FreeParticle_2D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_FreeParticle_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function sliderOther3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOther3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetOtherSliderValue3(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderOther3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOther3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOther2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOther2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetOtherSliderValue2(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderOther2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOther2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOther1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOther1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
SetOtherSliderValue1(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderOther1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOther1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function menu_Tools_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_View_Callback(hObject, eventdata, handles)
% hObject    handle to menu_View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_Tools_Zoom_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Tools_Zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom;

% --------------------------------------------------------------------
function menu_Tools_Pan_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Tools_Pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pan;

% --------------------------------------------------------------------
function menu_Tools_Rotate3D_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Tools_Rotate3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotate3d;
