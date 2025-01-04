Package.Require("PanelWidget.lua")

---@class ContentWidget : PanelWidget
ContentWidget = PanelWidget.Inherit("ContentWidget")
ContentWidget.ChildrenLimit = 1

-- Sets the content of the widget.
---@generic T
---@param self T | ContentWidget
---@param vContentWidget BaseWidget
---@return T
function ContentWidget:SetContent(vContentWidget)
    if not NanosUtils.IsEntityValid(vContentWidget) then
        return self
    end

    if self:HasAnyChildren() then
        local vOldContent = self:GetAllChildren()[1]
        if NanosUtils.IsEntityValid(vOldContent) then
            vOldContent:Destroy()
        end

        self:RemoveChild(vOldContent)
    end

    self:AddChild(vContentWidget)

    return self
end

-- Gets the content of the widget.
---@return BaseWidget | nil
function ContentWidget:GetContent()
    if not self:HasAnyChildren() then
        return nil
    end

    return self:GetAllChildren()[1]
end