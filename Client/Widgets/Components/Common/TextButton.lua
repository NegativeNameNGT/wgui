---@class TextButton : Button, TextBlock
TextButton = Button.Inherit("TextButton")

function TextButton:Constructor()
    Button.Constructor(self)

    self:SetValue("__Text", WGUI.Create(TextBlock, self))

    return self
end

-- Copy the TextBlock functions to the TextButton.
function TextButton:index(sKey)
    -- Checks if the key is a property of the text widget.
    local xValue = rawget(TextBlock, sKey)
    if not xValue or type(xValue) ~= "function" then
        return rawget(self, sKey)
    end

    -- Returns a function that calls the text widget function.
    return function (self, ...)
        local oText = self:GetValue("__Text")

        local xReturnValue = TextBlock[sKey](oText, ...)
        if (xReturnValue == oText) then
            return self
        end
        return xReturnValue
    end
end

function TextButton:test()
    
end