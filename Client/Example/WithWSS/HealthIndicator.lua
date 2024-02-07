---@class WSS_HealthIndicator : WSS_Indicator
WSS_HealthIndicator = WSS_Indicator.Inherit("WSS_HealthIndicator")

function WSS_HealthIndicator:Constructor()
    WSS_Indicator.Constructor(self)

    -- Creates an image to display the health icon
    WGUI.CreateWithTags(Image, "#HealthIcon", self)

    -- Creates a text block to display the health value
    WGUI.CreateWithTags(TextBlock, {"#HUDText", "#HealthText"}, self)
end