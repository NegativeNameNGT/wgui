---@class WidgetHierarchy : TreeView
---`WidgetHierarchy` is a scrollable list of a widget's hierarchy.
WidgetHierarchy = TreeView.Inherit("WidgetHierarchy")

function WidgetHierarchy:Constructor()
    TreeView.Constructor(self)

    -- Sets the selection mode to multiple.
    self:SetSelectionMode(ListViewSelectionMode.Multi)

    -- Called when a entry is generated.
    self:BindDispatcher("GenerateInternalWidget", function ()
        local oHierarchyItem = WGUI.Create(WidgetHierarchyItem)
        oHierarchyItem:SetVisibility(WGUIVisibility.Visible)
        return oHierarchyItem
    end)

    -- Updates the internal widget with the data.
    ---@param EntryWidget WidgetHierarchyItem
    self:BindDispatcher("UpdateInternalWidget", function (_, ItemIndex, EntryWidget)
        local oWidget = self:GetItemData(ItemIndex)
        EntryWidget:Update(oWidget, ItemIndex)
    end)

    -- Called when the selection has changed.
    ---@param oWidget WidgetHierarchyItem
    self:BindDispatcher("EntrySelectionChanged", function (_, oWidget, bIsSelected)
        oWidget:SetSelected(bIsSelected)
    end)

    -- Called when the item is expanded.
    self:BindDispatcher("ItemExpansionChanged", function (self, ItemIndex, bIsExpanded)

    end)
end

--- Dynamically called when the childrens of a widget are requested.
---@param oWidget BaseWidget | PanelWidget
function WidgetHierarchy:OnGetItemChildren(oWidget)
    if oWidget:IsA(PanelWidget) then
        return oWidget:GetAllChildren()
    end
    return {}
end

-- Adds a widget to the hierarchy.
---@param self WidgetHierarchy
---@param oWidget BaseWidget | PanelWidget @The widget to add.
local function AddWidget(self, oWidget)
    if not oWidget or not oWidget:IsValid() then
        return
    end

    local sClassName = tostring(oWidget:GetClass())
    local sFriendlyClassName = string.sub(sClassName, 1, #sClassName - 6) -- Remove " Class" suffix
    self:AddItem(sFriendlyClassName)
end

-- Recursively adds all children of a widget to the hierarchy.
---@param self WidgetHierarchy
---@param oWidget BaseWidget | PanelWidget @The widget to add.
---@param bIgnoreRoot boolean @If true, the root widget will not be added to the hierarchy.
local function AddHierarchy(self, oWidget, bIgnoreRoot)
    if not oWidget or not oWidget:IsValid() then
        return
    end

    if not bIgnoreRoot then
        AddWidget(self, oWidget)
    end

    if oWidget:IsA(PanelWidget) then
        for _, oChildren in ipairs(oWidget:GetAllChildren()) do
            AddHierarchy(self, oChildren, false)
        end
    end
end

-- Rebuilds the widget hierarchy.
---@param oRootWidget BaseWidget | nil @If nil, it will use the WGUI layout canvas as the root widget.
function WidgetHierarchy:Rebuild(oRootWidget)
    oRootWidget = oRootWidget or WGUI.GetLayout()

    if not oRootWidget or not oRootWidget:IsValid() then
        Console.Warn("Invalid root widget provided for rebuilding widget hierarchy.")
        return self
    end

    -- Clear the current list of widgets.
    self:ClearListItems()

    --AddHierarchy(self, oRootWidget, true)
    self:AddItem(oRootWidget)

    return self
end