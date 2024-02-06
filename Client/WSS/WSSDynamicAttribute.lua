_WSS.DynamicAttributes = {}

-- Sets the value of a dynamic attribute.
---@param sAttribute string
---@param xValue any
---@return nil
function WSS.SetDynamicAttributeValue(sAttribute, xValue)
    if not _WSS.DynamicAttributes[sAttribute] then
        _WSS.DynamicAttributes[sAttribute] = {
            Value = xValue,
            Widgets = {}
        }
    end
    _WSS.DynamicAttributes[sAttribute].Value = xValue

    -- Applies the dynamic attribute to concerned widgets
    for iWidgetID, tFields in pairs(_WSS.DynamicAttributes[sAttribute].Widgets) do
        local oWidget = WGUI.GetWidgetByID(iWidgetID)
        if not oWidget:IsValid() then
            goto continue
        end

        for _, sField in ipairs(tFields) do
            WSS.ApplyStyleSheet(oWidget, {
                [sField] = xValue
            })
        end
        ::continue::
    end
end

-- Add a widget to a dynamic attribute.
---@param sAttribute string
---@param sField string
---@param oWidget BaseWidget
---@return nil
function _WSS.AddWidgetToDynamicAttribute(sAttribute, sField, oWidget)
    if not _WSS.DynamicAttributes[sAttribute] then
        _WSS.DynamicAttributes[sAttribute] = {
            Value = nil,
            Widgets = {}
        }
    end

    local iWidgetID = oWidget:GetValue("__ID")

    local tFields = _WSS.DynamicAttributes[sAttribute].Widgets[iWidgetID]
    if not tFields then
        tFields = {}
        _WSS.DynamicAttributes[sAttribute].Widgets[iWidgetID] = tFields

        oWidget:Subscribe("Destroy", function()
            _WSS.DynamicAttributes[sAttribute].Widgets[iWidgetID] = nil
        end)
    end

    table.insert(tFields, sField)
end

-- Gets the value of a dynamic attribute.
---@param sAttribute string
---@return any
function WSS.GetDynamicAttributeValue(sAttribute)
    return _WSS.DynamicAttributes[sAttribute] and _WSS.DynamicAttributes[sAttribute].Value
end