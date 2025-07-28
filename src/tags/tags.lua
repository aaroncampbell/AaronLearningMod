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
			grandprize = 10000,
			secondprize = 5000
		}
	} },
	set_lock = function ( self, lock )

		G.ADC.processing_gashapon_tag = self -- This is a broader lock that is used to prevent tags processing in parallel
		G.CONTROLLER.locks[lock] = true
	end,
	clear_lock = function ( self, lock, trigger_next )
		if ( lock ) then
			-- Clear individual lock
			G.CONTROLLER.locks[lock] = nil
		end
		-- If we want to trigger more
		if ( trigger_next ) then
			G.ADC.processing_gashapon_tag = nil
			-- If there is still a pending gashapon tag, then process again using a custom context so we don't accidentally trigger something else
			if ( next( Aaron.find_tag( 'tag_adc_gashapon' ) ) ) then
				local i, _ = next( G.GAME.tags )
				G.GAME.tags[i]:apply_to_run({type = 'gashapon_tag'})
			end
		end
	end,
	in_pool = function()
		return (next( find_joker( "j_adc_gashapon" ) ))
	end,
	loc_vars = function(self, info_queue, tag)
	end,
	apply = function(self, tag, context)
		local logger = adc_get_logger()
		if ( context.type == 'shop_start' or context.type == 'gashapon_tag' ) and not G.ADC.processing_gashapon_tag then

			local lock = tag.ID
			self:set_lock( lock )

			tag:yep('+', G.C.ADC.PLUM, function()

				local odds = {}
				odds.negative = pseudorandom( 'adc_negative' ) < G.GAME.probabilities.normal / tag.config.extra.odds.negative
				odds.polychrome = pseudorandom( 'adc_polychrome' ) < G.GAME.probabilities.normal / tag.config.extra.odds.polychrome
				odds.holo = pseudorandom( 'adc_holo' ) < G.GAME.probabilities.normal / tag.config.extra.odds.holo
				odds.foil = pseudorandom( 'adc_foil' ) < G.GAME.probabilities.normal / tag.config.extra.odds.foil
				odds.grandprize = pseudorandom( 'adc_grandprize' ) < G.GAME.probabilities.normal / tag.config.extra.odds.grandprize
				odds.secondprize = pseudorandom( 'adc_secondprize' ) < G.GAME.probabilities.normal / tag.config.extra.odds.secondprize
				-- logger.log( odds )

				local voucher = SMODS.add_card( { set = 'Voucher', area = G.play })
				voucher.cost = 0
				voucher:redeem()
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						voucher:start_dissolve()
						self:clear_lock( lock, true )
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
