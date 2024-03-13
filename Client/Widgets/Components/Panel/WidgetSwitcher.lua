-- A widget switcher is like a tab control, but without tabs. At most one widget is visible at time.
---@class WidgetSwitcher : PanelWidget
WidgetSwitcher = PanelWidget.Inherit("WidgetSwitcher", {
    Slot = WidgetSwitcherSlot
})

function WidgetSwitcher:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_WidgetSwitcher")
    return self
end

-- Activates the widget and makes it the active index
---@generic T
---@param self T
---@param oWidget BaseWidget
---@return T
function WidgetSwitcher:SetActiveWidget(oWidget)
    if not (oWidget or oWidget:IsValid()) then
        return self
    end

    self:CallBlueprintEvent("SetActiveWidget", oWidget)

    -- Stores the current widget.
    self:SetValue("__CurrentWidget", oWidget)

    return self
end

-- Activates the widget at the specified index.
---@generic T
---@param self T
---@param iIndex integer
---@return T
function WidgetSwitcher:SetActiveWidgetIndex(iIndex)
    self:CallBlueprintEvent("SetActiveWidgetIndex", iIndex - 1)

    -- Stores the widget index
    self:SetValue("__CurrentWidgetIndex", iIndex)

    -- Stores the current widget.
    self:SetValue("__CurrentWidget", self:GetChildrenAt(iIndex))

    return self
end

-- Gets the active widget.
---@return BaseWidget
function WidgetSwitcher:GetActiveWidget()
    return self:GetValue("__CurrentWidget")
end

-- Gets the active widget index.
---@return integer
function WidgetSwitcher:GetActiveWidgetIndex()
    return self:GetValue("__CurrentWidgetIndex", 1)
end