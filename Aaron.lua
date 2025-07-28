-- watch lua /Mods/Aaron/localization/en-us.lua
-- watch lua /Mods/Aaron/jokers/jokers.lua
Aaron = {}

Aaron.config = SMODS.current_mod.config

assert(SMODS.load_file("src/utils.lua"))()
assert(SMODS.load_file("src/globals.lua"))()
assert(SMODS.load_file("src/general_ui.lua"))()

-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(joker_src) do
	sendInfoMessage("Loading " .. file, "Aaron")
	assert(SMODS.load_file("src/jokers/" .. file))()
end

-- Tags
local tag_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src/tags")
for _, file in ipairs(tag_src) do
	sendInfoMessage("Loading " .. file, "Aaron")
	assert(SMODS.load_file("src/tags/" .. file))()
end

-- Backs
local backs_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "src/backs")
for _, file in ipairs(backs_src) do
   	sendInfoMessage("Loading " .. file, "Aaron")
	assert(SMODS.load_file("src/backs/" .. file))()
end