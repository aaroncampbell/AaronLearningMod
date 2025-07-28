---Functions like find_joker for tags
---@param tag_key string
---@return table
Aaron.find_tag = function( tag_key )
	local tags = {}
	if not G.GAME.tags then return {} end
	for k, v in pairs( G.GAME.tags ) do
		if v and type(v) == 'table' and v.key == tag_key then
			table.insert(tags, v)
		end
	end
	return tags
end
