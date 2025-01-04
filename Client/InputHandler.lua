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
        local bCanHandle = oWidget:GetForceInputRules() or oWidget:IsVisible() and oWidget:GetParent()

        if not bCanHandle then
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

    return self
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

    return self
end

-- Returns whether or not the keyboard is enabled for this widget.
---@return boolean
function BaseWidget:GetKeyboardEnabled()
    return self:GetValue("__IsKeyboardEnabled", true)
end

-- Sets whether or not the widget should force the input rules to be recalculated no matter if it is visible or not.
---@param bForce boolean
function BaseWidget:SetForceInputRules(bForce)
    self:SetValue("__ForceInputRules", bForce)
end

-- Returns whether or not the widget should force the input rules to be recalculated no matter if it is visible or not.
---@return boolean
function BaseWidget:GetForceInputRules()
    return self:GetValue("__ForceInputRules", false)
end

Events.Subscribe("WGUI::WidgetVisibilityChanged", WGUI.HandleInputRules)
Events.Subscribe("WGUI::ChildrenAdded", WGUI.HandleInputRules)
Events.Subscribe("WGUI::ChildrenRemoved", WGUI.HandleInputRules)
BaseWidget.Subscribe("Destroy", function (self)
    if tWidgetToHandle[self] then
        tWidgetToHandle[self] = nil
        WGUI.HandleInputRules()
    end
end)