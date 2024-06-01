-- Similar to ListView, but can display a hierarchical tree of elements.
---@class TreeView : ListView
---@field public OnGetItemChildren fun(self: TreeView, Data: any)
TreeView = ListView.Inherit("TreeView", {
    Icon = "package://wgui/Client/Textures/Icons/TreeView.png"
})

-- Constructor
function TreeView:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_TreeView")
end

-- Assigns and Binds a Blueprint Event Dispatcher
---@param sEventName string
---@param fnCallback function
---@overload fun(self: BaseWidget, sEventName: "GenerateInternalWidget", fnCallback: fun(self: BaseWidget) : BaseWidget)
---@overload fun(self: BaseWidget, sEventName: "UpdateInternalWidget", fnCallback: fun(self: BaseWidget, ItemIndex: integer, EntryWidget: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "ListViewScrolled", fnCallback: fun(self: BaseWidget, ItemOffset: number, DistanceRemaining: number))
---@overload fun(self: BaseWidget, sEventName: "EntrySelectionChanged", fnCallback: fun(self: BaseWidget, EntryWidget: BaseWidget, bIsSelected: boolean))
---@overload fun(self: BaseWidget, sEventName: "ItemSelectionChanged", fnCallback: fun(self: BaseWidget, ItemIndex: integer, bIsSelected: boolean))
---@overload fun(self: BaseWidget, sEventName: "ItemExpansionChanged", fnCallback: fun(self: BaseWidget, ItemIndex: integer, bIsExpanded: boolean))
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
---@overload fun(self: BaseWidget, sEventName: "Drop", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@overload fun(self: BaseWidget, sEventName: "DragCancelled", fnCallback: fun(self: BaseWidget, PayloadID: integer, Tag: string))
---@return function | nil
function TreeView:BindDispatcher(sEventName, fnCallback)
    return ListView.BindDispatcher(self, sEventName, fnCallback)
end