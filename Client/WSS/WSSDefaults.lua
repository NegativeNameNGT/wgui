---@class WSSAttr
---@field public Color? Color

WSS.Extend({
    Color = {BaseWidget.SetColor, WSSParserType.Color},
    Text = {TextBlock.SetText, WSSParserType.String}
})