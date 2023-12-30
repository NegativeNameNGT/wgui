---@class CircularThrobber : BaseWidget
CircularThrobber = BaseWidget.Inherit("CircularThrobber")

function CircularThrobber:Constructor()
    self.Super:Constructor("wgui-assets::WBP_WGUI_CircularThrobber")
    return self
end

-- Sets the number of pieces in the throbber.
---@param iNumberOfPieces integer
function CircularThrobber:SetNumberOfPieces(iNumberOfPieces)
    self:CallBlueprintEvent("SetNumberOfPieces", iNumberOfPieces)
end

-- Sets the period of the throbber.
---@param fPeriod number
function CircularThrobber:SetPeriod(fPeriod)
    self:CallBlueprintEvent("SetPeriod", fPeriod)
end

-- Sets the radius of the circle.
---@param fRadius number
function CircularThrobber:SetRadius(fRadius)
    self:CallBlueprintEvent("SetRadius", fRadius)
end

-- Sets the brush of the throbber.
---@param oBrush Brush
function CircularThrobber:SetBrush(oBrush)
    self:CallBlueprintEvent("SetBrush", oBrush)

    -- Stores the brush.
    self.__Brush = oBrush
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