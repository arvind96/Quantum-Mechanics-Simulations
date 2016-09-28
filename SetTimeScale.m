function SetTimeScale(value)

global MainHandle; %stores the handle for MainGUI
global TimeScale;   %Time scale

TimeScale = value;
set(MainHandle.sliderTimeScale, 'Value', TimeScale);
set(MainHandle.textTimeScale, 'String', sprintf('%sx', num2str(TimeScale, '%.4f')));