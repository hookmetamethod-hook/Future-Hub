if _G.SB_Status_aimbot == "loading" or _G.SB_Status_aimbot == "loaded" then error("SB_Scripts | light-weight aimbot | Already loading/loaded.", 3) end
-- one line anti-multi-instance go brrrrrr
_G.SB_Status_aimbot = "loading"

--// Services
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/R3P3x/FutureLib/refs/heads/main/main.lua"))()
local UI_Library = Library.UI.Fluent
repeat task.wait(0.1) until UI_Library ~= nil
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
--// Notify function
local function Notify(Message, SubMessage) if UI_Library and typeof(Message) == "string" and typeof(SubMessage) == "string" then UI_Library:Notify({Title = "Notification", Content = Message, SubContent = SubMessage, Duration = 6, Theme = UI_Library.Themes.Amethyst}) end end
--// Requirement checks
if getfenv().readfile and getfenv().writefile and getfenv().isfile then --[[nothing]] else Notify("An error occured when checking read/write functions, read dev console for more info.", ""); _G.SB_Status_cframesliding = nil; error("SB_Scripts | light-weight aimbot | Your exploit does not have readfile, writefile or isfile, those are required to use this script.", 2) end
--// SB_Scripts env check
if not getfenv().isfile("SB_Scripts") then getfenv().makefolder("SB_Scripts") end
task.wait()
--// Loading settings
local savedsettings;
local savedebug = true
do
	if getfenv().isfile("SB_Scripts/SB_Aimbot_Settings.json") then
		local success, result = pcall(function()
    		return game:GetService("HttpService"):JSONDecode(getfenv().readfile("SB_Scripts/SB_Aimbot_Settings.json"))
		end)
		if success and type(result) == "table" then
    		savedsettings = result
			Notify("Loaded saved settings.", "SB_'s light-weight aimbot")
		else
    		savedsettings = {AimbotEnabled = true, InGameControllerEnabled = false, FOVEnabled = true, TeamCheck = false, FOVVisible = true, FOVThickness = 1, FOVColor = Color3.fromRGB(255, 255, 255), RandomAimPart = false, AimPart = "Head", CircleRadius = 180, WallCheck = true}
			Notify("There was an error while loading your settings from SB_Aimbot_Settings.json, default settings were applied.", "SB_'s light-weight aimbot")
		end
	else
		savedsettings = {AimbotEnabled = true, InGameControllerEnabled = false, FOVEnabled = true, TeamCheck = false, FOVVisible = true, FOVThickness = 1, FOVColor = Color3.fromRGB(255, 255, 255), RandomAimPart = false, AimPart = "Head", CircleRadius = 180, WallCheck = true}
		Notify("You had no saved settings, default settings were applied.", "SB_'s light-weight aimbot")
	end
end

--// Config
_G.AimbotEnabled = savedsettings.AimbotEnabled-- if i have to explain this you're braindead

local InGameControllerEnabled = true
-- That ^ controls whether the in-game control ui is enabled
--[[this isnt coded yet btw, the description is just there cuz why not]]--

_G.FOVEnabled    = savedsettings.FOVEnabled   -- Whether or not FOV is enabled
_G.TeamCheck     = savedsettings.TeamCheck    -- If true, only locks onto enemies
_G.FOVVisible    = savedsettings.FOVVisible   -- Whether or not FOV circle is visible
_G.FOVThickness  = savedsettings.FOVThickness -- Thickness of the FOV circle
_G.RandomAimPart = savedsettings.RandomAimPart-- Randomly chooses aimbot (Head or Torso)
_G.AimPart       = savedsettings.AimPart      -- Again, if i gotta explain this ur brain is non-existant
_G.CircleRadius  = savedsettings.CircleRadius -- FOV circle radius (put 99999 if u want entire screen)
_G.WallCheck     = savedsettings.WallCheck    -- Stops aiming if target is behind a wall

--[[-------------------------------------------------------------------------
                   Do not modify anything below this line.                   
-------------------------------------------------------------------------]]--

--// FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.new(255, 255, 255)
FOVCircle.Thickness = _G.FOVThickness
FOVCircle.Filled = false
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Visible = _G.FOVVisible

--\\ Functions
if InGameControllerEnabled == true then
	local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/R3P3x/SB_Scripts/refs/heads/main/UniversalControlUI.lua"))()
end

_G.Friends = {} -- init Friends

local function IsVisible(target)
    if table.find(_G.Friends, target.Name) then return false end
    if not _G.WallCheck then return true end

    local Origin = Camera.CFrame.Position
    local TargetPosition = nil
    if _G.RandomAimPart == true then
        local v = math.random(1, 2)
        if v == 1 then
            TargetPosition = target.Character["Head"].Position
        else
            TargetPosition = target.Character["Torso"].Position
        end
    else
        TargetPosition = target.Character[_G.AimPart].Position
    end
    local Direction = (TargetPosition - Origin).Unit * (TargetPosition - Origin).Magnitude

    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    RaycastParams.FilterDescendantsInstances = {LocalPlayer.Character}

    local Result = workspace:Raycast(Origin, Direction, RaycastParams)
    
    return Result == nil or Result.Instance:IsDescendantOf(target.Character)
end

local function GetClosestPlayer()
    local ClosestTarget, ShortestDistance = nil, _G.CircleRadius
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(_G.AimPart) and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if table.find(_G.Friends, v.Name) then continue end
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end

            local ScreenPos, OnScreen = Camera:WorldToScreenPoint(v.Character[_G.AimPart].Position)
            if OnScreen then
                local MousePos = UserInputService:GetMouseLocation()
                local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
                
                if (not _G.FOVEnabled or Distance <= _G.CircleRadius) and Distance < ShortestDistance and IsVisible(v) then
                    ClosestTarget, ShortestDistance = v, Distance
                end
            end
        end
    end
    return ClosestTarget
end

local function ToggleFriend(target)
    local found = table.find(_G.Friends, target.Name)
    if found then
        table.remove(_G.Friends, found)
        Notify("Removed "..target.Name.." from friends", "SB_'s light-weight aimbot")
    else
        table.insert(_G.Friends, target.Name)
        Notify("Added "..target.Name.." as a friend", "SB_'s light-weight aimbot")
    end
end

--// User input handling
_G.sbaimbotuserinput1 = UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton3 then
        local MousePos = UserInputService:GetMouseLocation()
        local Origin = Camera.CFrame.Position
        local Direction = (Camera:ScreenPointToRay(MousePos.X, MousePos.Y).Direction * 1000)
        
        local RaycastParams = RaycastParams.new()
        RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParams.FilterDescendantsInstances = {LocalPlayer.Character}

        local Result = workspace:Raycast(Origin, Direction, RaycastParams)
        
        if Result and Result.Instance then
            local TargetCharacter = Result.Instance.Parent
            if TargetCharacter:IsA("Model") and TargetCharacter:FindFirstChild("Humanoid") then
                local TargetPlayer = Players:GetPlayerFromCharacter(TargetCharacter)
                if TargetPlayer then
                    ToggleFriend(TargetPlayer)
                end
            end
        end
    end
end)

local Holding = false
_G.sbaimbotuserinput2 = UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

_G.sbaimbotuserinput3 = UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

_G.sbaimbotrunservice2 = RunService.RenderStepped:Connect(function()
    local MousePos = UserInputService:GetMouseLocation()
    FOVCircle.Position = MousePos
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Visible = _G.FOVEnabled and _G.FOVVisible
    
    if Holding and _G.AimbotEnabled then
        local Target = GetClosestPlayer()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character[_G.AimPart].Position)
        end
    end
end)

task.spawn(function()
    while task.wait(10) do
        local success, err = pcall(function()
            getfenv().writefile("SB_Scripts/SB_Aimbot_Settings.json", game:GetService("HttpService"):JSONEncode({
                AimbotEnabled = true,
                InGameControllerEnabled = false,
                FOVEnabled = true,
                TeamCheck = false,
                FOVVisible = true,
                FOVThickness = 1,
                RandomAimPart = false,
                AimPart = "Head",
                CircleRadius = 180,
                WallCheck = true
            }))
        end)
        if savedebug then
            print("SB_Scripts | light-weight aimbot | Autosave Success: ", success, " | Error: ", err) 
        end
    end
end)

Notify("Loaded!", "SB_'s light-weight aimbot")
_G.SB_Status_aimbot = "loaded"
