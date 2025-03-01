loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/protectui.lua"))()
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/source.lua", true))()
local NotifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/NotificationLib.lua"))()

_G.SpeedToggleSet = false

_G.GetFHVersion = function(Type)
	if Type == "Full" then
		return "In-Dev V0.6.14"
	elseif Type == "Raw" then
		return {["Major"] = 0, ["Minor"] = 6, ["Patch"] = 13}
	end
end
local Version = _G.GetFHVersion("Full")
print("Future Hub | "..Version) 

_G.Notify = function(Type, Text, Duration)
	NotifLib.new(Type, "Future Hub", Text, true, Duration, nil)
end

local Window = Luna:CreateWindow({
	Name = "Future Hub | "..Version,
	Subtitle = "Made by Hookmetamethod_hook and Userbase",
	LogoID = 139542311686491,
	LoadingEnabled = true,
	LoadingTitle = "Future Hub",
	LoadingSubtitle = "Exploiting done right",

	ConfigSettings = {
		RootFolder = "Future Hub",
		ConfigFolder = "Configurations"
	},

	KeySystem = false,
	KeySettings = {
		Title = "Future Hub",
		Subtitle = "Key System",
		Note = "Enter your access key",
		SaveInRoot = true,
		SaveKey = true,
		Key = {"centigolden_|hnfjUIugi84fjn389GNN3489Ff", "Hookmetamethod_hook_|fjsdugDH83dcJN38gdjjfd", "userbase_|jfdguie9h34nHJNGnvn", "UNI_TrustedTester_|ujhnjG4nnmzGnmvjHFVNn453"},
		SecondAction = {
			Enabled = true,
			Type = "Discord",
			Parameter = "c7e5RVuvAR"
		}
	}
})

Window:CreateHomeTab({
	SupportedExecutors = {"Argon", "AWP", "Atlantis"},
	DiscordInvite = "c7e5RVuvAR",
	Icon = 2,
})


local ConfigTab = Window:CreateTab({
    Name = "Config",
    Icon = "build",
    ImageSource = "Material",
    ShowTitle = true
})

ConfigTab:BuildConfigSection()


local Bind = ConfigTab:CreateBind({
	Name = "Future Interface Bind",
	Description = "Bind to show/hide Future Hub",
	CurrentBind = "K", -- Check Roblox Studio Docs For KeyCode Names
	HoldToInteract = false, -- When true, Instead of toggling, You hold to achieve the active state of the Bind
    	Callback = function()
    	end,

	OnChangedCallback = function(Bind)
	 Window.Bind = Bind
	end,
}, "WindowMenuBind") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps



local Tab = Window:CreateTab({
	Name = "Test tab",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Tab:CreateSection("Test functions")
local Paragraph = Tab:CreateParagraph({
	Title = "This section contains test functions",
	Text = "(Logs in dev console [F9])"
})
Tab:CreateDivider()

local Button = Tab:CreateButton({
	Name = "Button",
	Description = "Test button", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            print("Future Hub | Test button pressed!")
    	end
})

local Toggle = Tab:CreateToggle({
	Name = "Toggle",
	Description = "Test toggle",
	CurrentValue = false,
    	Callback = function(Value)
       	    print("Future Hub | Test toggle switched! Value: "..tostring(Value))
    	end
}, "Toggle") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Slider = Tab:CreateSlider({
	Name = "Slider",
	Description = "Test slider",
	Range = {1, 10}, -- The Minimum And Maximum Values Respectively
	Increment = 0.25, -- Basically The Changing Value/Rounding Off
	CurrentValue = 1, -- The Starting Value
    	Callback = function(Value)
            print("Future Hub | Test slider changed! Value: "..tostring(Value))
    	end
}, "Slider") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Input = Tab:CreateInput({
	Name = "Textbox",
	Description = "Test textbox",
	PlaceholderText = "Placeholder",
	CurrentValue = "", -- the current text
	Numeric = false, -- When true, the user may only type numbers in the box (Example walkspeed)
	MaxCharacters = nil, -- if a number, the textbox length cannot exceed the number
	Enter = true, -- When true, the callback will only be executed when the user presses enter.
    Callback = function(Text)
   	    print("Future Hub | Test textbox modified! Text: "..tostring(Text))
    end
}, "Input") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local Dropdown = Tab:CreateDropdown({
	Name = "Dropdown",
    Description = "Test dropdown",
	Options = {"Option 1","Option 2"},
    CurrentOption = {"Option 1"},
    MultipleOptions = false,
    SpecialType = nil,
    Callback = function(Options)
        print("Future Hub | Test dropdown changed! Option: "..tostring(Options))
	end
}, "Dropdown") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps


local Label = Tab:CreateLabel({
	Text = "Label",
	Style = 1
})

local Label = Tab:CreateLabel({
	Text = "Information",
	Style = 2
})

local Label = Tab:CreateLabel({
	Text = "Warning",
	Style = 3
})

local ScriptInjection = Window:CreateTab({
	Name = "Script Injection",
	Icon = 78805791280641,
	ImageSource = "Custom",
	ShowTitle = true
})

ScriptInjection:CreateSection("Universal / Misc")
local Paragraph = ScriptInjection:CreateParagraph({
	Title = "Important!",
	Text = "These scripts are all made with the assumption the game uses the default Roblox logic, if character behavior is too heavily customized, certain character related scripts might not work properly, this counts for all other aspects of the game as well."
})
ScriptInjection:CreateDivider()

local CharacterManagerInjected = false
local InjectCharacterManagerButton = ScriptInjection:CreateButton({
	Name = "Character manager",
	Description = nil,
    Callback = function()
        if CharacterManagerInjected then return end
        CharacterManagerInjected = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/characterManager.lua"))()
        local CharManager = Window:CreateTab({
            Name = "Character Manager",
	        Icon = 125214730779893,
	        ImageSource = "Custom",
	        ShowTitle = false
        })
        CharManager:CreateParagraph({
            Title = "Character Manager",
            Text = "This script allows you to manage your character's properties"
        })
        CharManager:CreateDivider()
        local CharManagerWalkSpeedSlider = CharManager:CreateSlider({
	        Name = "Walk Speed",
	        Description = nil,
	        Range = {1, 999},
	        Increment = 0.1,
	        CurrentValue = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,
        	Callback = function(Value)
                local success, err = _G.changeProperty("WalkSpeed", Value)
        	end
        }, "CharManagerWalkSpeedSlider")
        local CharManagerWalkSpeedReset = CharManager:CreateButton({
            Name = "Reset Walk Speed",
	        Description = nil,
            Callback = function()
                local success, err = _G.changeProperty("WalkSpeed", 16)
                CharManagerWalkSpeedSlider:Set({
                    CurrentValue = 16
                })
            end
        })
        CharManager:CreateDivider()
		local JumpHeight = game.Players.LocalPlayer.Character.Humanoid.JumpHeight
        local CharManagerJumpPowerSlider = CharManager:CreateSlider({
	        Name = "Jump Power",
	        Description = nil,
	        Range = {1, 999},
	        Increment = 0.1,
	        CurrentValue = game.Players.LocalPlayer.Character.Humanoid.JumpPower,
        	Callback = function(Value)
            	_G.changeProperty("JumpPower", Value)
				JumpHeight = Value
        	end
        }, "CharManagerJumpPowerSlider")
        local CharManagerJumpPowerReset = CharManager:CreateButton({
            Name = "Reset Jump Power",
			Description = nil,
            Callback = function()
                _G.changeProperty("JumpPower", 50)
                CharManagerJumpPowerSlider:Set({
                    CurrentValue = 50
                })
				JumpHeight = 50
            end
        })
	
		local Player = game:GetService'Players'.LocalPlayer
		local UIS = game:GetService'UserInputService'
		local function Action(Object, Function) if Object ~= nil then Function(Object) end end
		local infjumpenabled = false
		UIS.InputBegan:connect(function(UserInput)
    		if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
        		Action(Player.Character.Humanoid, function(self)
            		if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
						if infjumpenabled == false then return end
            			Action(self.Parent.HumanoidRootPart, function(self)
              				self.Velocity = Vector3.new(0, 0, 0);
                    		self.Velocity = Vector3.new(0, JumpHeight + 2, 0);
                		end)
        	    	end
        		end)
    		end
		end)
		CharManager:CreateToggle({
			Name = "Air Jump",
	    	Description = "Allows you to jump in the air",
			CurrentValue = false,
        	Callback = function(Value)
           		infjumpenabled = Value
        	end
		}, "CharManagerAirJump")
        CharManager:CreateDivider()
		local CharManagerForceReset = CharManager:CreateButton({
        	Name = "Force reset",
	    	Description = "Attempts to reset normally, voids character if it fails",
        	Callback = function()
           		_G.changeProperty("Health", 0)
           		task.wait()
        	   	if game.Players.LocalPlayer.Character.Humanoid.Health >= 1 then
           	    	_G.changeProperty("CFrame", CFrame.new(math.huge, math.huge, math.huge))
           		end
        	end
        })
		CharManager:CreateDivider()
        local CharManagerUnload = CharManager:CreateButton({
            Name = "Unload character manager",
	    	Description = nil,
            Callback = function()
                _G.changeProperty = nil
                CharacterManagerInjected = false
				CharManager:Destroy()
            end
        })
    end
})

local SLJOExploitInjected = false
local InjectSLJOExploitButton = ScriptInjection:CreateButton({
	Name = "SLJOExploit",
	Description = "Game: Stud Long Jumps Obby - @JadonBarth",
	Callback = function()
        	if SLJOExploitInjected then return end
        	SLJOExploitInjected = true
        	loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/StudLongJumpObbyExploit.lua"))()
        	local SLJOExploit = Window:CreateTab({
        		Name = "Stud Long Jumps Obby",
	        	Icon = 125214730779893,
	        	ImageSource = "Custom",
	        	ShowTitle = false
        	})
        	SLJOExploit:CreateParagraph({
        		Title = "Stud Long Jumps Obby Exploit",
        		Text = "This script hijacks the buttons at the top of the screen to let you move between all the stages even if you didnt unlock them yet"
		})
        	SLJOExploit:CreateDivider()
		SLJOExploit:CreateToggle({
			Name = "Auto Rebirth",
			Description = "Automatically rebirth when stage 45 is reached",
			CurrentValue = false,
        		Callback = function(Value)
          			_G.AutoRebirth = Value
        		end
		}, "SLJOExploitAutoRebirth")
		SLJOExploit:CreateButton({
			Name = "Rebirth",
			Description = "Fires rebirth RE (bypasses the cooldown)",
			Callback = function()
				game.ReplicatedStorage.RebirthEvent:FireServer()
			end
		})
	end
})
AdonisInjected = false
local InjectAdonisSpeedButton = ScriptInjection:CreateButton({
    Name = "Adonis Speed Exploit",
    Description = "High Risk: Very Obvious",
    Callback = function()
        if AdonisInjected then return end
        AdonisInjected = true
        if _G.FH_ASB_Loaded ~= "Loaded" or "Loading" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/Adonis%20Speed%20Bypass.lua"))()
        end
        wait(1)
        _G.SpeedEnabled = false
        _G.SpeedMultiplier = 1
        local AdonisExploit = Window:CreateTab({
            Name = "Adonis",
            Icon = "directions_run",
            ImageSource = "Material",
            ShowTitle = false,
        })
        AdonisExploit:CreateParagraph({
            Title = "Adonis Speed Bypass Exploit",
            Text = "Allows you to bypass Adonis speedchecks and go as fast as you need"
        })
        AdonisExploit:CreateDivider()
        AdonisExploit:CreateToggle({
            Name = "Speed Toggle",
            Description = "Toggle Speed On or Off",
            CurrentValue = false,
            Callback = function(Value)
                _G.SpeedEnabled = Value
                print(_G.SpeedEnabled)
            end
        }, "AdonisSpeedToggle")
        AdonisExploit:CreateSlider({
            Name = "Slider",
	        Description = "Test slider",
	        Range = {1, 30}, -- The Minimum And Maximum Values Respectively
	        Increment = 0.5, -- Basically The Changing Value/Rounding Off
	        CurrentValue = 1, -- The Starting Value
    	    Callback = function(Value)
                if Value ~= 1 then
                    _G.SpeedMultiplier = Value / 3
                    print(_G.SpeedMultiplier)
                else
                    _G.SpeedMultiplier = 0.2
                    print(_G.SpeedMultiplier)
                end
    	    end
        }, "AdonisSpeedMultiplier")
    end
})


local DebugTab = Window:CreateTab({
	Name = "Debug Tools",
	Icon = "code",
	ImageSource = "Material",
	ShowTitle = true
})

local DebugParagraph = DebugTab:CreateParagraph({
	Title = "Game Debugging Tools",
    Text = "A bunch of nice to have game debugging tools and just essential scripts for normal use"
})

local DebugDisclamer = DebugTab:CreateLabel({
	Text = "All of these scripts are based on YOUR executor level, some may not work!",
	Style = 3
})
DebugTab:CreateDivider()


local IFYield = DebugTab:CreateButton({
	Name = "Infinite Yield",
	Description = "A multi use script that can do mostly anything you might need it to",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		print("IFYield Loaded!")
	end
})

local DarkDex = DebugTab:CreateButton({
	Name = "Dark Dex Explorer",
	Description = "A game file explorer working liek roblox studio to explroe the games assets and scripts",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AnimatedKurai/Scripts/refs/heads/main/Dex%20Explorer.txt"))()
		print("Dex Loaded!")
	end
})




Luna:LoadAutoloadConfig()
