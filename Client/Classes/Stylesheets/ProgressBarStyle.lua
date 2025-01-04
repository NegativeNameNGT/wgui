-- Creates a new progress bar style table.
---@param tBackground Brush | nil
---@param tFill Brush | nil
---@param tMarquee Brush | nil
---@param bEnableFillAnimation boolean | nil
function ProgressBarStyle(tBackground, tFill, tMarquee, bEnableFillAnimation)
    ---@class ProgressBarStyle
    local oProgressBarStyle = {}
    oProgressBarStyle.Background = tBackground
    oProgressBarStyle.Fill = tFill
    oProgressBarStyle.Marquee = tMarquee
    oProgressBarStyle.EnableFillAnimation = bEnableFillAnimation

    return oProgressBarStyle
end