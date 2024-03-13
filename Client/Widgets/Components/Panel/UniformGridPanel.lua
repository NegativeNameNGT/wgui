-- A panel that evenly divides up available space between all of its children.
---@class UniformGridPanel : PanelWidget
UniformGridPanel = PanelWidget.Inherit("UniformGridPanel", {
    CustomAddChild = true,
    Slot = UniformGridPanelSlot
})

function UniformGridPanel:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_UniformGridPanel")
    return self
end

local _AddChild = UniformGridPanel.AddChild

-- Adds a new child widget to the panel.
---@generic T
---@param self T
---@param oContent BaseWidget
---@param iInRow integer
---@param iInColumn integer
---@return T
function UniformGridPanel:AddChild(oContent, iInRow, iInColumn)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return self
    end

    _AddChild(self, oContent, iInRow or 0, iInColumn or 0)

    return self
end

-- Sets the padding of the panel's slots.
---@generic T
---@param self T
---@param Padding Margin
---@return T
function UniformGridPanel:SetSlotPadding(Padding)
    self:CallBlueprintEvent("SetSlotPadding", Padding or {})

    return self
end

-- Sets the minimum desired slot width.
---@generic T
---@param self T
---@param fMinDesiredSlotWidth number
---@return T
function UniformGridPanel:SetMinDesiredSlotWidth(fMinDesiredSlotWidth)
    self:CallBlueprintEvent("SetMinDesiredSlotWidth", fMinDesiredSlotWidth)

    return self
end

-- Sets the minimum desired slot height.
---@generic T
---@param self T
---@param fMinDesiredSlotHeight number
---@return T
function UniformGridPanel:SetMinDesiredSlotHeight(fMinDesiredSlotHeight)
    self:CallBlueprintEvent("SetMinDesiredSlotHeight", fMinDesiredSlotHeight)

    return self
end