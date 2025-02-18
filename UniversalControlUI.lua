--[[
    The control UI is WIP
]]

if not _G.Library then _G.Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SB-Script/FutureLib/refs/heads/main/main.lua"))(); if not _G.UI_Library then _G.UI_Library = _G.Library.UI.Fluent end end
repeat task.wait(0.1) until _G.UI_Library ~= nil
local function Notify(Message, SubMessage) if _G.UI_Library and typeof(Message) == "string" and typeof(SubMessage) == "string" then _G.UI_Library:Notify({Title = "Notification", Content = Message, SubContent = SubMessage, Duration = 6}) end end

Notify("The control UI is WIP", "Future Hub | Control UI")
