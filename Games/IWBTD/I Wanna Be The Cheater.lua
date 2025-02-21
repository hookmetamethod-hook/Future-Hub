warn("LOADING")
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
warn("fluent loaded")

local UISettings = {
    TabWidth = 160,
    Size = { 680, 560 },
    Theme = "Darker",
    Acrylic = false,
    Transparency = true,
    MinimizeKey = "RightShift",
    ShowNotifications = true,
    ShowWarnings = true,
    RenderingMode = "RenderStepped",
    AutoImport = true
}

local Window = Fluent:CreateWindow({
    Title = "I Wanna Be The Cheater",
    SubTitle = "[I Wanna Be The Developer Cheat GUI by S_B]",
    TabWidth = UISettings.TabWidth,
    Size = UDim2.fromOffset(table.unpack(UISettings.Size)),
    Theme = UISettings.Theme,
    Acrylic = UISettings.Acrylic,
    MinimizeKey = UISettings.MinimizeKey
})

local function Notify(text)
    Fluent.Notification("Notification", text)
end

Notify("hi")

local Tabs = { TP = Window:AddTab({Title = "Teleporting", Icon = "waypoint"}) }

Window:SelectTab(1)

Tabs.TP:AddParagraph("To prevent detection and bans, save at every stage in order!")

plrStage = 0

function getStage()
    plrStage = game.Players.LocalPlayer.Checkpoint.Value
end

function toStage(stageNumber)
    if stageNumber == 1 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(-56.25, 18, 124.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    elseif stageNumber == 2 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(-48.25, 18, 224.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    elseif stageNumber == 3 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(6.375, 52, 353.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 4 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(153.375, 53, 353.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 5 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(250.375, 53, 353.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 6 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(325.375, 54, 353.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 7 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(425.375, 68, 353.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 8 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(509.375, 68, 359.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 9 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(499.375, 68, 209.125, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    elseif stageNumber == 10 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(458.25, 68, 153.25, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    elseif stageNumber == 11 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(458.25, 68, 88.25, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    elseif stageNumber == 12 then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(458.5, 68, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    end
end

Fluent.Button(Tabs.TP, {
    Text = "Skip Stage",
    OnClick = function()
        Notify("Teleporting to the next stage!")
        getStage()
        if plrStage < 1 then
            toStage(1)
        elseif plrStage == 1 then
            toStage(2)
        elseif plrStage == 2 then
            toStage(3)
        elseif plrStage == 3 then
            toStage(4)
        elseif plrStage == 4 then
            toStage(5)
        elseif plrStage == 5 then
            toStage(6)
        elseif plrStage == 6 then
            toStage(7)
        elseif plrStage == 7 then
            toStage(8)
        elseif plrStage == 8 then
            toStage(9)
        elseif plrStage == 9 then
            toStage(10)
        elseif plrStage == 10 then
            toStage(11)
        elseif plrStage == 11 then
            toStage(12)
        end
    end
})
