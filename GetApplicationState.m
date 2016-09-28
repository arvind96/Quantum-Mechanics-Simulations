function r = GetApplicationState()

global ApplicationState; %Keeps a track of app state, -1, After quit, 0 - Idle, 1 - Running, 2 - Paused

r = ApplicationState;