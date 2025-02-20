--[[
    The control UI is WIP
]]
if _G.FHdebug then print("-=- FHdebug enabled -=-") end
if not _G.Library then if _G.FHdebug then print("no library") end; _G.Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/FutureLib/refs/heads/main/main.lua"))(); if _G.FHdebug then print("loaded library") end; if not _G.UI_Library then if _G.FHdebug then print("no ui library") end; _G.UI_Library = _G.Library.UI.Fluent; if _G.FHdebug then print("loaded ui library") end end end
repeat task.wait(0.1) until _G.UI_Library ~= nil
local function Notify(Message, SubMessage) if _G.UI_Library and typeof(Message) == "string" and typeof(SubMessage) == "string" then _G.UI_Library:Notify({Title = "Notification", Content = Message, SubContent = SubMessage, Duration = 6}) end end
if _G.FHdebug then print("set up Notify function") end

Notify("The control UI is WIP", "Future Hub | Control UI")
if _G.FHdebug then print("finished loading script") end
if -G.FHdebug then print("-=-=-=-=-=-=-=-=-=-=-=-") end
