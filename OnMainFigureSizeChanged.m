function OnMainFigureSizeChanged()

global MainHandle; %stores the handle for MainGUI
global MainFigurePosition;  %Main figure size

MainFigurePosition = getpixelposition(MainHandle.figureMain);
if(MainFigurePosition(3) < 1024)
    set(MainHandle.figureMain, 'units','pixels', 'position',[MainFigurePosition(1) MainFigurePosition(2) 1024 MainFigurePosition(4)]);
    movegui(MainHandle.figureMain,'onscreen');
end
if(MainFigurePosition(4) < 576)
    set(MainHandle.figureMain, 'units','pixels', 'position',[MainFigurePosition(1) MainFigurePosition(2) MainFigurePosition(3) 576]);
    movegui(MainHandle.figureMain,'onscreen');
end
pause(0.1)
SetLayout();