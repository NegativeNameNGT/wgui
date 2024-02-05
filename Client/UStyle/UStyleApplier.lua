local function FindFallbackFieldValue(oWidget, sField, bIsClassStyle)
    -- If true, try to find the fallback value from the widget tag
    -- If false, try to find the fallback value from the widget class
    if bIsClassStyle then
        local sTag = oWidget:GetValue("__StyleTag")
        if not sTag then
            return false
        end

        local tTagFields = UStyle.GetTagStyleSheet(sTag)
        if not tTagFields then
            return false
        end

        UStyle.ApplyWidgetStyleField(oWidget, sField, tTagFields[sField], false)
    else
        local cClass = oWidget:GetClass()
        local tClassFields = UStyle.GetWidgetStyleSheet(cClass)

        if not tClassFields then
            return false
        end

        UStyle.ApplyWidgetStyleField(oWidget, sField, tClassFields[sField], true)
    end

    return true
end

-- Applies a style sheet to a widget.
---@param oWidget BaseWidget
---@param tStyleSheet table
---@param bIsClassStyle boolean
function UStyle.ApplyWidgetStyle(oWidget, tStyleSheet, bIsClassStyle)
    for sKey, xValue in pairs(tStyleSheet) do
        UStyle.ApplyWidgetStyleField(oWidget, sKey, xValue, bIsClassStyle)
    end
end

-- Applies a style sheet field to a widget.
---@param oWidget BaseWidget
---@param sField string
---@param xValue any
---@param bIsClassStyle boolean
function UStyle.ApplyWidgetStyleField(oWidget, sField, xValue, bIsClassStyle)
    local tFields = UStyle.GetWidgetFields(oWidget)
    if not tFields[sField] then
        Console.Error("[WGUI, UStyle] Invalid style field '" .. sField .. "' for '" .. tostring(oWidget:GetClass()) .. "'")
        goto continue
    end

    local fnField = tFields[sField][1]
    local iParameterType = tFields[sField][2]

    -- Restores the default value
    local xParsedValue = nil
    if xValue == "_DELETED_" then
        if (FindFallbackFieldValue(oWidget, sField, bIsClassStyle)) then
            return
        end
    else
        xParsedValue = UStyle.GetParser(iParameterType)(xValue)
    end

    if type(fnField) == "string" then
        StoreSlotValue(oWidget, fnField, xParsedValue)
        goto continue
    end

    fnField(oWidget, xParsedValue)

    ::continue::
end