---@class HealthIndicator : Indicator
HealthIndicator = Indicator.Inherit("HealthIndicator")

function HealthIndicator:Constructor()
    Indicator.Constructor(self)

    -- Creates an image to display the health icon
    local HealthIcon = WGUI.Create(Image, self)
    HealthIcon:SetBrushFromSrc("package://wgui/Client/Example/health-icon.png")
    HealthIcon:SetHAlign(HAlign.Center)
    HealthIcon:SetVAlign(VAlign.Center)

    -- Creates a text block to display the health value
    local HealthText = WGUI.Create(TextBlock, self, "100")
    HealthText:SetFont("Oswald", "Bold", 26)
    HealthText:SetPadding(Margin(10, 0, 0, 0))
    HealthText:SetHAlign(HAlign.Center)
    HealthText:SetVAlign(VAlign.Top)

    -- Stores the HealthText to be used later
    self:SetValue("Text", HealthText)

    return self
end

function HealthIndicator:SetHealth(Health)
    local HealthText = self:GetValue("Text")
    HealthText:SetText(tostring(Health))
end