---@type table<BaseWidget, boolean>
local tWidgetToHandle = {}

-- Re-calculates the input rules
function WGUI.HandleInputRules()
    local bMouseEnabled = WGUI.GetInputRules()

    Input.SetMouseEnabled(bMouseEnabled)
end

-- Returns the input rules.
---@return boolean @ Whether the mouse should be enabled
function WGUI.GetInputRules()
    local bMouseEnabled = false

    for oUI, _ in pairs(tWidgetToHandle) do
        if oUI:GetMouseEnabled() and oUI:IsVisible() then
            bMouseEnabled = true
            break
        end
    end

    return bMouseEnabled
end

-- Whether or not the mouse should be enabled for this widget.
---@param bIsEnabled boolean
function BaseWidget:SetMouseEnabled(bIsEnabled)
    self:SetValue("__IsMouseEnabled", bIsEnabled)

    if bIsEnabled then
        tWidgetToHandle[self] = true
    else
        tWidgetToHandle[self] = nil
    end

    WGUI.HandleInputRules()
end

-- Returns whether or not the mouse is enabled for this widget.
---@return boolean
function BaseWidget:GetMouseEnabled()
    return self:GetValue("__IsMouseEnabled", false)
end

Events.Subscribe("WGUI::WidgetVisibilityChanged", WGUI.HandleInputRules)
BaseWidget.Subscribe("Destroy", function (self) self:SetMouseEnabled(false) end)