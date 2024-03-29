---@class Geometry
Geometry = {}

-- Translates absolute coordinates into local coordinates.
---@param oWidget BaseWidget
---@param tAbsoluteCoordinate Vector2D
---@return Vector2D
function Geometry.AbsoluteToLocal(oWidget, tAbsoluteCoordinate)
    return oWidget:CallBlueprintEvent("AbsoluteToLocal", tAbsoluteCoordinate)
end

-- Translates local coordinates into absolute coordinates
---@param oWidget BaseWidget
---@param tLocalCoordinate Vector2D
---@return Vector2D
function Geometry.LocalToAbsolute(oWidget, tLocalCoordinate)
    return oWidget:CallBlueprintEvent("LocalToAbsolute", tLocalCoordinate)
end

-- Returns the local top/left of the geometry in local coordinates.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetLocalTopLeft(oWidget)
    return oWidget:CallBlueprintEvent("GetLocalTopLeft")
end