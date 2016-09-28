function SetApplicationState(value)

%value = -2 means set automatically(for Pause/Resume button), -1 means set
%to exit, 0 means set to idle, 1, set to running, 2 set to paused

global MainHandle; %stores the handle for MainGUI
global ApplicationState; %Keeps a track of app state, -1, After quit, 0 - Idle, 1 - Running, 2 - Paused

if(value == -2)
    if(ApplicationState == 0)
        value = 1;
    elseif(ApplicationState == 1)
        value = 2;
    elseif(ApplicationState == 2)
        value = 1;
    end
end

if(value == -1)
    ApplicationState = -1;
elseif(value == 0)
    ApplicationState = 0;
    set(MainHandle.pushbuttonPlayPause, 'String', 'START');
elseif(value == 1)
    ApplicationState = 1;
    set(MainHandle.pushbuttonPlayPause, 'String', 'PAUSE');
elseif(value == 2)
    ApplicationState = 2;
    set(MainHandle.pushbuttonPlayPause, 'String', 'RESUME');
end

