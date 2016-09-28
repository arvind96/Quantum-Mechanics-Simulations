function SetWaveInC3(value)

global MainHandle; %stores the handle for MainGUI
global WaveInC3;    %C3 for wave

WaveInC3 = value;
set(MainHandle.sliderC3, 'Value', WaveInC3);
set(MainHandle.textC3, 'String', sprintf('C3 = %s', num2str(WaveInC3, '%.4f')));