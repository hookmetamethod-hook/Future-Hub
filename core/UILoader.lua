if not _G.Library then
    if _G.FHdebug then print("Library not loaded") end
    _G.Library = {}
    _G.Library.Main = loadstring(game:HttpGet("wip"))
    _G.Library.Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/NotificationLib.lua"))
    _G.Library.Logger = loadstring(game:HttpGet("https://raw.githubusercontent.com/hookmetamethod-hook/Future-Hub/refs/heads/main/core/Logger.lua"))
    if _G.FHdebug then print("Loaded library") end
end
