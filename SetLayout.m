function SetLayout()

global MainHandle; %stores the handle for MainGUI
global MainFigurePosition;  %Main figure size

set(MainHandle.uipanelBottomControls, 'units', 'pixels', 'position', [5, 7, MainFigurePosition(3) - 10, 50]);
set(MainHandle.uipanelTime, 'units', 'pixels', 'position', [MainFigurePosition(3) - 10 - 207, 5, 200, 40]);

set(MainHandle.uipanelTopControls, 'units', 'pixels', 'position', [5, MainFigurePosition(4) - 165, MainFigurePosition(3) - 10, 165]);

set(MainHandle.uipanelEquations, 'units', 'pixels', 'position', [395, 5, MainFigurePosition(3) - 10 - 400, 145]);
set(MainHandle.uipanelEquationsInside, 'units', 'pixels', 'position', [4, 5, MainFigurePosition(3) - 10 - 400 - 10, 125]);
set(MainHandle.axesEquations, 'units', 'pixels', 'position', [10, 5, MainFigurePosition(3) - 10 - 400 - 10 - 20, 115]);

axesWidth = (MainFigurePosition(3) - 20)/3;
axesHeight = (MainFigurePosition(4) - 230);

set(MainHandle.uipanelAxes1, 'units', 'pixels', 'position', [5, 65, axesWidth, axesHeight]);
set(MainHandle.uipanelAxes2, 'units', 'pixels', 'position', [10 + axesWidth, 65, axesWidth, axesHeight]);
set(MainHandle.uipanelAxes3, 'units', 'pixels', 'position', [15 + axesWidth * 2, 65, axesWidth, axesHeight]);

set(MainHandle.axes1, 'units', 'pixels', 'position', [55, 45, axesWidth - 60, axesHeight - 65]);
set(MainHandle.axes2, 'units', 'pixels', 'position', [55, 45, axesWidth - 60, axesHeight - 65]);
set(MainHandle.axes3, 'units', 'pixels', 'position', [55, 45, axesWidth - 60, axesHeight - 65]);







