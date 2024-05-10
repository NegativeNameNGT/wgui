---@class Geometry
-- `Geometry` is a static class that provides information about widgets positions and sizes.
Geometry = {}

-- Translates absolute coordinates into local coordinates.
---@param oWidget BaseWidget
---@param tAbsoluteCoordinate Vector2D
---@return Vector2D
function Geometry.AbsoluteToLocal(oWidget, tAbsoluteCoordinate)
    return oWidget:CallBlueprintEvent("AbsoluteToLocal", tAbsoluteCoordinate) ---@type Vector2D
end

-- Translates local coordinates into absolute coordinates
---@param oWidget BaseWidget
---@param tLocalCoordinate Vector2D
---@return Vector2D
function Geometry.LocalToAbsolute(oWidget, tLocalCoordinate)
    return oWidget:CallBlueprintEvent("LocalToAbsolute", tLocalCoordinate) ---@type Vector2D
end

-- Returns the local top/left of the geometry in local coordinates.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetLocalTopLeft(oWidget)
    return oWidget:CallBlueprintEvent("GetLocalTopLeft") ---@type Vector2D
end

-- Translates local coordinate of the geometry provided into local viewport coordinates.
---@param oWidget BaseWidget
---@param tLocalCoordinate Vector2D
---@return Vector2D @The pixel position
---@return Vector2D @The viewport position
function Geometry.LocalToViewport(oWidget, tLocalCoordinate)
    return oWidget:CallBlueprintEvent("LocalToViewport", tLocalCoordinate) ---@type Vector2D, Vector2D
end

-- Absolute coordinates could be either desktop or window space depending on what space the root of the widget hierarchy is in.
---@param oWidget BaseWidget
---@param tAbsoluteCoordinate Vector2D
---@return boolean
function Geometry.IsUnderLocation(oWidget, tAbsoluteCoordinate)
    return oWidget:CallBlueprintEvent("IsUnderLocation", tAbsoluteCoordinate) ---@type boolean
end

-- Translates a screen position in pixels into the local space of a widget with the given geometry. <br>
-- If IncludeWindowPosition is true, then this method will also remove the game window's position (useful when in windowed mode).
---@param oWidget BaseWidget
---@param tScreenPosition Vector2D
---@param bIncludeWindowPosition boolean
---@return Vector2D
function Geometry.ScreenToWidget(oWidget, tScreenPosition, bIncludeWindowPosition)
    return oWidget:CallBlueprintEvent("ScreenToLocal", tScreenPosition, bIncludeWindowPosition) ---@type Vector2D
end

-- Returns the size of the geometry in local space.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetLocalSize(oWidget)
    return oWidget:CallBlueprintEvent("GetLocalSize") ---@type Vector2D
end

-- Returns the size of the geometry in absolute space.
---@param oWidget BaseWidget
---@return Vector2D
function Geometry.GetAbsoluteSize(oWidget)
    return oWidget:CallBlueprintEvent("GetAbsoluteSize") ---@type Vector2D
end