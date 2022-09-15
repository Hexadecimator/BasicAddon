--[[
    A basic template for quickly spinning up a new addon
]]
local _, BasicAddon = ...
BasicAddon = LibStub("AceAddon-3.0"):NewAddon(BasicAddon, "BasicAddon", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

_G.BasicAddon = BasicAddon -- "_G" is essentially the greater environment all AddOns exist within

local _G = _G
local type, pairs, hooksecurefunc = type, pairs, hooksecurefunc

local WoWWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)

local defaults = {
    profile = {
        teststring = "testoption1",
        testboolean = false,
        testnumber = 69
    }
}

BasicAddon.CONFIG_VERSION = 1

-- Code that you want to run when the addon is first loaded goes here. (Actual Blizzard functionality)
function BasicAddon:OnInitialize() 
    self.db = LibStub("AceDB-3.0"):New("BasicAddonDB", defaults) -- load defaults

    self:SetupOptions() -- initialize and register the options menu

    BasicAddon:Print("Initialized BasicAddon") -- Print is from AceConsole
end

--[[ 
    you don't have to use these unless you need them (at least it seems so)
    --> the OnDisable() could be useful to save profile options or things last minute

-- Called when the addon is enabled (Ace library level function)
function BasicAddon:OnEnable()
    --BasicAddon:Print("Enabling BasicAddon") -- also prints in the OnInitialize() function
end

-- Called when the addon is disabled (Ace library level function)
function BasicAddon:OnDisable()
end

]]

