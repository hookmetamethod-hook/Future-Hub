loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/UILoader.lua"))()

if _G.Library.Main:GetUsername() == "reshapedd" or "hookmetamethod_hook" then
    _G.Library.rank = "Developer"
end

local Wm = _G.Library.Main:Watermark("Future Hub | V1.1 | Rank: ".. _G.Library.rank)

local notifs = _G.Library.Notifications
local Notif = {}
Notif.Notify = function(typee, text, duration)
    notifs.new(typee, "Notification", text, true, duration)
end

task.wait(0.05)
local LoadingXSX = Notif.Notify("info", "Loading Future Hub, please be patient.", 3)

_G.Library.Main.title = "Future Hub"

_G.Library.Main:Introduction()
wait(1)
local Init = _G.Library.Main:Init()


local newTab = {}



local Tab1 = Init:NewTab("Example tab")
local Section1 = Tab1:NewSection("Inject hax ")



local haxTab1 = Init:NewTab("Adonis")
local haxSect1 = haxTab1:NewSection("Adonis Speed Bypass")

local haxTab2 = Init:NewTab("more hax")
local haxSect2 = haxTab2:NewSection("even more epik hax yes yes")


haxTab1:Hide()
haxTab2:Hide()

local buttons = { Button = {} }

buttons.Button[1] = Tab1:NewButton("Inject Adonis Bypasser", function()
    haxTab1:Show()
    wait(0.1)
    buttons.Button[1]:Remove()
    wait(2)
    local adonis = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/Adonis%20Speed%20Bypass.lua"))()
end)

buttons.Button[2] = Tab1:NewButton("inject numbuh 2 hax", function()
    haxTab2:Show()
    wait(0.1)
    buttons.Button[2]:Remove()
end)



local adonisToggle = haxTab1:NewToggle("Toggle Adonis Speed Bypass", false, function(value)
    if value == true then
        _G.SpeedEnabled = true
    else
        _G.SpeedEnabled = false
    end
end)

local adonisSlider = haxTab1:NewSlider("Speed Mulitplier", "", true, "/", {min = 1, max = 10, default = 1}, function(value)
    _G.SpeedMultiplier = value
    print(adonis.SpeedMultiplier)
end)
    


local FinishedLoading = Notif.Notify("success", "Loaded Future Hub", 4)
