function SetOtherSliderValue3(value)

global MainHandle; %stores the handle for MainGUI
global OtherSliderValue3;

OtherSliderValue3 = value;
set(MainHandle.sliderOther3, 'Value', OtherSliderValue3);
OnOtherSliderValueChange(3);