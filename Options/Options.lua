local _, BasicAddon = ...

local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local error, select, pairs = error, select, pairs
local WoWWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)

local getFunc, setFunc
do
	function getFunc(info)
		return (info.arg and BasicAddon.db.profile[info.arg] or BasicAddon.db.profile[info[#info]])
	end

	function setFunc(info, value)
		local key = info.arg or info[#info]
		BasicAddon.db.profile[key] = value
	end
end

local function generateOptions()
	BasicAddon.options = {
		type = "group",
		name = "BasicAddon",
		childGroups = "tree",
		args = {
			lock = {
				order = 1,
				type = "toggle",
				name = "Toggle",
				desc = "Example of a Toggle",
				get = function() BasicAddon:Print("Toggle GET") end,
				set = function(info, value) BasicAddon:Print("Toggle SET") end,
				width = "half",
			},
			kb = {
				order = 2,
				type = "execute",
				name = "Execute",
				desc = "Example of an Execute",
				func = function() BasicAddon:Print("EXECUTE") end,
			},
			bars = {
				order = 20,
				type = "group",
				name = "Options",
				args = {
					options = {
						type = "group",
						order = 0,
						name = function(info) if info.uiType == "dialog" then return "" else return "Test Options" end end,
						guiInline = true,
						args = {
							exampletoggleoption1 = {
								order = 1,
								type = "toggle",
								name = "TOGGLE CLAP",
								desc = "OPTION 1",
								width = "full",
								get = BasicAddon:Print("OPTIONS TOGGLE GET"),
								set = function(info, value) BasicAddon:Print("OPTIONS SET") end,
							},
							exampledropdownoption1 = {
								order = 2,
								type = "select",
								name = "CLAPS CLAPS CLAPS !",
								desc = "wow that is a lot of CLAPs",
								get = function(info) BasicAddon:Print("EXAMPLE DROP DOWN GET") end,
								set = function(info, value) BasicAddon:Print("EXAMPLE DROP DOWN SET") end,
								values = { OP1 = "Option1", OP2 = "Option2", OP3 = "Option3", OP4 = "Option4" },
							},
						},
					},
				},
			},
			faq = {
				name = "FAQ",
				desc = "Frequently Asked Questions",
				type = "group",
				order = 1000,
				args = {
					line1 = {
						type = "description",
						name = "|cffffd200" .. "CLAPS CLAPS CLAPS CLAPS CLAPS CLAPS CLAPS CLAPS " .. "|r",
						order = 1,
					},
				},
			},
		},
	}
	--BasicAddon.options.plugins.profiles = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(BasicAddon.db) }
	for k,v in BasicAddon:IterateModules() do
		if v.SetupOptions then
			v:SetupOptions()
		end
	end
end

function BasicAddon:ChatCmd(input)
	if not input or input:trim() == "" then
		LibStub("AceConfigDialog-3.0"):Open("BasicAddon")
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(BasicAddon, "ba", "basicaddon", input)
	end
end

local function getOptions()
	if not BasicAddon.options then
		generateOptions()
		-- let the generation function be GCed
		generateOptions = nil
	end
	return BasicAddon.options
end

function BasicAddon:SetupOptions()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("BasicAddon", getOptions)
	AceConfigDialog:SetDefaultSize("BasicAddon", 400, 350)
	self:RegisterChatCommand( "ba", "ChatCmd")
	self:RegisterChatCommand( "basicaddon", "ChatCmd")
end