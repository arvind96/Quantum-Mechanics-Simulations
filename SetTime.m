function SetTime(value)
global MainHandle; %stores the handle for MainGUI
global Timer;   %Timer

Timer = value;
set(MainHandle.textTimer, 'String', sprintf('Time: %ss', num2str(Timer, '%.4f')));