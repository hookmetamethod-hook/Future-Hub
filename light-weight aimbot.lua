--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Config
_G.AimbotEnabled = true   -- if i have to explain this you're braindead

_G.FOVEnabled    = true   -- Whether or not FOV is enabled
_G.TeamCheck     = false  -- If true, only locks onto enemies
_G.FOVVisible    = true   -- Whether or not FOV circle is visible
_G.FOVThickness  = 1      -- Thickness of the FOV circle
_G.RandomAimPart = false  -- Randomly chooses aimbot (Head or Torso)
_G.AimPart       = "Head" -- Again, if i gotta explain this ur brain is non-existant
_G.CircleRadius  = 180    -- FOV circle radius (put 99999 if u want entire screen)
_G.WallCheck     = true   -- Stops aiming if target is behind a wall

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
        Notify("Removed "..target.Name.." from friends", "Future Hub | light-weight aimbot")
    else
        table.insert(_G.Friends, target.Name)
        Notify("Added "..target.Name.." as a friend", "Future Hub | light-weight aimbot")
    end
end

--// User input handling
_G.FHaimbotuserinput1 = UserInputService.InputBegan:Connect(function(Input)
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
_G.FHaimbotuserinput2 = UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

_G.FHaimbotuserinput3 = UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

_G.FHaimbotrunservice1 = RunService.RenderStepped:Connect(function()
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
