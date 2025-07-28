SMODS.Atlas({
	key = "tags",
	path = "tags.png",
	px = 34,
	py = 34
})


-- Gashapon Tag
SMODS.Tag {
	key = "gashapon",
	atlas = 'tags',
	min_ante = 999,
	discovered = true,
	pos = { x = 0, y = 0 },
	config = { extra = {
		-- Default odds - these are overwritten if created by the Gashapon Joker itself
		odds = {
			negative = 100,
			polychrome = 50,
			holo = 10,
			foil = 5,
			packs = 10,
			grandprize = 10000,
			secondprize = 5000
		}
	} },
	set_lock = function ( self, lock )
		-- Store all locks in a parent 'gashapon-tag' so we can check for "any pending gashapon" while maintaining individual locks
		if ( not G.CONTROLLER.locks['gashapon-tag'] ) then
			G.CONTROLLER.locks['gashapon-tag'] = {}
		end
		G.CONTROLLER.locks['gashapon-tag'][lock] = true
	end,
	clear_lock = function ( self, lock )
		-- Clear individual lock
		G.CONTROLLER.locks['gashapon-tag'][lock] = nil
		-- If no gashapon tag locks exist
		if ( next( G.CONTROLLER.locks['gashapon-tag'] ) == nil ) then
			-- Clear parent lock completely
			G.CONTROLLER.locks['gashapon-tag'] = nil
			-- If there is still a pending gashapon tag, then process again using a custom context so we don't accidentally trigger something else
			if ( next( self.find_tag( 'tag_adc_gashapon' ) ) ) then
				local i, _ = next( G.GAME.tags )
				G.GAME.tags[i]:apply_to_run({type = 'gashapon_tag'})
			end
		end
	end,
	find_tag = function ( name )
		local tags = {}
		if not G.GAME.tags then return {} end
		for k, v in pairs( G.GAME.tags ) do
			if v and type(v) == 'table' and v.key == name then
			table.insert(tags, v)
			end
		end
		return tags
	end,
	in_pool = function()
		return (next( find_joker( "j_adc_gashapon" ) ))
	end,
	loc_vars = function(self, info_queue, tag)
	end,
	apply = function(self, tag, context)
		if ( context.type == 'shop_start' or context.type == 'gashapon_tag' ) and not G.CONTROLLER.locks['gashapon-tag'] then
			local lock = tag.ID
			self:set_lock( lock )

			tag:yep('+', G.C.ADC.PLUM, function()
				local voucher = SMODS.add_card( { set = 'Voucher', area = G.play })
				voucher.cost = 0
				voucher:redeem()
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						voucher:start_dissolve()
						self:clear_lock( lock )
						return true
					end,
				}))

				return true
			end)
			tag.triggered = true
			return true
		end
	end
}
