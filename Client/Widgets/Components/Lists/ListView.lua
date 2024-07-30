-- A virtualized list that allows up to thousands of items to be displayed.
---@class ListView : BaseWidget
---@field private __ItemData table<integer, ViewItem>
ListView = BaseWidget.Inherit("ListView", {
    Icon = "package://wgui/Client/Textures/Icons/ListView.png",
    __ItemData = {}
})

function ListView:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_ListView")
end

local function ClearInternalWidgets(self)
    local tInternalWidgets = self:GetValue("__InternalWidgets", {})
    for _, oInternalWidget in ipairs(tInternalWidgets) do
        oInternalWidget:Destroy()
    end
    self:SetValue("__InternalWidgets", {})
end
ListView.Subscribe("Destroy", ClearInternalWidgets)

-- Assigns and Binds a Blueprint Event Dispatcher
---@param sEventName string
---@param fnCallback function
---@overload fun(self: BaseWidget, sEventName: "GenerateInternalWidget", fnCallback: fun(self: BaseWidget) : BaseWidget)
---@overload fun(self: BaseWidget, sEventName: "UpdateInternalWidget", fnCallback: fun(self: BaseWidget, Item: ViewItem, InternalWidget: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "ListViewScrolled", fnCallback: fun(self: BaseWidget, ItemOffset: number, DistanceRemaining: number))
---@overload fun(self: BaseWidget, sEventName: "EntrySelectionChanged", fnCallback: fun(self: BaseWidget, InternalWidget: BaseWidget, Item: ViewItem, bIsSelected: boolean))s
---@overload fun(self: BaseWidget, sEventName: "ItemSelectionChanged", fnCallback: fun(self: BaseWidget, Item: ViewItem, bIsSelected: boolean))
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
function ListView:BindDispatcher(sEventName, fnCallback)
    return self:BindBlueprintEventDispatcher(sEventName, function (...)
        if sEventName == "GenerateInternalWidget" then
            local oInternalWidget = fnCallback(...)
            self:SetBlueprintPropertyValue("CurrentInternalWidget", oInternalWidget)

            -- Stores the internal widget
            local tInternalWidgets = self:GetValue("__InternalWidgets", {})
            table.insert(tInternalWidgets, oInternalWidget)
            self:SetValue("__InternalWidgets", tInternalWidgets)
            return
        end

        if sEventName == "UpdateInternalWidget" then
            local _, iItemIndex, iInternalWidgetID = ...
            local oViewItem = self:GetItemAt(iItemIndex + 1)
            local oInternalWidget = WGUI.GetWidgetByID(iInternalWidgetID)

            fnCallback(self, oViewItem, oInternalWidget)
            return
        end

        if sEventName == "EntrySelectionChanged" then
            local _, iInternalWidgetID, iItemIndex, bIsSelected = ...
            fnCallback(self, WGUI.GetWidgetByID(iInternalWidgetID), self:GetItemAt(iItemIndex), bIsSelected)
            return
        end

        if sEventName == "ItemSelectionChanged" then
            local _, iItemIndex, bIsSelected = ...
            fnCallback(self, self:GetItemAt(iItemIndex), bIsSelected)
            return
        end

        -- [Only supported by TreeView]
        if sEventName == "ExpansionChanged" then
            local _, iItemIndex, iInternalWidgetID, bIsExpanded = ...
            fnCallback(self, self:GetItemAt(iItemIndex), WGUI.GetWidgetByID(iInternalWidgetID), bIsExpanded)
            return
        end

        fnCallback(...)
    end)
end

-- Adds an item to the list view.
---@param oViewItem ViewItem
function ListView:AddItem(oViewItem)
    local iItemIndex = self:CallBlueprintEvent("AddItem") + 1

    -- Stores the item
    table.insert(self.__ItemData, oViewItem)

    -- Updates the index of the item
    oViewItem:StoreIndex(iItemIndex)
end

-- Inserts the specified items at the specified index.
---@param Items ViewItem[]
---@param iIndex integer
---@param bIsAddedToRoot? boolean
function ListView:InsertItemsAt(Items, iIndex, bIsAddedToRoot)
    local bSuccess = self:CallBlueprintEvent("InsertItemsAt", iIndex - 1, #Items or 0, bIsAddedToRoot or false)

    if not bSuccess then
        return self
    end

    for _, oViewItem in ipairs(Items) do
        table.insert(self.__ItemData, iIndex + 1, oViewItem)
    end

    self:RefreshItemIndexes()
end

-- Removes an item from the list view.
---@param oViewItem ViewItem
function ListView:RemoveItem(oViewItem)
    -- Ensures the data is a valid view item
    if oViewItem == nil or getmetatable(oViewItem) ~= ViewItem then
        return self
    end

    -- Gets the index of the item
    local iItemIndex = oViewItem:GetIndex()

    self:CallBlueprintEvent("RemoveItem", iItemIndex)
    table.remove(self.__ItemData, iItemIndex)
    self:RefreshItemIndexes()
    return self
end

-- Refreshes the list view item indexes.
function ListView:RefreshItemIndexes()
    for i, oViewItem in ipairs(self.__ItemData) do
        oViewItem:StoreIndex(i)
    end

    return self
end

-- Gets the item at the given index.
---@param iItemIndex integer
---@return ViewItem
function ListView:GetItemAt(iItemIndex)
    return self.__ItemData[iItemIndex]
end

-- Removes all items from the list view.
function ListView:ClearListItems()
    self:CallBlueprintEvent("ClearListItems")

    -- Clears the current list view data
    ClearInternalWidgets(self)
    self:SetValue("__ItemData", {})

    return self
end

-- Clears the selection in the list view.
function ListView:ClearSelection()
    self:CallBlueprintEvent("ListView_Selection_ClearAndUpdate")

    return self
end

-- Sets the selection mode of the list view.
---@param iSelectionMode ListViewSelectionMode
function ListView:SetSelectionMode(iSelectionMode)
    self:CallBlueprintEvent("ListView_SetSelectionMode", iSelectionMode)

    self:SetValue("SelectionMode", iSelectionMode)
    return self
end

-- Gets the selection mode of the list view.
---@return ListViewSelectionMode
function ListView:GetSelectionMode()
    return self:GetValue("SelectionMode", ListViewSelectionMode.Single)
end

-- Scrolls the entire list up to the first item.
function ListView:ScrollToTop()
    self:CallBlueprintEvent("ListView_ScrollToTop")

    return self
end

-- Scrolls the entire list down to the last item.
function ListView:ScrollToBottom()
    self:CallBlueprintEvent("ListView_ScrollToBottom")

    return self
end

-- Requests that the item at the given index be scrolled into view.
---@param iItemIndex integer
function ListView:ScrollIndexIntoView(iItemIndex)
    self:CallBlueprintEvent("ListView_ScrollIndexIntoView", iItemIndex)

    return self
end

-- Selects all items in the list view.
function ListView:SelectAll()
    self:CallBlueprintEvent("ListView_Selection_SelectAll")

    return self
end