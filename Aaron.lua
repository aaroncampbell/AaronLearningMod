-- watch lua /Mods/Aaron/localization/en-us.lua
-- watch lua /Mods/Aaron/jokers/jokers.lua
Aaron = {}

assert(SMODS.load_file("globals.lua"))()

-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end

-- Tags
local tag_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "tags")
for _, file in ipairs(tag_src) do
    assert(SMODS.load_file("tags/" .. file))()
end

-- Backs
local backs_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "backs")
for _, file in ipairs(backs_src) do
    assert(SMODS.load_file("backs/" .. file))()
end