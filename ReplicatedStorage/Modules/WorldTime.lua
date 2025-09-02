local WorldTime = {}
WorldTime.__index = WorldTime

-- Seconds for a full day cycle
WorldTime.DayLength = 120

-- Possible weather states
WorldTime.WeatherStates = {"Clear", "Rain", "Fog"}

function WorldTime.new()
    return setmetatable({
        Time = 0,
        Weather = "Clear",
        TimeCallbacks = {},
        WeatherCallbacks = {},
    }, WorldTime)
end

-- Advances the world clock and wraps around at DayLength
function WorldTime:Update(dt)
    local previous = self.Time
    self.Time = (self.Time + dt) % WorldTime.DayLength
    if self.Time < previous then
        -- Day rolled over
        for _, cb in ipairs(self.TimeCallbacks) do
            cb(self.Time)
        end
    end
end

-- Registers a callback for when the day resets
function WorldTime:OnDayCycle(callback)
    table.insert(self.TimeCallbacks, callback)
end

-- Sets the weather state and triggers callbacks
function WorldTime:SetWeather(state)
    self.Weather = state
    for _, cb in ipairs(self.WeatherCallbacks) do
        cb(state)
    end
end

-- Randomizes the weather
function WorldTime:RandomizeWeather()
    local states = WorldTime.WeatherStates
    local index = math.random(1, #states)
    self:SetWeather(states[index])
end

-- Registers a callback for when weather changes
function WorldTime:OnWeatherChanged(callback)
    table.insert(self.WeatherCallbacks, callback)
end

return WorldTime
