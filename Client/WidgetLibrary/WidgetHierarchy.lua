---@class WidgetHierarchy : TreeView
---`WidgetHierarchy` is a scrollable list of a widget's hierarchy.
WidgetHierarchy = TreeView.Inherit("WidgetHierarchy")

function WidgetHierarchy:Constructor()
    TreeView.Constructor(self)

    -- Sets the selection mode to multiple.
    self:SetSelectionMode(ListViewSelectionMode.Single)

    -- Called when a entry is generated.
    self:BindDispatcher("GenerateInternalWidget", function ()
        local oHierarchyItem = WGUI.Create(WidgetHierarchyItem)
        oHierarchyItem:SetVisibility(WGUIVisibility.Visible)
        return oHierarchyItem
    end)

    -- Updates the internal widget with the data.
    ---@param InternalWidget WidgetHierarchyItem
    self:BindDispatcher("UpdateInternalWidget", function (self, Item, InternalWidget)
        local oAssociatedWidget = Item:GetData()
        InternalWidget:Update(oAssociatedWidget)
    end)

    -- Called when the selection has changed.
    ---@param InternalWidget WidgetHierarchyItem
    self:BindDispatcher("EntrySelectionChanged", function (self, InternalWidget, _, bIsSelected)
        InternalWidget:SetSelected(bIsSelected)
    end)

    -- Called when the expansion state of an item has changed.
    ---@param InternalWidget WidgetHierarchyItem
    self:BindDispatcher("ExpansionChanged", function (self, _, InternalWidget, bIsExpanded)
        InternalWidget:SetExpanded(bIsExpanded)
    end)
end

--- Dynamically called when the childrens of a widget are requested.
---@param oRootItem ViewItem
function WidgetHierarchy:OnGetItemChildrenData(oRootItem)
    local oWidget = oRootItem:GetData() ---@type BaseWidget | PanelWidget
    if oWidget:IsA(PanelWidget) then
        return oWidget:GetAllChildren()
    end
    return {}
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

    local oRootItem = ViewItem()
    oRootItem:SetData(oRootWidget)

    self:AddItem(oRootItem)

    return self
end