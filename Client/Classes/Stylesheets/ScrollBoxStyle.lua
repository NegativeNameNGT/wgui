-- Creates a new scroll box style table.
---@param fBarThickness number | nil
---@param tTopShadow Brush | nil
---@param tBottomShadow Brush | nil
---@param tLeftShadow Brush | nil
---@param tRightShadow Brush | nil
---@param tHorizontalScrolledContentPadding Margin | nil
---@param tVerticalScrolledContentPadding Margin | nil
function ScrollBoxStyle(fBarThickness, tTopShadow, tBottomShadow, tLeftShadow, tRightShadow, tHorizontalScrolledContentPadding, tVerticalScrolledContentPadding)
    ---@class ScrollBoxStyle
    local ScrollBoxStyle = {}
    ScrollBoxStyle.BarThickness = fBarThickness or 9
    ScrollBoxStyle.TopShadow = tTopShadow or nil
    ScrollBoxStyle.BottomShadow = tBottomShadow or nil
    ScrollBoxStyle.LeftShadow = tLeftShadow or nil
    ScrollBoxStyle.RightShadow = tRightShadow or nil
    ScrollBoxStyle.HorizontalScrolledContentPadding = tHorizontalScrolledContentPadding or Margin(0, 0, 1, 0)
    ScrollBoxStyle.VerticalScrolledContentPadding = tVerticalScrolledContentPadding or Margin(0, 0, 0, 1)

    return ScrollBoxStyle
end