---@class WidgetHierarchy : ListView
---`WidgetHierarchy` is a scrollable list of a widget's hierarchy.
WidgetHierarchy = ListView.Inherit("WidgetHierarchy")

function WidgetHierarchy:Constructor()
    ListView.Constructor(self)

    self:BindDispatcher("GenerateInternalWidget", function ()
        return WGUI.Create(TextBlock)
    end)

    self:BindDispatcher("UpdateInternalWidget", function (_, ItemIndex, EntryWidget)
        --local xData = self:GetItemData(ItemIndex)
        --EntryWidget:SetText(tostring(xData))
    end)
end

-- Adds a widget to the hierarchy.
---@param self WidgetHierarchy
---@param oWidget BaseWidget
local function AddWidget(self, oWidget)
    if not oWidget or not oWidget:IsValid() then
        return
    end

    local sClassName = tostring(oWidget:GetClass())

    local oTextBlock = WGUI.Create(TextBlock, self)
    oTextBlock:SetText(string.sub(sClassName, 1, #sClassName - 6)) -- Remove " Class" suffix
end

-- Rebuilds the widget hierarchy.
---@param oRootWidget BaseWidget | nil @If nil, it will use the WGUI layout canvas as the root widget.
function WidgetHierarchy:Rebuild(oRootWidget)
    oRootWidget = oRootWidget or WGUI.GetLayout()

    if not oRootWidget or not oRootWidget:IsValid() then
        Console.Warn("Invalid root widget provided for rebuilding widget hierarchy.")
        return self
    end

    -- Clear the current list of widgets.
    self:ClearListItems()

    for i = 1, 10 do
        self:AddItem(i)
    end

    do return self end
    for _, oChildren in ipairs(oRootWidget:GetAllChildren()) do
        AddWidget(self, oChildren)
    end

    return self
end