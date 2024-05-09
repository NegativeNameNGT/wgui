---<img src="https://github.com/Derpius/nanosworld-vscode/blob/master/assets/client-only.png?raw=true" height="10"> `Client Side`
---
---Calls a Blueprint Event or Function<br/>Returns all Function return values on <strong>Client Side</strong>
---@param event_name string @Event or Function name
---@param ...? any @Sequence of arguments to pass to the event (Default: nil)
---@return any... @the function return values
function BaseWidget:CallBlueprintEvent(event_name, ...) end