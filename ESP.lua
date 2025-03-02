_G.ESPEnabled = false
_G.ESPColour = Color3.fromRGB(255, 255, 255)

local highlight = Instance.new("Highlight")

for _, v in pairs(game.Players:GetPlayers()) do
	if not v.Character:FindFirstChild("Highlight") then
		highlight:Clone().Parent = v.Character
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillColor = _G.ESPColour
	end
end

pcall(
	function()
		game.Players.PlayerAdded:Connect(
			function(plr)
				for _, v in pairs(game.Players:GetPlayers()) do
					if not v.Character:FindFirstChild("Highlight") then
						highlight:Clone().Parent = v.Character
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						highlight.FillColor = _G.ESPColour
					end
				end
				plr.CharacterAdded:Connect(
					function(char)
						if not char:FindFirstChild("Highlight") then
							highlight:Clone().Parent = char
							highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
							highlight.FillColor = _G.ESPColour
						end
					end
				)
			end
		)
	end
)
while true do
	for _,v in pairs(game.Players:GetPlayers()) do
		local CharHighlight = v.Character:FindFirstChild("Highlight")
		CharHighlight.Enabled = _G.ESPEnabled
		CharHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		CharHighlight.FillColor = _G.ESPColour
	end
	wait(0.3)
end
