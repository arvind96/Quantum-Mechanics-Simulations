function Start()

global MainHandle; %stores the handle for MainGUI
global ScreenSize;  %Screen size array
global DefaultAspectRatio;  %Default aspect ration for reference
global MainFigurePosition;  %Main figure size

global SizeChangeCalled;
SizeChangeCalled = 0;

ScreenSize = get(groot, 'ScreenSize');
set(MainHandle.figureMain, 'units','normalized','outerposition',[0.05 0.1 0.95 0.9]);
movegui(MainHandle.figureMain,'center');

DefaultAspectRatio = 16.0/9.0;
MainFigurePosition = getpixelposition(MainHandle.figureMain);

a = findall(MainHandle.figureMain);
set(findall(a, 'ToolTipString', 'New Figure'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Save Figure'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Open File'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Print Figure'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Edit Plot'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Link Plot'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Data Cursor'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Brush/Select Data'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Hide Plot Tools'), 'Visible', 'Off');
set(findall(a, 'ToolTipString', 'Show Plot Tools and Dock Figure'), 'Visible', 'Off');

set(MainHandle.axesEquations,'box','off','color','none');
set(MainHandle.axesEquations, 'xtick',[],'ytick',[]);
set(MainHandle.axesEquations, 'xcolor', 'none', 'ycolor', 'none');

SetCurrentSimulation(11);
Reset();

%.....
%
%[a, map] = imread('play.jpg');
%[r,c,d] = size(a);
%x = ceil(r/30);
%y = ceil(c/30);
%g = a(1:x:end, 1:y:end,:);
%g(g==255)=5.5*255;
%set(MainHandle.pushbuttonNext,'CData',g);

%setHandles([getHandles() hObject]);