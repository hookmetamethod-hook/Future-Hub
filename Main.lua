local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/UIMain.lua"))()
local notifs = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/NotificationLib.lua"))()
local Wm = library:Watermark("Future Hub | V1.1")
local Notif = {}

Notif.Notify = function(typee, text, duration)
    notifs.new(typee, "Notification", text, true, duration)
end

task.wait(0.05)
local LoadingXSX = Notif.Notify("info", "Loading Future Hub, please be patient.", 3)
library.title = "Future Hub"
library:Introduction()
task.wait(1)

local Init = library:Init()

local function createHaxTab(name, desc)
    local newTab = Init:NewTab(name)
    local newSection = newTab:NewSection(desc)
    return newTab, newSection
end

local Tab1 = Init:NewTab("Example tab")
local Section1 = Tab1:NewSection("Inject hax")

local haxTabs = {
    {name = "hax one", description = "Inject hax numbuh one"},
    {name = "hax two", description = "Inject hax numbuh two"},
}

local buttons = {}

for i, hax in ipairs(haxTabs) do
    buttons[i] = Tab1:NewButton(hax.description, function()
        local newTab, newSection = createHaxTab(hax.name, hax.description)
        task.wait(0.1)
        buttons[i]:Remove()
    end)
end

local FinishedLoading = Notif.Notify("success", "Loaded Future Hub", 4)
