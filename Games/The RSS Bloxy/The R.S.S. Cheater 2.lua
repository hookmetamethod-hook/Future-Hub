Version = "0.2.4"

warn("----------------------------------------------------|")
warn("Loading The R.S.S. Cheater 2 V" .. Version .. "!")
warn("----------------------------------------------------|")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local UISettings = {
    TabWidth = 160,
    Size = { 680, 560 },
    Theme = "Darker",
    Acrylic = false,
    Transparency = false,
    MinimizeKey = "RightShift",
    ShowWarnings = true,
    RenderingMode = "RenderStepped",
    AutoImport = true
}

local InterfaceManager = {}

function InterfaceManager:ImportSettings()
    pcall(function()
        if getfenv().isfile and getfenv().readfile and getfenv().isfile("UISettings.F_INT") and getfenv().readfile("UISettings.F_INT") then
            for Key, Value in next, HttpService:JSONDecode(getfenv().readfile("UISettings.F_INT")) do
                UISettings[Key] = Value
            end
        end
    end)
end

function InterfaceManager:ExportSettings()
    pcall(function()
        if getfenv().isfile and getfenv().readfile and getfenv().writefile then
            getfenv().writefile("UISettings.F_RSSTWO", HttpService:JSONEncode(UISettings))
        end
    end)
end

InterfaceManager:ImportSettings()

UISettings.__LAST_RUN__ = os.date()
InterfaceManager:ExportSettings()

local Player = Players.LocalPlayer
local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

warn("Constants loaded!")

local Fluent = nil

do
    if typeof(script) == "Instance" and script:FindFirstChild("Fluent") and script:FindFirstChild("Fluent"):IsA("ModuleScript") then
        Fluent = require(script:FindFirstChild("Fluent"))
    else
        local Success, Result = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/R3P3x/Scripts/refs/heads/main/Fluent.txt", true)
        end)
        if Success and typeof(Result) == "string" then
            Fluent = loadstring(Result)()
        else
            return
        end
    end
end

local function Notify(Message)
    if Fluent and typeof(Message) == "string" then
        Fluent:Notify({
            Title = "The R.S.S. Cheater 2",
            Content = Message,
            SubContent = "[Future Hub]",
            Duration = 10
        })
    end
end

local exploit = function(target)
    if game.Workspace:FindFirstChild(target) then
        if game.Workspace:FindFirstChild(target):FindFirstChild("HumanoidRootPart") then
            if game.Players.LocalPlayer.Character:FindFirstChild("Phaser") then
                game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.MouseGrabber.Enabled = false
                local tarpos = game.Workspace:FindFirstChild(target).HumanoidRootPart.CFrame
                game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.Shoot:FireServer(tarpos)
                task.wait(0.8)
                local tarpos = game.Workspace:FindFirstChild(target).HumanoidRootPart.CFrame
                game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.Shoot:FireServer(tarpos)
                task.wait(0.8)
                local tarpos = game.Workspace:FindFirstChild(target).HumanoidRootPart.CFrame
                game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.Shoot:FireServer(tarpos)
                task.wait(0.8)
                local tarpos = game.Workspace:FindFirstChild(target).HumanoidRootPart.CFrame
                game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.Shoot:FireServer(tarpos)
                task.wait(0.5)
                if game.Workspace:FindFirstChild(target).Humanoid.Health <= 0 then
                    game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Phaser.MouseGrabber.Enabled = true
                    Notify(target.." has been killed.")
                else
                    Notify(target.." did not die from the attack!")
                end
            else
                Notify("You need to hold your phaser!")
            end
        else
            Notify("Target is not rendered, increase graphics settings or move closer.")
        end
    else
        Notify("Incorrect or incomplete target username, make sure its the full username.")
    end
end

warn("Fluent UI Library loaded!")

do
    local Window = Fluent:CreateWindow({
        Title = "The R.S.S. Cheater 2",
        SubTitle = "[PRIVATE RELEASE V" .. Version .. "]",
        TabWidth = UISettings.TabWidth,
        Size = UDim2.fromOffset(table.unpack(UISettings.Size)),
        Theme = UISettings.Theme,
        Acrylic = UISettings.Acrylic,
        MinimizeKey = UISettings.MinimizeKey
    })
    warn("Check 1")
    local Tabs = { PhaserMods = Window:AddTab({ Title = "Phaser", Icon = "crosshair" }) }

    Window:SelectTab(1)

    local Modded = false

    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    humanoid.Died:Connect(function()
        Modded = false
    end)

    warn("Check 2")

    local tarplrs = {}

    local tarplr = nil

    RunService.Heartbeat:Connect(function()
        table.clear(tarplrs)
        for _, plr in Players:GetPlayers() do
            if not table.find(tarplrs, plr.Name) then
                table.insert(tarplrs, plr.Name)
            end
        end
    end)

    local playerDropdown = Tabs.PhaserMods:AddDropdown("Plrs", {
        Title = "Target Player",
        Description = "Sets the target player.",
        Values = tarplrs,
        Multi = false,
        Default = nil,
        Callback = function(Value)
            tarplr = Value
            print("Selected target player: ", tarplr)
        end
    })

    RunService.Heartbeat:Connect(function()
        playerDropdown:SetValues(tarplrs)
        task.wait(0.8)
    end)

    Tabs.PhaserMods:AddButton({
        Title = "Exploit",
        Description = "Attempts to kill the target player.",
        Callback = function()
            if game.Players:FindFirstChild(tarplr) then
                exploit(tarplr)
            else
                Notify("what the fuck?")
            end
        end
    })

    Tabs.PhaserMods:AddParagraph({Title = "Important!", Content = "The button below requires more explanation, it will use an exploit to go through every player, if the player is holding their phaser it will make them shoot themselfs 4 times.\n\[THIS IS EXTREMELY BLATANT AND WILL GET YOU BANNED BY STAFF!!!\]"})

    Tabs.PhaserMods:AddButton({
        Title = "The Great Self OOFening",
        Description = "World Ending :O",
        Default = false,
        Callback = function(Value)
            Window:Dialog({
                        Title = "Warning!",
                        Content = "This is very blatant and very unstable, do you want to proceed?",
                        Buttons = {
                            {
                                Title = "Yes",
                                Callback = function()
                                    for _, plr in game.Players:GetPlayers() do
                                        if plr.Character and plr.Character:FindFirstChild("Phaser") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Name ~= game.Players.LocalPlayer.Name then
                                            Notify("The Great Self OOFening has commenced!!!")
                                            plr.Character.Phaser.Shoot:FireServer(plr.Character.HumanoidRootPart.CFrame)
                                            task.wait(0.8)
                                            plr.Character.Phaser.Shoot:FireServer(plr.Character.HumanoidRootPart.CFrame)
                                            task.wait(0.8)
                                            plr.Character.Phaser.Shoot:FireServer(plr.Character.HumanoidRootPart.CFrame)
                                            task.wait(0.8)
                                            plr.Character.Phaser.Shoot:FireServer(plr.Character.HumanoidRootPart.CFrame)
                                            task.wait(0.5)
                                            Notify("The Great Self OOFening has ended.")
                                        end
                                    end
                                end
                            },
                            {
                                Title = "No.",
                                Callback = function()
                                    warn("The Great Self OOFening has been cancelled! phew...")
                                end
                            }
                        }
                    })
        end
    })

    --[[PlayerMods = Window:AddTab({ Title = "Player", Icon = "user" })

    local walkspeeding = false
    local walkspeed = 16

    PlayerMods:AddToggle("walkspeedtoggle", {
        Title = "Use Walkspeed",
        Description = "Whether or not to use the custom walk speed.",
        Callback = function()
            walkspeeding = value
        end
    })
    
    PlayerMods:AddSlider("walkspeed", {
        Title = "Walkspeed",
        Description = "Changes your walkspeed",
        Default = 16,
        Min = 16,
        Max = 300,
        Rounding = 1,
        Callback = function(Value)
            walkspeed = Value
        end
    })

    RunService.Heartbeat:Connect(function()
        if walkspeeding == true then
            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
            end
        end
        task.wait(0.5)
    end)

    PlayerMods:AddButton({
            Title = "God Mode",
            Description = "Sets your health to math.huge",
            Callback = function()
                Window:Dialog({
                        Title = "Warning",
                        Content = "God Mode is very unstable and requires a rejoin to turn off, do you want to proceed?",
                        Buttons = {
                            {
                                Title = "Proceed",
                                Callback = function()
                                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:WaitFirstChild("Humanoid") then
                                        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                                        task.wait()
                                        game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
                                    end
                                end
                            },
                            {
                                Title = "Cancel",
                                Callback = function()
                                    warn("Cancelled God Mode!")
                                end
                            }
                        }
                    })
            end
    })

    local infJump = false

    PlayerMods:AddToggle("InfJump", {
            Title = "Infinite Jump",
            Description = "Lets you jump in the air.",
            Callback = function(Value)
                infJump = Value
            end
    })

    UserInputService.JumpRequest:Connect(function()
        if infJump then
            humanoid.Jump = true
        end
    end)]]
    
    Tabs.Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

    local UISection = Tabs.Settings:AddSection("UI")

    UISection:AddDropdown("Theme", {
        Title = "Theme",
        Description = "Changes the UI Theme",
        Values = Fluent.Themes,
        Default = Fluent.Theme,
        Callback = function(Value)
            Fluent:SetTheme(Value)
            UISettings.Theme = Value
            InterfaceManager:ExportSettings()
        end
    })

    if Fluent.UseAcrylic then
        UISection:AddToggle("Acrylic", {
            Title = "Acrylic",
            Description = "Blurred Background requires Graphic Quality >= 8",
            Default = Fluent.Acrylic,
            Callback = function(Value)
                if not Value or not UISettings.ShowWarnings then
                    Fluent:ToggleAcrylic(Value)
                elseif UISettings.ShowWarnings then
                    Window:Dialog({
                        Title = "Warning",
                        Content = "This Option can be detected! Activate it anyway?",
                        Buttons = {
                            {
                                Title = "Confirm",
                                Callback = function()
                                    Fluent:ToggleAcrylic(Value)
                                end
                            },
                            {
                                Title = "Cancel",
                                Callback = function()
                                    Fluent.Options.Acrylic:SetValue(false)
                                end
                            }
                        }
                    })
                end
            end
        })
    end

    UISection:AddToggle("Transparency", {
        Title = "Transparency",
        Description = "Makes the UI Transparent",
        Default = UISettings.Transparency,
        Callback = function(Value)
            Fluent:ToggleTransparency(Value)
            UISettings.Transparency = Value
            InterfaceManager:ExportSettings()
        end
    })

    if IsComputer then
        UISection:AddKeybind("MinimizeKey", {
            Title = "Minimize Key",
            Description = "Changes the Minimize Key",
            Default = Fluent.MinimizeKey,
            ChangedCallback = function(Value)
                UISettings.MinimizeKey = pcall(UserInputService.GetStringForKeyCode, UserInputService, Value) and UserInputService:GetStringForKeyCode(Value) or "RMB"
                InterfaceManager:ExportSettings()
            end
        })
        Fluent.MinimizeKeybind = Fluent.Options.MinimizeKey
    end
end

warn("----------------------------------------------------|")
warn("Loaded The R.S.S. Cheater 2 V" .. Version .. "!")
warn("----------------------------------------------------|")
