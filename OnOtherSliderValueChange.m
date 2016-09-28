function OnOtherSliderValueChange()

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
        
    otherwise %may be use case 11

end