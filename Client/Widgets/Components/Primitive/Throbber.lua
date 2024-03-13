-- A Throbber widget that shows several zooming circles in a row.
---@class Throbber : BaseWidget
Throbber = BaseWidget.Inherit("Throbber")

function Throbber:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_Throbber")
    return self
end

-- Sets the number of pieces in the throbber.
---@generic T
---@param self T
---@param iNumberOfPieces integer
---@return T
function Throbber:SetNumberOfPieces(iNumberOfPieces)
    self:CallBlueprintEvent("SetNumberOfPieces", iNumberOfPieces)

    return self
end

-- Sets whether the pieces animate horizontally.
---@generic T
---@param self T
---@param bAnimateHorizontally boolean
---@return T
function Throbber:SetAnimateHorizontally(bAnimateHorizontally)
    self:CallBlueprintEvent("SetAnimateHorizontally", bAnimateHorizontally)

    return self
end

-- Sets whether the pieces animate vertically.
---@generic T
---@param self T
---@param bAnimateVertically boolean
---@return T
function Throbber:SetAnimateVertically(bAnimateVertically)
    self:CallBlueprintEvent("SetAnimateVertically", bAnimateVertically)

    return self
end

-- Sets whether the pieces animate the opacity.
---@generic T
---@param self T
---@param bAnimateOpacity boolean
---@return T
function Throbber:SetAnimateOpacity(bAnimateOpacity)
    self:CallBlueprintEvent("SetAnimateOpacity", bAnimateOpacity)

    return self
end

-- Sets the brush of the throbber.
---@generic T
---@param self T
---@param oBrush Brush
---@return T
function Throbber:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush or {})

    -- Stores the brush.
    self.__Brush = oBrush

    return self
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