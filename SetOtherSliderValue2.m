function SetOtherSliderValue2(value)

global MainHandle; %stores the handle for MainGUI
global OtherSliderValue2;

OtherSliderValue2 = value;
set(MainHandle.sliderOther2, 'Value', OtherSliderValue2);
OnOtherSliderValueChange(2);