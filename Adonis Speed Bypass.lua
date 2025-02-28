local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")

_G.SpeedEnabled = false
_G.SpeedMultiplier = 1

RunService.RenderStepped:Connect(function()
	if _G.SpeedEnabled == true and Char ~= nil then
		local MoveDir = Char.Humanoid.MoveDirection
		if MoveDir.Magnitude > 0 then
			Char.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + (MoveDir * _G.SpeedMultiplier * 0.1)
		end
	end
end)

Player.CharacterAdded:Connect(function(newCharacter)
	Char = newCharacter
end)
