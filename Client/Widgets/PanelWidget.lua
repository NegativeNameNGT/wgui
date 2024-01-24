-- Base class for WGUI panel widgets
---@class PanelWidget : BaseWidget
PanelWidget = BaseWidget.Inherit("PanelWidget")

---@param self PanelWidget
local function OnPanelDestroy(self)
    for _,v in pairs(self:GetAllChildren()) do
        -- Removes the content widget's parent panel.
        v:SetValue("__Parent", nil)

        -- Removes the content widget's ID.
        v:SetValue("__ChildrenID", nil)

        -- Removes the content widget's slot table.
        v:SetValue("__Slot", nil)
    end
end
PanelWidget.Subscribe("Destroy", OnPanelDestroy)

-- Adds a new child widget to the panel.
---@param oContent BaseWidget
function PanelWidget:AddChild(oContent, ...)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return
    end

    -- Checks if the children count limit is reached.
    if self.ChildrenLimit and #self:GetAllChildren() >= self.ChildrenLimit then
        assert(false, "A " .. tostring(self:GetClass()) .. " can only have " .. tostring(self.ChildrenLimit) .. " children(s).")
        return false
    end

    -- Adds the content widget to the panel.
    if ... then
        self:CallBlueprintEvent("_CustomAddChild", oContent, ...)
    else
        self:CallBlueprintEvent("AddChild", oContent)
    end

    -- Adds the content widget to the panel's children list.
    local tChildren = self:GetAllChildren()
    table.insert(tChildren, oContent)
    self:SetValue("__Children", tChildren)

    -- Sets the content widget's parent panel.
    oContent:SetValue("__Parent", self)

    -- Sets the content widget's ID.
    oContent:SetValue("__ChildrenID", #tChildren)

    -- Sets the content widget's slot table.
    oContent:SetValue("__Slot", {})

    -- Dynamically adds the slot class functions to the content widget.
    local oSlotClass = self.Slot
    if oSlotClass then
        for k,v in pairs(oSlotClass) do
            oContent[k] = v
        end
    end
end

-- Removes a child widget from the panel.
---@param oContent BaseWidget
---@return boolean
function PanelWidget:RemoveChild(oContent)
    -- Checks if the content widget is valid.
    if not (oContent or oContent:IsValid()) then
        return false
    end

    -- Removes the content widget from the panel.
    if (not self:CallBlueprintEvent("RemoveChild", oContent)) then
        return false
    end

    -- Removes the content widget from the panel's children list.
    local tChildren = self:GetAllChildren()

    local iIndexToRemove = oContent:GetValue("__ChildrenID")
    table.remove(tChildren, iIndexToRemove)

    -- Updates the children IDs.
    for i = iIndexToRemove, #tChildren do
        tChildren[i]:SetValue("__ChildrenID", i)
    end

    self:SetValue("__Children", tChildren)

    -- Removes the content widget's parent panel.
    oContent:SetValue("__Parent", nil)

    -- Removes the content widget's ID.
    oContent:SetValue("__ChildrenID", nil)

    -- Removes the content widget's slot table.
    oContent:SetValue("__Slot", nil)

    -- Removes the slot class functions from the content widget.
    local oSlotClass = self.Slot
    if oSlotClass then
        for k,v in pairs(oSlotClass) do
            oContent[k] = nil
        end
    end

    return true
end

-- Removes all children from the panel.
function PanelWidget:ClearChildren()
    for _,v in ipairs(self:GetAllChildren()) do
        self:RemoveChild(v)
    end
end

-- Removes a child widget from the panel by index.
---@param iIndex integer
---@return boolean
function PanelWidget:RemoveChildAt(iIndex)
    return self:RemoveChild(self:GetAllChildren()[iIndex])
end

-- Returns the index of the specified child widget.
---@param oContent BaseWidget
---@return integer
function PanelWidget:GetChildrenIndex(oContent)
    return oContent:GetValue("__ChildrenID")
end

-- Returns the child widget at the specified index.
---@param iIndex integer
---@return BaseWidget
function PanelWidget:GetChildrenAt(iIndex)
    return self:GetAllChildren()[iIndex]
end

-- Returns all children of the panel.
---@return table<integer, BaseWidget>
function PanelWidget:GetAllChildren()
    return self:GetValue("__Children", {})
end