local Players = game.Players
local Plr = Players.LocalPlayer
local Char = Plr.Character or plr.CharacterAdded:Wait()
local humanoid = Char:WaitForChild("Humanoid")
local humanoidRootPart = Char:WaitForChild("HumanoidRootPart")

_G.changeProperty = function(property, value)
    if humanoid[property] ~= nil then
        local success, err = pcall(function()
            humanoid[property] = value
        end)
        if success then
            return true
        else
            return false, err
        end
    elseif humanoidRootPart[property] ~= nil then
        local success, err = pcall(function()
            humanoidRootPart[property] = value
        end)
        if success then
            return true
        else
            return false, err
        end
    else
        local err = 'Property "' .. property .. '" is not a valid property of Humanoid or HumanoidRootPart'
        return false, err
    end
end

Plr.CharacterAdded:Connect(function(newChar)
    Char = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
end)
