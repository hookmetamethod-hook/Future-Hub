_G.ESPEnabled = false
_G.ESPColour = Color3.fromRGB(255, 255, 255)

local highlight = Instance.new("Highlight")

-- Function to apply ESP to a character
local function ApplyESP(Char)
	if Char and not Char:FindFirstChild("Highlight") then
		local NewHighlight = highlight:Clone()
		NewHighlight.Parent = Char
		NewHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		NewHighlight.FillColor = _G.ESPColour
	end
end

-- Connect CharacterAdded for all current players
for _, v in pairs(game.Players:GetPlayers()) do
	if v.Character then
		ApplyESP(v.Character)
	end
	v.CharacterAdded:Connect(ApplyESP) -- Ensures ESP is applied on respawn
end

-- Ensure new players also get CharacterAdded connected
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(applyESP)
end)

while true do
	for _, v in pairs(game.Players:GetPlayers()) do
		if v.Character then
			local CharHighlight = v.Character:FindFirstChild("Highlight")
			if CharHighlight then
				CharHighlight.Enabled = _G.ESPEnabled
				CharHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				CharHighlight.FillColor = _G.ESPColour
			end
		end
	end
	wait(0.3)
end
