---@class WidgetAnimation
local AnimationMT = {}
AnimationMT.__index = AnimationMT

local tAnimationObjects = {}

-- Updates the animation.
local function Tick()
    for _, oAnimation in ipairs(tAnimationObjects) do
        -- Checks if the animation is still valid.
        if not (oAnimation.oWidget and oAnimation.oWidget:IsValid()) then
            -- Destroys the animation.
            oAnimation:Stop()
            return
        end

        local fElapsed = os.clock() - oAnimation.fStartTime

        local fDelta = fElapsed / oAnimation.fDuration

        if oAnimation.fnEasingFunction then
            fDelta = oAnimation.fnEasingFunction(fDelta)
        end

        if fDelta > 1 then
            fDelta = 1
        end

        oAnimation.fNewValue = oAnimation.fStartValue + (oAnimation.fEndValue - oAnimation.fStartValue) * fDelta
        oAnimation.fnSetter(oAnimation.oWidget, oAnimation.fNewValue)

        if fDelta >= 1 then
            oAnimation:Stop()
        end
    end
end
Client.Subscribe("Tick", Tick)

-- Plays an animation on a widget
---@param fnGetter function
---@param fnSetter function
---@param fEndValue number | Vector2D
---@param fDuration number
---@param fnCompleted function | nil
---@param fnEasingFunction function | nil
---@return WidgetAnimation
function BaseWidget:Animate( fnGetter, fnSetter, fEndValue, fDuration, fnCompleted, fnEasingFunction )
    local oAnimation = setmetatable({}, AnimationMT)

    oAnimation.oWidget = self
    oAnimation.fnGetter = fnGetter
    oAnimation.fnSetter = fnSetter

    oAnimation.fStartValue = fnGetter(self)
    oAnimation.fOriginalStartValue = oAnimation.fStartValue

    oAnimation.fEndValue = fEndValue
    oAnimation.fOriginalEndValue = oAnimation.fEndValue

    oAnimation.fDuration = fDuration
    oAnimation.fnCompleted = fnCompleted
    oAnimation.fnEasingFunction = fnEasingFunction
    oAnimation.bIsCompleted = false
    oAnimation.fStartTime = os.clock()

    oAnimation.iID = #tAnimationObjects + 1
    tAnimationObjects[oAnimation.iID] = oAnimation
    return oAnimation
end

-- Plays the animation in forward direction.
function AnimationMT:Forward()
    if self.bIsReverse then
        self:RecalculateStartTime()
    end

    self.fStartValue = self.fOriginalStartValue
    self.fEndValue = self.fOriginalEndValue
    self.bIsReverse = nil
    self:Play()
end

-- Plays the animation in reverse direction.
function AnimationMT:Reverse()
    if not self.bIsReverse then
        -- Check if animation has completed, if so reset the start time
        if self.bIsCompleted then
            self.fStartTime = os.clock()
        else
            self:RecalculateStartTime()
        end
    end

    self.fStartValue = self.fOriginalEndValue
    self.fEndValue = self.fOriginalStartValue
    self.bIsReverse = true
    self:Play()
end

-- Forces the animation to play.
function AnimationMT:Play()
    if self.iID then
        return
    end

    self.bIsCompleted = false

    self.iID = #tAnimationObjects + 1
    tAnimationObjects[self.iID] = self
end

-- Stops the animation.
function AnimationMT:Stop()
    self.bIsCompleted = true

    if self.fnCompleted then
        self.fnCompleted()
    end

    tAnimationObjects[self.iID] = nil
    setmetatable(self, nil)
end

-- Recalculates the start time of the animation.
function AnimationMT:RecalculateStartTime()
    self.fStartTime = os.clock() - (self.fDuration - (os.clock() - self.fStartTime))
end