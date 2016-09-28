function SetWaveInC2(value)

global MainHandle; %stores the handle for MainGUI
global WaveInC2;    %C2 for wave

WaveInC2 = value;
set(MainHandle.sliderC2, 'Value', WaveInC2);
set(MainHandle.textC2, 'String', sprintf('C2 = %s', num2str(WaveInC2, '%.4f')));