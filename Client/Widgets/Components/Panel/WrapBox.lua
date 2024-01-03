-- Arranges widgets left-to-right or top-to-bottom dependently of the orientation.
---@class WrapBox : PanelWidget
WrapBox = PanelWidget.Inherit("WrapBox")

function WrapBox:Constructor(iOrientation)
    self.Super:Constructor("wgui-assets::WBP_WGUI_WrapBox")

    if iOrientation then
        self:SetOrientation(iOrientation)
    end
    return self
end

-- Determines if the Wrap Box should arranges children horizontally or vertically.
---@param iOrientation Orientation
function WrapBox:SetOrientation(iOrientation)
    self:CallBlueprintEvent("SetOrientation", iOrientation)
end

-- Sets the inner slot padding goes between slots sharing borders.
---@param tPadding Vector2D
function WrapBox:SetInnerSlotPadding(tPadding)
    self:CallBlueprintEvent("SetInnerSlotPadding", tPadding)
end

-- Sets the wrap size. When this size is exceeded, the panel will wrap to the next line.
---@param fWrapSize number
function WrapBox:SetWrapSize(fWrapSize)
    self:CallBlueprintEvent("SetWrapSize", fWrapSize)
end

-- Use explicit wrap size whenever possible. It greatly simplifies layout calculations and reduces likelihood of "wiggling UI".
---@param bExplicitWrapSize boolean
function WrapBox:SetExplicitWrapSize(bExplicitWrapSize)
    self:CallBlueprintEvent("SetExplicitWrapSize", bExplicitWrapSize)
end