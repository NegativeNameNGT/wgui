---@class ViewItem
---@overload fun(): ViewItem
---@field private __Data any
---@field private __Index integer
---@field public __ChildrenItems table<integer, ViewItem>
--- `ViewItem` is a class that represents an item in a view (ListView, TreeView).
ViewItem = {}
ViewItem.__index = ViewItem
setmetatable(ViewItem, {
    __call = function()
        local oNewInstance = {}
        setmetatable(oNewInstance, ViewItem)

        return oNewInstance
    end
})

-- Sets the data of the item.
---@param xData any
function ViewItem:SetData(xData)
    self.__Data = xData

    return self
end

-- Gets the data of the item.
---@return any
function ViewItem:GetData()
    return self.__Data
end

-- Stores the index of the item. This is used internally by the view.
---@param iIndex integer
function ViewItem:StoreIndex(iIndex)
    self.__Index = iIndex

    return self
end

-- Gets the index of the item.
---@return integer
function ViewItem:GetIndex()
    return self.__Index or -1
end