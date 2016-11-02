function OnOtherSliderValueChange(sliderId)

global MainHandle; %stores the handle for MainGUI

switch GetCurrentSimulation()
    case 11
        set(MainHandle.textOther1, 'String', sprintf('L = %s', num2str(GetOtherSliderValue1(), '%.2f')));
        xlim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
        xlim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
        xlim(MainHandle.axes3, [0 GetOtherSliderValue1()]);
    case 12
        set(MainHandle.textOther1, 'String', sprintf('L = %s', num2str(GetOtherSliderValue1(), '%.2f')));
        xlim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
        ylim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
        xlim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
        ylim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
    case 21
        
    case 51
        if(sliderId == 1)
            set(MainHandle.sliderOther2, 'Min', 0.00, 'Max', GetOtherSliderValue1() - 1 + 0.1);
            SetOtherSliderValue2(0.00);
        elseif(sliderId == 2)
            set(MainHandle.sliderOther3, 'Min', 0.00, 'Max', GetOtherSliderValue2() + 0.1);
            SetOtherSliderValue3(0.00);
        end
            set(MainHandle.textOther1, 'String', sprintf('n = %s', num2str(round(GetOtherSliderValue1()))));
            set(MainHandle.textOther2, 'String', sprintf('l = %s', num2str(round(GetOtherSliderValue2()))));
            set(MainHandle.textOther3, 'String', sprintf('m = %s', num2str(round(GetOtherSliderValue3()))));
    otherwise %may be use case 11

end