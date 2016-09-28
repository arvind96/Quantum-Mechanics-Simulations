function Quit()

global MainHandle; %stores the handle for MainGUI
global AboutHandle; %stores the handle for AboutGUI

if(ishandle(AboutHandle))
    delete(AboutHandle);
end

Reset();

delete(MainHandle.figureMain);