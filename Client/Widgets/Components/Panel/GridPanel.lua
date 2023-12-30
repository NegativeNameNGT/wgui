---@class GridPanel : PanelWidget
GridPanel = PanelWidget.Inherit("GridPanel", {
    CustomAddChild = true,
})

function GridPanel:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_GridPanel")
    return self
end

local _AddChild = GridPanel.AddChild

-- Adds a new child widget to the panel.
---@param oContent BaseWidget
---@param iInRow integer
---@param iInColumn integer
function GridPanel:AddChild(oContent, iInRow, iInColumn)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return
    end

    _AddChild(self, oContent, iInRow or 0, iInColumn or 0)
end

---@param iColumnIndex integer
---@param fCoefficient number
function GridPanel:SetColumnFill(iColumnIndex, fCoefficient)
    self:CallBlueprintEvent("SetColumnFill", iColumnIndex, fCoefficient)
end

---@param iRowIndex integer
---@param fCoefficient number
function GridPanel:SetRowFill(iRowIndex, fCoefficient)
    self:CallBlueprintEvent("SetRowFill", iRowIndex, fCoefficient)
end