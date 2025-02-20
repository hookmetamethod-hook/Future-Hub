if _G.FH_Status_AdonisSpeedBypass == "loading" or _G.FH_Status_AdonisSpeedBypass == "loaded" then error("Future Hub | Adonis speed bypass | Already loading/loaded.", 3) end -- one line anti-multi-instance go brrrrrr
_G.FH_Status_AdonisSpeedBypass = "loading"

if not _G.Library then
	_G.Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/FutureLib/refs/heads/main/main.lua"))()
	if not _G.UI_Library then _G.UI_Library = _G.Library.UI.Fluent end
end
repeat task.wait(0.1) until UI_Library ~= nil
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")

local function Notify(Message, SubMessage)
    if UI_Library and typeof(Message) == "string" and typeof(SubMessage) == "string" then
    	UI_Library:Notify({Title = "Notification", Content = Message, SubContent = SubMessage, Duration = 6 })
	end
end

if getfenv().readfile and getfenv().writefile and getfenv().isfile then --[[nothing]] else
	Notify("An error occured when checking read/write functions, read dev console for more info.", "Future Hub | Adonis Speed Bypass")
	_G.FH_Status_AdonisSpeedBypass = nil
	error("Future Hub | Adonis Speed Bypass | Your exploit does not have readfile, writefile or isfile, those are required to use this script.", 2)
end

if not getfenv().isfile("FutureHub") then
	getfenv().makefolder("FutureHub")
end
task.wait()
local savedsettings;
local savedebug = false
do
	if getfenv().isfile("SB_Scripts/savedsettings.json") then
		local success, result = pcall(function()
    		return game:GetService("HttpService"):JSONDecode(getfenv().readfile("FutureHub/FH_AdonisSpeedBypass_Settings.json"))
		end)
		if success and type(result) == "table" then
    		savedsettings = result
			Notify("Loaded saved settings.", "Future Hub | Adonis speed bypass")
		else
    		savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
			Notify("There was an error while loading your settings from FH_AdonisSpeedBypass_Settings.json, default settings were applied.", "Future Hub | Adonis speed bypass")
		end
	else
		savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
		Notify("You had no saved settings, default settings were applied.", "Future Hub | Adonis speed bypass")
	end
end

_G.SpeedEnabled = savedsettings.SpeedEnabled
_G.SpeedMultiplier = savedsettings.SpeedMultiplier

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/Future-Hub/refs/heads/main/UniversalControlUI.lua"))()

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

task.spawn(function()
    while task.wait(10) do
        local success, err = pcall(function()
            getfenv().writefile("FutureHub/FH_AdonisSpeedBypass_Settings.json", game:GetService("HttpService"):JSONEncode({
                SpeedEnabled = _G.SpeedEnabled,
                SpeedMultiplier = _G.SpeedMultiplier
            }))
        end)
        if savedebug then
            print("Future Hub | Adonis speed bypass | Autosave Success: ", success, " | Error: ", err)
        end
    end
end)
_G.FH_Status_AdonisSpeedBypass = "loaded"
Notify("Loaded!", "Future Hub | Adonis speed bypass")
