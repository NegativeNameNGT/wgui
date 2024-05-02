---@class WidgetAnimation
WidgetAnimationMT = {}
WidgetAnimationMT.__index = WidgetAnimationMT

local tAnimationObjects = {}

-- Updates the animation.
local function Tick()
    for _, oAnimation in pairs(tAnimationObjects) do
        -- Checks if the animation is still valid.
        if not (oAnimation.oWidget and oAnimation.oWidget:IsValid()) then
            -- Destroys the animation.
            oAnimation:Stop()
            return
        end

        local fElapsed = os.clock() - oAnimation.fStartTime

        local fDelta = fElapsed / oAnimation.fDuration
        fDelta = math.floor(fDelta * 1000) / 1000

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
---@param fnCompleted fun(self: WidgetAnimation, IsReverse: boolean) | nil
---@param bAutoDestroy boolean | nil
---@param fnEasingFunction function | nil
---@return WidgetAnimation
function BaseWidget:CreateAnimationObject(fnGetter, fnSetter, fEndValue, fDuration, fnCompleted, bAutoDestroy, fnEasingFunction)
    ---@class WidgetAnimation
    local oAnimation = setmetatable({}, WidgetAnimationMT)

    oAnimation.oWidget = self
    oAnimation.fnGetter = fnGetter
    oAnimation.fnSetter = fnSetter

    oAnimation.fStartValue = fnGetter(self)
    oAnimation.fOriginalStartValue = oAnimation.fStartValue

    oAnimation.fEndValue = fEndValue
    oAnimation.fOriginalEndValue = oAnimation.fEndValue

    oAnimation.fDuration = fDuration
    oAnimation.fnCompleted = fnCompleted
    oAnimation.bAutoDestroy = bAutoDestroy or false
    oAnimation.fnEasingFunction = fnEasingFunction
    oAnimation.bIsCompleted = false
    oAnimation.fStartTime = os.clock()

    return oAnimation
end

-- Plays the animation relative to its current state forward.
function WidgetAnimationMT:PlayForward()
    -- Check if the animation is already playing in the reverse direction.
    if self.bIsReverse then
        local fTempValue = self.fStartValue
        self.fStartValue = self.fEndValue
        self.fEndValue = fTempValue
        self.bIsReverse = false
        if self.bIsCompleted then
            -- Reset the start time if the animation had finished.
            self.fStartTime = os.clock()
        else
            -- Recalculate the start time based on the current state.
            self:RecalculateStartTime()
        end
    else
        self.fStartTime = os.clock()
    end

    self:Play()

    return self
end

-- Plays the animation in the reverse direction.
function WidgetAnimationMT:PlayReverse()
    if not self.bIsReverse then
        -- Swap the start and end values for reversing the animation.
        self.fStartValue, self.fEndValue = self.fEndValue, self.fStartValue

        if self.bIsCompleted then
            -- Reset the start time if the animation had finished.
            self.fStartTime = os.clock()
        else
            -- Recalculate the start time based on the current state.
            self:RecalculateStartTime()
        end

        self.bIsReverse = true
        self.bIsCompleted = false
    end

    -- Start or resume the animation.
    self:Play()

    return self
end

-- Forces the animation to play. Used internally.
function WidgetAnimationMT:Play()
    if self.iID then
        return
    end

    self.bIsCompleted = false

    self.iID = #tAnimationObjects + 1
    tAnimationObjects[self.iID] = self
end

-- Stops the animation.
function WidgetAnimationMT:Stop()
    self.bIsCompleted = true

    if self.fnCompleted then
        self.fnCompleted(self, self.bIsReverse or false)
    end

    if self.bAutoDestroy then
        self:Destroy()
        return
    end

    tAnimationObjects[self.iID] = nil
    self.iID = nil

    return self
end

-- Returns whether the animation is playing.
function WidgetAnimationMT:IsPlaying()
    return self.iID ~= nil
end

-- Destroys the animation.
function WidgetAnimationMT:Destroy()
    if self.iID then
        tAnimationObjects[self.iID] = nil
    end
    setmetatable(self, nil)
end

-- Recalculates the start time of the animation.
function WidgetAnimationMT:RecalculateStartTime()
    self.fStartTime = os.clock() - (self.fDuration - (os.clock() - self.fStartTime))
end
