---@class CircularThrobber : BaseWidget
CircularThrobber = BaseWidget.Inherit("CircularThrobber")

function CircularThrobber:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_CircularThrobber")
    return self
end

-- Sets the number of pieces in the throbber.
---@generic T
---@param self T
---@param iNumberOfPieces integer
---@return T
function CircularThrobber:SetNumberOfPieces(iNumberOfPieces)
    self:CallBlueprintEvent("SetNumberOfPieces", iNumberOfPieces)

    return self
end

-- Sets the period of the throbber.
---@generic T
---@param self T
---@param fPeriod number
---@return T
function CircularThrobber:SetPeriod(fPeriod)
    self:CallBlueprintEvent("SetPeriod", fPeriod)

    return self
end

-- Sets the radius of the circle.
---@generic T
---@param self T
---@param fRadius number
---@return T
function CircularThrobber:SetRadius(fRadius)
    self:CallBlueprintEvent("SetRadius", fRadius)

    return self
end

-- Sets the brush of the throbber.
---@generic T
---@param self T
---@param oBrush Brush
---@return T
function CircularThrobber:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush)

    -- Stores the brush.
    ---@private
    self.__Brush = oBrush

    return self
end

-- Gets the brush of the throbber.
---@return Brush
function CircularThrobber:GetBrush()
    if not self.__Brush then
        self.__Brush = Brush(DrawMode.RoundedBox, nil, "/WGui/Textures/Throbber/Throbber_Piece", Vector2D(16), OutlineSettings(
            Quat(4), nil, 0
        ))
    end
    return self.__Brush
end