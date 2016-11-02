function SetOtherSliderValue1(value)

global MainHandle; %stores the handle for MainGUI
global OtherSliderValue1;   %value of the first other slider

OtherSliderValue1 = value;
set(MainHandle.sliderOther1, 'Value', OtherSliderValue1);
OnOtherSliderValueChange(1);