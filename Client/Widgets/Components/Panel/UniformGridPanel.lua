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
---@param oContent BaseWidget
---@param iInRow integer
---@param iInColumn integer
function UniformGridPanel:AddChild(oContent, iInRow, iInColumn)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return
    end

    _AddChild(self, oContent, iInRow or 0, iInColumn or 0)
end

-- Sets the padding of the panel's slots.
---@param Padding Margin
function UniformGridPanel:SetSlotPadding(Padding)
    self:CallBlueprintEvent("SetSlotPadding", Padding or {})
end

-- Sets the minimum desired slot width.
---@param fMinDesiredSlotWidth number
function UniformGridPanel:SetMinDesiredSlotWidth(fMinDesiredSlotWidth)
    self:CallBlueprintEvent("SetMinDesiredSlotWidth", fMinDesiredSlotWidth)
end

-- Sets the minimum desired slot height.
---@param fMinDesiredSlotHeight number
function UniformGridPanel:SetMinDesiredSlotHeight(fMinDesiredSlotHeight)
    self:CallBlueprintEvent("SetMinDesiredSlotHeight", fMinDesiredSlotHeight)
end