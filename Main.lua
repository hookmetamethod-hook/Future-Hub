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
wait(1)
local Init = library:Init()


local newTab = {}

local function createHaxTab(i, name, desc)
    newTab[i] = Init:NewTab(name)
    local newSection = newTab[i]:NewSection(desc)
    return newTab
end



local Tab1 = Init:NewTab("Example tab")
local Section1 = Tab1:NewSection("Inject hax ")



local haxTab1 = Init:NewTab("hax tab 1")
local haxSect1 = haxTab1:NewSection("epik hax yes yes")


haxTab1:Hide()

local buttons = { Button = {} }

buttons.Button[1] = Tab1:NewButton("inject numbuh 1 hax", function()
    haxTab1:Show()
    wait(0.1)
    buttons.Button[1]:Remove()
end)

buttons.Button[2] = Tab1:NewButton("inject numbuh 2 hax", function()
    haxTab1:Show()
    wait(0.1)
    buttons.Button[2]:Remove()
end)



local FinishedLoading = Notif.Notify("success", "Loaded Future Hub", 4)
