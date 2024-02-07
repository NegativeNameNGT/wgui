_WSS.WidgetClasses = {}

-- Registers a widget class.
---@param cWidgetClass BaseWidget
local function RegisterWidgetClass(cWidgetClass)
    _WSS.WidgetClasses[tostring(cWidgetClass)] = cWidgetClass
end

-- Stores all the current widget classes
for _, cWidgetClass in pairs(BaseWidget.GetInheritedClasses(true)) do
    RegisterWidgetClass(cWidgetClass)
end

-- Register an event to be called when a new widget class is registered.
---@param cClass BaseWidget
local function OnWidgetClassRegister(cClass)
    RegisterWidgetClass(cClass)
end
BaseWidget.Subscribe("ClassRegister", OnWidgetClassRegister)