-- A Throbber widget that shows several zooming circles in a row.
---@class Throbber : BaseWidget
Throbber = BaseWidget.Inherit("Throbber")

function Throbber:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Throbber")
    return self
end

-- Sets the number of pieces in the throbber.
---@param iNumberOfPieces integer
function Throbber:SetNumberOfPieces(iNumberOfPieces)
    self:CallBlueprintEvent("SetNumberOfPieces", iNumberOfPieces)
end

-- Sets whether the pieces animate horizontally.
---@param bAnimateHorizontally boolean
function Throbber:SetAnimateHorizontally(bAnimateHorizontally)
    self:CallBlueprintEvent("SetAnimateHorizontally", bAnimateHorizontally)
end

-- Sets whether the pieces animate vertically.
---@param bAnimateVertically boolean
function Throbber:SetAnimateVertically(bAnimateVertically)
    self:CallBlueprintEvent("SetAnimateVertically", bAnimateVertically)
end

-- Sets whether the pieces animate the opacity.
---@param bAnimateOpacity boolean
function Throbber:SetAnimateOpacity(bAnimateOpacity)
    self:CallBlueprintEvent("SetAnimateOpacity", bAnimateOpacity)
end

-- Sets the brush of the throbber.
---@param oBrush Brush
function Throbber:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush or {})

    -- Stores the brush.
    self.__Brush = oBrush
end

-- Gets the brush of the throbber.
---@return Brush
function Throbber:GetBrush()
    if not self.__Brush then
        self.__Brush = Brush(DrawMode.RoundedBox, nil, "/WGui/Textures/Throbber/Throbber_Piece", Vector2D(16), OutlineSettings(
            Quat(4), nil, 0
        ))
    end
    return self.__Brush
end