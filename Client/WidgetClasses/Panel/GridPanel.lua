-- A table-like panel that retains the width of every column throughout the table.
---@class GridPanel : PanelWidget
GridPanel = PanelWidget.Inherit("GridPanel", {
    CustomAddChild = true,
    Slot = GridPanelSlot
})

function GridPanel:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_GridPanel")
    return self
end

local _AddChild = GridPanel.AddChild

-- Adds a new child widget to the panel.
---@generic T
---@param self T
---@param oContent BaseWidget
---@param iInRow integer
---@param iInColumn integer
---@return T
function GridPanel:AddChild(oContent, iInRow, iInColumn)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return self
    end

    _AddChild(self, oContent, iInRow or 0, iInColumn or 0)

    return self
end

---@generic T
---@param self T
---@param iColumnIndex integer
---@param fCoefficient number
---@return T
function GridPanel:SetColumnFill(iColumnIndex, fCoefficient)
    self:CallBlueprintEvent("SetColumnFill", iColumnIndex, fCoefficient)

    return self
end

---@generic T
---@param self T
---@param iRowIndex integer
---@param fCoefficient number
---@return T
function GridPanel:SetRowFill(iRowIndex, fCoefficient)
    self:CallBlueprintEvent("SetRowFill", iRowIndex, fCoefficient)

    return self
end