-- Stores the widget's slot value to be set when the widget is added to a panel.
---@param oWidget BaseWidget
---@param sSlotFunction string
---@param xValue any
function _WSS.StoreSlotValue(oWidget, sSlotFunction, xValue)
    local SlotData = oWidget:GetValue("__SlotFields", {})

    SlotData[sSlotFunction] = xValue

    oWidget:SetValue("__SlotFields", SlotData)

    if oWidget[sSlotFunction] then
        oWidget[sSlotFunction](oWidget, xValue)
    end
end

-- Applies the stored slot values to the widget.
---@param oContent BaseWidget
function _WSS.ApplySlotFields(oContent)
    local tOverriders = {
        SizeToContent = function(bPropertyValue) if bPropertyValue == true then oContent:SizeToContent() else oContent:SizeWithinBounds() end end,
    }

    local tSlotFields = oContent:GetValue("__SlotFields", {})
    if not tSlotFields then
        return
    end

    for sSlotFunction, xPropertyValue in pairs(tSlotFields) do
        if tOverriders[sSlotFunction] then
            tOverriders[sSlotFunction](xPropertyValue)
            goto continue
        end
        oContent[sSlotFunction](oContent, xPropertyValue)

        ::continue::
    end
end