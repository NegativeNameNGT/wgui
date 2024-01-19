---@class Margin
---@field public Left number
---@field public Top number
---@field public Right number
---@field public Bottom number

---@param Left number | nil
---@param Top number | nil
---@param Right number | nil
---@param Bottom number | nil
---@return Margin
function Margin(Left, Top, Right, Bottom)
    return {
        Left = Left or 0,
        Top = Top or 0,
        Right = Right or 0,
        Bottom = Bottom or 0
    }
end