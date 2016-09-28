function SetWaveInC1(value)

global MainHandle; %stores the handle for MainGUI
global WaveInC1;    %C1 for wave

WaveInC1 = value;
set(MainHandle.sliderC1, 'Value', WaveInC1);
set(MainHandle.textC1, 'String', sprintf('C1 = %s', num2str(WaveInC1, '%.4f')));