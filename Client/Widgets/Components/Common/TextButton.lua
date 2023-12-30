---@class TextButton : Button, TextBlock
TextButton = Button.Inherit("TextButton")

function TextButton:Constructor()
    Button.Constructor(self)

    self:SetValue("__Text", WGUI.Create(TextBlock, self))

    return self
end

function TextButton:index(sKey)
    -- Checks if the key is a property of the text widget.
    local xValue = rawget(TextBlock, sKey)
    if (type(xValue) == "function") then
        -- Returns a function that calls the text widget function.
        return function (self, ...)
            local oText = self:GetValue("__Text")
            return TextBlock[sKey](oText, ...)
        end
    end
end