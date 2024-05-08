---@class Geometry
-- `Geometries` are paired with widgets to provide information about the widget's position and size.
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

-- Translates local coordinate of the geometry provided into local viewport coordinates.
---@param oWidget BaseWidget
---@param tLocalCoordinate Vector2D
---@return Vector2D
function Geometry.LocalToViewport(oWidget, tLocalCoordinate)
    return oWidget:CallBlueprintEvent("LocalToViewport", tLocalCoordinate)
end

-- Absolute coordinates could be either desktop or window space depending on what space the root of the widget hierarchy is in.
---@param oWidget BaseWidget
---@param tAbsoluteCoordinate Vector2D
---@return boolean
function Geometry.IsUnderLocation(oWidget, tAbsoluteCoordinate)
    return oWidget:CallBlueprintEvent("IsUnderLocation", tAbsoluteCoordinate)
end

-- Returns the size of the geometry in local space.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetLocalSize(oWidget)
    return oWidget:CallBlueprintEvent("GetLocalSize")
end

-- Returns the size of the geometry in absolute space.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetAbsoluteSize(oWidget)
    return oWidget:CallBlueprintEvent("GetAbsoluteSize")
end