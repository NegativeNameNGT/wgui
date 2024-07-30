---@class ExpandableArea : BaseWidget
-- A area that can be expanded or collapsed.
ExpandableArea = BaseWidget.Inherit("ExpandableArea")

---@param bShowCaret boolean
function ExpandableArea:Constructor(bShowCaret)
    self.Super:Constructor("wgui-assets::WBP_WGUI_ExpandableArea")

    local oNativeExpandableArea = Widget("wgui-assets::NW_WGUI_ExpandableArea")

    if type(bShowCaret) == "boolean" and not bShowCaret then
        oNativeExpandableArea:SetBlueprintPropertyValue("Style", {
            CollapsedImage = {
               DrawAs = 0,
               ImageSize = Vector2D(16)
            },

            ExpandedImage = {
                DrawAs = 0,
                ImageSize = Vector2D(16)
            },

            RolloutAnimationSeconds = 0.001
        })
    end

    -- Display the native expandable area.
    self:CallBlueprintEvent("SetNativeWidget", oNativeExpandableArea)

    -- Store the native expandable area.
    self:SetValue("__NativeExpandableArea", oNativeExpandableArea)
end

-- Sets the header content of the expandable area.
---@param oHeaderContent BaseWidget
function ExpandableArea:SetHeaderContent(oHeaderContent)
    local oNativeExpandableArea = self:GetValue("__NativeExpandableArea") ---@type Widget
    oNativeExpandableArea:SetBlueprintPropertyValue("HeaderContent", oHeaderContent)

    -- Store the header content.
    self:SetValue("__HeaderContent", oHeaderContent)
end

-- Sets the body content of the expandable area.
---@param oBodyContent BaseWidget
function ExpandableArea:SetBodyContent(oBodyContent)
    if not oBodyContent or not getmetatable(oBodyContent) == BaseWidget then
        InternalLib.ExpectType("SetBodyContent", 1, oBodyContent, "BaseWidget")
    end

    local oNativeExpandableArea = self:GetValue("__NativeExpandableArea") ---@type Widget
    oNativeExpandableArea:SetBlueprintPropertyValue("BodyContent", oBodyContent)

    -- Store the body content.
    self:SetValue("__BodyContent", oBodyContent)
end

-- Gets the header content of the expandable area.
---@return BaseWidget
function ExpandableArea:GetHeaderContent()
    return self:GetValue("__HeaderContent")
end

-- Gets the body content of the expandable area.
---@return BaseWidget
function ExpandableArea:GetBodyContent()
    return self:GetValue("__BodyContent")
end

-- Sets the border color of the expandable area.
---@param oBorderColor Color
function ExpandableArea:SetBorderColor(oBorderColor)
    if not oBorderColor or not getmetatable(oBorderColor) == Color then
        InternalLib.ExpectType("SetBorderColor", 1, oBorderColor, "Color")
    end

    local oNativeExpandableArea = self:GetValue("__NativeExpandableArea") ---@type Widget
    oNativeExpandableArea:SetBlueprintPropertyValue("BorderColor", {
        SpecifiedColor = oBorderColor
    })

    -- Store the border color.
    self:SetValue("__BorderColor", oBorderColor)
end

-- Gets the border color of the expandable area.
---@return Color
function ExpandableArea:GetBorderColor()
    return self:GetValue("__BorderColor", Color(0.017642, 0.017642, 0.017642, 1))
end

-- Sets if the expandable area is expanded.
---@param bExpanded boolean
function ExpandableArea:SetIsExpanded(bIsExpanded)
    if type(bIsExpanded) ~= "boolean" then
        InternalLib.ExpectType("SetIsExpanded", 1, bIsExpanded, "boolean")
    end

    local oNativeExpandableArea = self:GetValue("__NativeExpandableArea") ---@type Widget
    oNativeExpandableArea:CallBlueprintEvent("SetIsExpanded", bIsExpanded)

    -- Store the expanded state.
    self:SetValue("__IsExpanded", bIsExpanded)
end

-- Gets if the expandable area is expanded.
---@return boolean
function ExpandableArea:GetIsExpanded()
    return self:GetValue("__IsExpanded", false)
end

-- Destroys the body content of the expandable area.
function ExpandableArea:DestroyBodyContent()
    local oBodyContent = self:GetBodyContent()
    if oBodyContent then
        oBodyContent:Destroy()
        self:SetValue("__BodyContent", nil)
    end
end