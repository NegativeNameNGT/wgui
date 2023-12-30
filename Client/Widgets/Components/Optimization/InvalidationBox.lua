---@class InvalidationBox : PanelWidget
InvalidationBox = PanelWidget.Inherit("InvalidationBox", {
    -- The background blur can only have one child widget.
    ChildrenLimit = 1,
})

function InvalidationBox:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_InvalidationBox")

    return self
end

-- Sets whether or not the invalidation panel can cache the widget.
---@param bCanCache boolean
function InvalidationBox:SetCanCache(bCanCache)
    self:CallBlueprintEvent("SetCanCache", bCanCache)

    -- Stores the value
    self:SetValue("__CanCache", bCanCache)
end

-- Gets whether or not the invalidation panel can cache the widget.
---@return boolean
function InvalidationBox:GetCanCache()
    return self:GetValue("__CanCache", false)
end

