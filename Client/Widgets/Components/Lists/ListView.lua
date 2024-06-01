-- A virtualized list that allows up to thousands of items to be displayed.
---@class ListView : BaseWidget
ListView = BaseWidget.Inherit("ListView", {
    Icon = "package://wgui/Client/Textures/Icons/ListView.png"
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
---@overload fun(self: BaseWidget, sEventName: "UpdateInternalWidget", fnCallback: fun(self: BaseWidget, ItemIndex: integer, EntryWidget: BaseWidget))
---@overload fun(self: BaseWidget, sEventName: "ListViewScrolled", fnCallback: fun(self: BaseWidget, ItemOffset: number, DistanceRemaining: number))
---@overload fun(self: BaseWidget, sEventName: "EntrySelectionChanged", fnCallback: fun(self: BaseWidget, EntryWidget: BaseWidget, bIsSelected: boolean))
---@overload fun(self: BaseWidget, sEventName: "ItemSelectionChanged", fnCallback: fun(self: BaseWidget, ItemIndex: integer, bIsSelected: boolean))
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

        if sEventName == "EntrySelectionChanged" then
            local _, iInternalWidgetID, bIsSelected = ...
            local oInternalWidget = WGUI.GetWidgetByID(iInternalWidgetID)
            if not oInternalWidget then
                return
            end

            fnCallback(self, oInternalWidget, bIsSelected)
            return
        end

        -- [Only supported by TreeView]
        if self:IsA(TreeView) and sEventName == "ItemExpansionChanged" and self["OnGetItemChildren"] then
            local _, iItemIndex, bIsExpanded = ...

            if bIsExpanded then
                -- Case: Item should be expanded

                local tChildren = self:OnGetItemChildren(self:GetItemData(iItemIndex)) or {}
                if not tChildren then
                    return
                end

                if type(tChildren) ~= "table" then
                    tChildren = {tChildren}
                end

                if #tChildren ~= 0 then
                    self:CallBlueprintEvent("TreeView_Expand", iItemIndex - 1, #tChildren or 0) -- First parameter is the item index, second is the number of items to generate.

                    -- Update the lua data
                    local tItemData = self:GetValue("__ItemData", {})
                    for _, xData in ipairs(tChildren) do
                        table.insert(tItemData, iItemIndex + 1, xData)
                    end
                    self:SetValue("__ItemData", tItemData)
                end
            else
                -- Case: Item should be collapsed

                self:CallBlueprintEvent("TreeView_Collapse", iItemIndex - 1)

                -- Update the lua data
                local tItemData = self:GetValue("__ItemData", {})
                for i = #tItemData, 1, -1 do
                    if i > iItemIndex and i <= iItemIndex + 1 then
                        table.remove(tItemData, i)
                    end
                end
                self:SetValue("__ItemData", tItemData)
            end
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
    self:CallBlueprintEvent("RemoveItem", iItemIndex)

    -- Removes the item data
    local tItemData = self:GetValue("__ItemData", {})
    table.remove(tItemData, iItemIndex)
    self:SetValue("__ItemData", tItemData)

    return self
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