if _G.FHdebug then print("-=- FHdebug enabled -=-") end
if _G.FH_Status_AdonisSpeedBypass == "loading" or _G.FH_Status_AdonisSpeedBypass == "loaded" then error("Future Hub | Adonis speed bypass | Already loading/loaded.", 3) end -- one line anti-multi-instance go brrrrrr
_G.FH_Status_AdonisSpeedBypass = "loading"
if _G.FHdebug then print("set status: loading") end

if not _G.Library then
	if _G.FHdebug then print("no library") end
	_G.Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/FutureLib/refs/heads/main/main.lua"))()
	if _G.FHdebug then print("loaded library") end
	if not _G.UI_Library then if _G.FHdebug then print("no ui library") end; _G.UI_Library = _G.Library.UI.Fluent; if _G.FHdebug then print("loaded ui library") end end
end
repeat task.wait(0.1) until _G.UI_Library ~= nil
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
if _G.FHdebug then print("definded services") end

local function Notify(Message, SubMessage)
	if UI_Library and typeof(Message) == "string" and typeof(SubMessage) == "string" then
		UI_Library:Notify({Title = "Notification", Content = Message, SubContent = SubMessage, Duration = 6 })
	end
end
if _G.FHdebug then print("set up Notify function") end

if getfenv().readfile and getfenv().writefile and getfenv().isfile then --[[nothing]] if _G.FHdebug then print("readfile, writefile and isfile are available") end else
	if _G.FHdebug then print("readfile, writefile or isfile are not available, warning user of issue") end
	Notify("An error occured when checking read/write functions, read dev console for more info.", "Future Hub | Adonis Speed Bypass")
	_G.FH_Status_AdonisSpeedBypass = nil
	error("Future Hub | Adonis Speed Bypass | Your exploit does not have readfile, writefile or isfile, those are required to use this script.", 2)
	if _G.FHdebug then print("warned user of issue") end
end

if not getfenv().isfile("FutureHub") then
	if _G.FHdebug then print("FutureHub folder didnt exist in workspace, creating") end
	getfenv().makefolder("FutureHub")
	if _G.FHdebug then print("created FutureHub in workspace") end
end
task.wait()
local savedsettings;
local savedebug = false
do
	if getfenv().isfile("FutureHub/FH_AdonisSpeedBypass_Settings.json") then
		if _G.FHdebug then print("settings exist") end
		local success, result = pcall(function()
    		return game:GetService("HttpService"):JSONDecode(getfenv().readfile("FutureHub/FH_AdonisSpeedBypass_Settings.json"))
		end)
		if success and type(result) == "table" then
			if _G.FHdebug then print("settings loaded") end
    		savedsettings = result
			Notify("Loaded saved settings.", "Future Hub | Adonis speed bypass")
		else
			if _G.FHdebug then print("settings errored") end
    		savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
			Notify("There was an error while loading your settings from FH_AdonisSpeedBypass_Settings.json, default settings were applied.", "Future Hub | Adonis speed bypass")
		end
	else
		if _G.FHdebug then print("settings dont exist") end
		savedsettings = {SpeedEnabled = true, SpeedMultiplier = 1}
		Notify("You had no saved settings, default settings were applied.", "Future Hub | Adonis speed bypass")
	end
end

_G.SpeedEnabled = savedsettings.SpeedEnabled
_G.SpeedMultiplier = savedsettings.SpeedMultiplier

if _G.FHdebug then print("initiating ui") end
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/Future-Hub/refs/heads/main/UniversalControlUI.lua"))()
if _G.FHdebug then print("ui") end

if _G.FHdebug then print("setting up main function") end
RunService.RenderStepped:Connect(function()
	if _G.SpeedEnabled == true and Char ~= nil then
	    local MoveDir = Char.Humanoid.MoveDirection
        if MoveDir.Magnitude > 0 then
            Char.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + (MoveDir * _G.SpeedMultiplier * 0.1)
    	end
	end
end)
if _G.FHdebug then print("done") end

if _G.FHdebug then print("setting up character function") end
Player.CharacterAdded:Connect(function(newCharacter)
	Char = newCharacter
end)
if _G.FHdebug then print("done") end

if _G.FHdebug then print("setting up save loop") end
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
if _G.FHdebug then print("done") end
_G.FH_Status_AdonisSpeedBypass = "loaded"
if _G.FHdebug then print("set status: laoded") end
Notify("Loaded!", "Future Hub | Adonis speed bypass")
if _G.FHdebug then print("finished loading script") end
if -G.FHdebug then print("-=-=-=-=-=-=-=-=-=-=-=-") end
