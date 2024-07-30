-- Similar to ListView, but can display a hierarchical tree of elements.
---@class TreeView : ListView
---@field public OnGetItemChildrenData fun(self: TreeView, Data: any)
---@field private __ItemData table<integer, ViewItem>
TreeView = ListView.Inherit("TreeView", {
    Icon = "package://wgui/Client/Textures/Icons/TreeView.png"
})

-- Constructor
function TreeView:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_TreeView")

    self:BindDispatcher("ExpansionChanged", function (_, Item, _, bIsExpanded)
        self:SetItemExpansionState(Item, bIsExpanded)
    end)
end

-- Assigns and Binds a Blueprint Event Dispatcher
---@param sEventName string
---@param fnCallback function
---@overload fun(self: BaseWidget, sEventName: "GenerateInternalWidget", fnCallback: fun(self: BaseWidget) : BaseWidget)
---@overload fun(self: BaseWidget, sEventName: "UpdateInternalWidget", fnCallback: fun(self: BaseWidget, Item: ViewItem, InternalWidget: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "ListViewScrolled", fnCallback: fun(self: BaseWidget, ItemOffset: number, DistanceRemaining: number))
---@overload fun(self: BaseWidget, sEventName: "EntrySelectionChanged", fnCallback: fun(self: BaseWidget, InternalWidget: BaseWidget, Item: ViewItem, bIsSelected: boolean))
---@overload fun(self: BaseWidget, sEventName: "ItemSelectionChanged", fnCallback: fun(self: BaseWidget, Item: ViewItem, bIsSelected: boolean))
---@overload fun(self: BaseWidget, sEventName: "ExpansionChanged", fnCallback: fun(self: BaseWidget, Item: ViewItem, InternalWidget: BaseWidget, bIsExpanded: boolean))
---@overload fun(self: BaseWidget, sEventName: "MouseButtonDown", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseButtonUp", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseMove", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseEnter", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseLeave", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseWheel", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "MouseDoubleClick", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "FocusReceived", fnCallback: fun(self: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "FocusLost", fnCallback: fun(self: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "DragDetected", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "DragOver", fnCallback: fun(self: BaseWidget, PointerEvent: PointerEvent))
---@overload fun(self: BaseWidget, sEventName: "Drop", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@overload fun(self: BaseWidget, sEventName: "DragCancelled", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@return function | nil
function TreeView:BindDispatcher(sEventName, fnCallback)
    return ListView.BindDispatcher(self, sEventName, fnCallback)
end

-- Expands the specified item.
---@param oItem ViewItem
---@param bIsExpanded boolean
function TreeView:SetItemExpansionState(oItem, bIsExpanded)
    if bIsExpanded then
        local tChildrenData = self:OnGetItemChildrenData(oItem)

        if type(tChildrenData) ~= "table" then
            tChildrenData = {tChildrenData}
        end

        local tChildrenItems = {}
        for _, xChildData in ipairs(tChildrenData) do
            table.insert(tChildrenItems, ViewItem():SetData(xChildData))
        end

        self:InsertItemsAt(tChildrenItems, oItem:GetIndex(), true)

        -- Store the children items within the parent item.
        oItem.__ChildrenItems = tChildrenItems
    else
        local iItemIndex = oItem:GetIndex()

        self:CallBlueprintEvent("TreeView_RemoveItemChilds", iItemIndex - 1)

        for _, oChildItem in pairs(oItem.__ChildrenItems) do
            local iChildIndex = oChildItem:GetIndex()
            table.remove(self.__ItemData, iChildIndex)
        end

        oItem.__ChildrenItems = nil
        self:RefreshItemIndexes()
    end
end