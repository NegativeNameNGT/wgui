---@class PropertyEditor : ScrollBox
-- 'PropertyEditor' is a class that allows to inspect the properties of widgets in runtime.
PropertyEditor = ScrollBox.Inherit("PropertyEditor")

---@return FlexBox
local function GetEntryPanel(self)
    return self:GetValue("_PropertyEntryPanel")
end

-- Handles the category of the property.
---@param self PropertyEditor
---@param sCategory string
---@return PropertyEditorCategory
local function HandleCategory(self, sCategory)
    local tExistingCategories = self:GetValue("__Categories", {})

    if tExistingCategories[sCategory] then
        return tExistingCategories[sCategory]
    end

    local tCategories = {}
    for sCategoryName in string.gmatch(sCategory, "[^|]+") do
        table.insert(tCategories, sCategoryName)
    end

    local oLastCategory = nil
    for k,v in ipairs(tCategories) do
        oLastCategory = WGUI.Create(PropertyEditorCategory, GetEntryPanel(self))
    end
    
    tExistingCategories[sCategory] = oLastCategory
    
    self:SetValue("__Categories", tExistingCategories)

    return oLastCategory
end

-- Constructor
function PropertyEditor:Constructor()
    ScrollBox.Constructor(self)

    local oOverlay = WGUI.Create(Overlay, self)
    oOverlay:SetVAlign(VAlign.Fill)

    -- Property entry panel
    local oPropertyEntryPanel = WGUI.Create(FlexBox, oOverlay, Orientation.Vertical)
    oPropertyEntryPanel:SetHAlign(HAlign.Fill)
    oPropertyEntryPanel:SetVAlign(VAlign.Fill)

    self:SetValue("_PropertyEntryPanel", oPropertyEntryPanel)

    -- Draggable line container
    local oDraggableLineContainer = WGUI.Create(Border, oOverlay)
    oDraggableLineContainer:SetVisibility(WGUIVisibility.Collapsed)
    oDraggableLineContainer:SetCursor(CursorType.ResizeLeftRight)
    oDraggableLineContainer:SetBrush(Brush(DrawMode.None))
    oDraggableLineContainer:SetVAlign(VAlign.Fill)

    -- Draggable line
    local oDraggableLine = WGUI.Create(Image, oDraggableLineContainer)
    oDraggableLine:SetHAlign(HAlign.Center)
    oDraggableLine:SetPadding(Margin(5, 0, 5, 0))
    oDraggableLine:SetBrush(Brush(DrawMode.Image, Color(0.01, 0.01, 0.01, 1), nil, Vector2D(2, 32)))

    -- Draggable line drag event
    oDraggableLine:SetDragKey("Left Mouse Button")
    oDraggableLine:BindDispatcher("DragDetected", function ()
        oDraggableLine:CreateDragDropOperation()
    end)

    self:BindDispatcher("DragOver", function (_, tPointerEvent)
        local tLastScreenPos = Geometry.AbsoluteToLocal(WGUI.GetLayout(), tPointerEvent.LastScreenPosition)
        local tCurScreenPos = Geometry.AbsoluteToLocal(WGUI.GetLayout(), tPointerEvent.ScreenPosition)

        local tTranslation = oDraggableLineContainer:GetTranslation()
        self:SetDraggableLineWidth(tTranslation.X + (tCurScreenPos.X - tLastScreenPos.X))
    end)

    -- Store the draggable line and set the initial width
    self:SetValue("_DraggableLine", oDraggableLineContainer)

    self:ForceLayoutPrepass()
    self:SetDraggableLineWidth(100)
end

-- Sets the width of the draggable line.
---@param iWidth number
function PropertyEditor:SetDraggableLineWidth(iWidth)
    local oDraggableLine = self:GetValue("_DraggableLine")
    oDraggableLine:SetTranslation(Vector2D(iWidth, 0))

    -- Store the width
    self:SetValue("__DraggableLineWidth", iWidth)

    self:ForceUpdateEntries()
end

-- Returns the width of the draggable line.
---@return number
function PropertyEditor:GetDraggableLineWidth()
    return self:GetValue("__DraggableLineWidth")
end

-- Sets the widget object to inspect its properties.
---@param oWidgetObject BaseWidget
function PropertyEditor:SetWidget(oWidgetObject)
    -- Clear the entry panel childrens.
    GetEntryPanel(self):DestroyAllChildren()

    -- Clear the property entries.
    self:SetValue("__PropertyEntries", {})

    -- Display the draggable line
    self:GetValue("_DraggableLine"):SetVisibility(WGUIVisibility.Visible)

    -- Store the active widget object
    self:SetValue("__ActiveWidget", oWidgetObject)

    -- Getting the properties of the widget.
    local tProperties = WSS.GetWidgetProperties(oWidgetObject)

    local tPropertyEntries = {}
    for sPropertyName, tPropertyData in pairs(tProperties) do
        local oCategory = HandleCategory(self, tPropertyData.Category)

        tPropertyEntries[sPropertyName] = WGUI.Create(PropertyEntry, oCategory.BodyContent, sPropertyName, tPropertyData, self)
    end

    self:SetValue("__PropertyEntries", tPropertyEntries)

    self:ForceLayoutPrepass()
    self:ForceUpdateEntries()
end

-- Returns the active widget object if set.
---@return BaseWidget
function PropertyEditor:GetWidget()
    return self:GetValue("__ActiveWidget")
end

-- Returns the property entries of the property editor.
---@return table<string, PropertyEntry>
function PropertyEditor:GetPropertyEntries()
    return self:GetValue("__PropertyEntries", {})
end

-- Updates the entries of the property editor.
function PropertyEditor:ForceUpdateEntries()
    local nDraggableLineWidth = self:GetDraggableLineWidth()

    ---@param oPropertyEntry PropertyEntry
    for _, oPropertyEntry in pairs(self:GetPropertyEntries()) do
        if oPropertyEntry:GetValueWidget() then
            oPropertyEntry:GetValueWidget():SetPadding(Margin(nDraggableLineWidth, 0, 0, 0))
        end

        local oTitleBorder = oPropertyEntry.HeaderTitleBorder

        local tTextDesiredSize = oPropertyEntry.HeaderTitle:GetDesiredSize()

        oTitleBorder:SetDesiredSizeScale(Vector2D((nDraggableLineWidth - 20) / tTextDesiredSize.X, 1))
    end
end

---@param oWidget BaseWidget
---@param sPropertyName string
---@param ... any
Events.Subscribe("WSS::OnPropertyValueChange", function (oWidget, sPropertyName, ...)
    local tPropertyEditors = PropertyEditor.GetAll()

    ---@param oPropertyEditor PropertyEditor
    for _, oPropertyEditor in pairs(tPropertyEditors) do
        local tPropertyEntries = oPropertyEditor:GetPropertyEntries()

        if oPropertyEditor:GetWidget() ~= oWidget then
            goto continue
        end

        if not tPropertyEntries[sPropertyName] then
            goto continue
        end

        local oPropertyEntry = tPropertyEntries[sPropertyName]

        if oPropertyEntry:GetValueWidget() then
            oPropertyEntry:GetValueWidget():SetInternalValue(...)
        end

        Chat.AddMessage("Property '" .. sPropertyName .. "' has been changed.")
        ::continue::
    end
end)

-- Loading dependencies
Package.Require("PropertyEditorCategory.lua")
Package.Require("PropertyValue.lua")

for _, sPath in pairs(Package.GetFiles("Client/PropertyEditor/Values")) do
    Package.Require(sPath)
end

Package.Require("PropertyEntry.lua")