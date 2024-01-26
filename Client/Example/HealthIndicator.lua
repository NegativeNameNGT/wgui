---@class HealthIndicator : Indicator
HealthIndicator = Indicator.Inherit("HealthIndicator")

function HealthIndicator:Constructor()
    Indicator.Constructor(self)

    local HealthIcon = WGUI.Create(Image, self)
    HealthIcon:SetBrushFromSrc("package://wgui/Client/Example/health-icon.png")
    HealthIcon:SetHAlign(HAlign.Center)
    HealthIcon:SetVAlign(VAlign.Center)

    local HealthText = WGUI.Create(TextBlock, self, "100")
    HealthText:SetFont("Oswald", "Bold", 26)
    HealthText:SetColor(Color.FromHSV(0, 0, 0.583))
    HealthText:SetPadding(Margin(10, 0, 0, 0))
    HealthText:SetHAlign(HAlign.Center)
    HealthText:SetVAlign(VAlign.Top)

    self:SetValue("Text", HealthText)

    return self
end

function HealthIndicator:SetHealth(Health)
    local HealthText = self:GetValue("Text")
    HealthText:SetText(tostring(Health))
end