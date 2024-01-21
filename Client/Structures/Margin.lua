---@class Margin
---@field public Left number
---@field public Top number
---@field public Right number
---@field public Bottom number

local MarginMT = {
    __tostring = function(self)
        return string.format("Margin(Left = %d, Top = %d, Right = %d, Bottom = %d)", self.Left, self.Top, self.Right, self.Bottom)
    end,

    __add = function(a, b)
        if type(b) == "number" then
            return Margin(a.Left + b, a.Top + b, a.Right + b, a.Bottom + b)
        end

        return Margin(a.Left + b.Left, a.Top + b.Top, a.Right + b.Right, a.Bottom + b.Bottom)
    end,

    __sub = function(a, b)
        if type(b) == "number" then
            return Margin(a.Left - b, a.Top - b, a.Right - b, a.Bottom - b)
        end

        return Margin(a.Left - b.Left, a.Top - b.Top, a.Right - b.Right, a.Bottom - b.Bottom)
    end,

    __mul = function(a, b)
        return Margin(a.Left * b, a.Top * b, a.Right * b, a.Bottom * b)
    end
}

---@param Left number | nil
---@param Top number | nil
---@param Right number | nil
---@param Bottom number | nil
---@return Margin
function Margin(Left, Top, Right, Bottom)
    -- If only Left is specified, then use it for all sides.
    if Left and not Top and not Right and not Bottom then
        Top, Right, Bottom = Left, Left, Left
    -- If Left and Top are specified, but Right and Bottom are not, use Left for Right and Top for Bottom.
    elseif Left and Top and not Right and not Bottom then
        Right, Bottom = Left, Top
    end

    local tMargin = {
        Left = Left or 0,
        Top = Top or 0,
        Right = Right or 0,
        Bottom = Bottom or 0
    }

    setmetatable(tMargin, MarginMT)

    return tMargin
end