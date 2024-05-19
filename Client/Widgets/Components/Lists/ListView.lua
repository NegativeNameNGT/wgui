-- A virtualized list that allows up to thousands of items to be displayed.
---@class ListView : BaseWidget
ListView = BaseWidget.Inherit("ListView")

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
---@overload fun(self: BaseWidget, sEventName: "UpdateInternalWidget", fnCallback: fun(self: BaseWidget, ItemIndex: integer, EntryWidget: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "ListViewScrolled", fnCallback: fun(self: BaseWidget, ItemOffset: number, DistanceRemaining: number))
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
            local oInternalWidget = WGUI.GetWidgetByID(iInternalWidgetID)
            if not oInternalWidget then
                return
            end

            fnCallback(self, iItemIndex + 1, oInternalWidget)
            return
        end

        fnCallback(...)
    end)
end

-- Adds an item to the list view.
---@param xItemData any
---@return integer
function ListView:AddItem(xItemData)
    local iItemIndex = self:CallBlueprintEvent("AddItem")

    -- Stores the item data
    local tItemData = self:GetValue("__ItemData", {})
    table.insert(tItemData, xItemData)
    self:SetValue("__ItemData", tItemData)

    return iItemIndex ---@type integer
end

-- Removes an item from the list view.
---@param iItemIndex integer
function ListView:RemoveItem(iItemIndex)
    print(iItemIndex)
    self:CallBlueprintEvent("RemoveItem", iItemIndex)

    -- Removes the item data
    local tItemData = self:GetValue("__ItemData", {})
    table.remove(tItemData, iItemIndex)
    self:SetValue("__ItemData", tItemData)
end

-- Sets the data of an item in the list view.
---@param iItemIndex integer
---@param xItemData any
function ListView:SetItemData(iItemIndex, xItemData)
    if xItemData == nil then
        return self
    end

    local tItemData = self:GetValue("__ItemData", {})
    tItemData[iItemIndex] = xItemData
    self:SetValue("__ItemData", tItemData)

    return self
end

-- Gets the data of an item in the list view.
---@param iItemIndex integer
---@return any
function ListView:GetItemData(iItemIndex)
    local tItemData = self:GetValue("__ItemData", {})
    return tItemData[iItemIndex]
end

-- Removes all items from the list view.
function ListView:ClearListItems()
    self:CallBlueprintEvent("ClearListItems")

    -- Clears the current list view data
    ClearInternalWidgets(self)
    self:SetValue("__ItemData", {})
end