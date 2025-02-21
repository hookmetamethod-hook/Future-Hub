loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/protectui.lua"))()
if _G.FH_Status_ASB == "loading" or _G.FH_Status_ASB == "loaded" then error("Future Hub | Adonis Speed Bypass", 3) end
_G.FH_Status_ASB = "loading"

if not _G.Library then error("Future Hub | Library failed to initialize") end
local function Log(Text, Typee) _G.Library.Logger:Prompt({Title = Text, TypesWeHave = {"default", "success", "fail", "warning", "notification"}, Type = Typee}) end

local Notifs = _G.Library.Notifications

local function Notify(Type, Text, Duration)
    Notifs.new(Type, "Future Hub | ASB", Text, true, Duration)
end
if _G.FHdebug then Log("ASB | Set up Notify function", "success") end

if _G.FHdebug then Log("ASB | Checking fenv functions", "default") end
if getfenv().writefile and getfenv().readfile and getfenv().isfile and getfenv().makefolder then
	--[[- n o t h i n g -]]--
else
	Log("ASB | Fatal error: your exploit does not support writefile, readfile, or isfile, these functions are required to use this script.", "fail")
	task.wait()
	error("Future Hub | Adonis Speed Bypass | Fatal error: your exploit does not support writefile, readfile, isfile or makefolder, these functions are required to use this script.", 3)
end
if _G.FHdebug then Log("ASB | fenv function checks passed", "success") end

if _G.FHdebug then Log("ASB | Checking Future Hub environment", "default") end
if not getfenv().isfile("FutureHub") then
	getfenv().makefolder("FutureHub")
end

if _G.FHdebug then Log("ASB | Checking/Loading saved settings", "default") end
local savedsettings;
if getfenv().isfile("FutureHub/FH_AdonisSpeedBypass_Settings.json") then
	local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(getfenv().readfile("FutureHub/FH_AdonisSpeedBypass_Settings.json"))
    end)
    if success and type(result) == "table" then
		if _G.FHdebug then Log("ASB | Loaded saved settings", "success") end
        savedsettings = result
        Notify("success", "Loaded saved settings", 8)
    else
        if _G.FHdebug then Log("ASB | and error occured while loading saved settings, applying default", "fail") end
		savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
		Notify("error", "An error occured while loading saved settings", 8)
    end
else
	if _G.FHdebug then Log("ASB | No saved settings found, applying default", "warning") end
	savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
	Notify("warning", "No saved settings found", 8)
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
if _G.FHdebug then Log("ASB | Defined constants", "default") end

_G.SpeedEnabled = savedsettings.SpeedEnabled
_G.SpeedMultiplier = savedsettings.SpeedMultiplier

if _G.FHdebug then Log("ASB | Connecting loop", "default") end
RunService.RenderStepped:Connect(function()
	if _G.SpeedEnabled == true and Char ~= nil then
		local MoveDir = Char.Humanoid.MoveDirection
		if MoveDir.Magnitude > 0 then
			Char.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + (MoveDir * _G.SpeedMultiplier * 0.1)
		end
	end
end)
if _G.FHdebug then Log("ASB | done", "success") end

if _G.FHdebug then Log("ASB | Connecting CharacterAdded event", "default") end
Player.CharacterAdded:Connect(function(newCharacter)
	Char = newCharacter
end)
if _G.FHdebug then Log("ASB | done", "success") end

if _G.FHdebug then Log("ASB | Setting up save loop", "default") end
task.spawn(function()
    while task.wait(10) do
        local savingsetting = {SpeedEnabled = _G.SpeedEnabled, SpeedMultiplier = _G.SpeedMultiplier}
        local success, err = pcall(function()
            getfenv().writefile("FutureHub/FH_AdonisSpeedBypass_Settings.json", game:GetService("HttpService"):JSONEncode(savingsetting))
        end)
        if _G.FHdebug then
            Log("ASB | Saved: "..success, "notification")
        end
    end
end)
if _G.FHdebug then Log("ASB | done", "success") end

Notify("success", "Loaded Adonis Speed Bypass", 8)
task.wait(0.5)
_G.FH_Status_ASB = "loaded"
