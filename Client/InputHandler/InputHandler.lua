---@type table<BaseWidget, boolean>
local tWidgetToHandle = {}

-- Re-calculates the input rules
function WGUI.HandleInputRules()
    local bMouseEnabled, bKeyboardEnabled = WGUI.GetInputRules()

    Input.SetMouseEnabled(bMouseEnabled)
    Input.SetInputEnabled(bKeyboardEnabled)
end

-- Returns the input rules.
---@return boolean @ Whether the mouse should be enabled
---@return boolean @ Whether the keyboard should be enabled
function WGUI.GetInputRules()
    local bMouseEnabled = false
    local bKeyboardEnabled = true

    for oWidget, _ in pairs(tWidgetToHandle) do
        if not oWidget:IsVisible() then
            goto continue
        end

        if not bMouseEnabled and oWidget:GetMouseEnabled() then
            bMouseEnabled = true
        end

        if bKeyboardEnabled and not oWidget:GetKeyboardEnabled() then
            bKeyboardEnabled = false
        end

        ::continue::
    end

    return bMouseEnabled, bKeyboardEnabled
end

-- Whether or not the mouse should be enabled for this widget.
---@param bIsEnabled boolean
function BaseWidget:SetMouseEnabled(bIsEnabled)
    self:SetValue("__IsMouseEnabled", bIsEnabled)

    if not bIsEnabled and self:GetKeyboardEnabled() then
        tWidgetToHandle[self] = nil
    else
        tWidgetToHandle[self] = true
    end

    WGUI.HandleInputRules()
end

-- Returns whether or not the mouse is enabled for this widget.
---@return boolean
function BaseWidget:GetMouseEnabled()
    return self:GetValue("__IsMouseEnabled", false)
end

-- Whether or not the keyboard should be enabled for this widget.
---@param bIsEnabled boolean
function BaseWidget:SetKeyboardEnabled(bIsEnabled)
    self:SetValue("__IsKeyboardEnabled", bIsEnabled)

    if not bIsEnabled and not self:GetMouseEnabled() then
        tWidgetToHandle[self] = nil
    else
        tWidgetToHandle[self] = true
    end

    WGUI.HandleInputRules()
end

-- Returns whether or not the keyboard is enabled for this widget.
---@return boolean
function BaseWidget:GetKeyboardEnabled()
    return self:GetValue("__IsKeyboardEnabled", true)
end

Events.Subscribe("WGUI::WidgetVisibilityChanged", WGUI.HandleInputRules)
BaseWidget.Subscribe("Destroy", function (self)
    if tWidgetToHandle[self] then
        tWidgetToHandle[self] = nil
        WGUI.HandleInputRules()
    end
end)