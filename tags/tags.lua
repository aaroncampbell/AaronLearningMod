SMODS.Atlas({
	key = "tags",
	path = "tags.png",
	px = 34,
	py = 34
})


-- Negative Tag
SMODS.Tag {
	key = "gashapon",
	atlas = 'tags',
	min_ante = 999,
	-- unlocked = true,
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
	in_pool = function()
		return (next( find_joker( "j_adc_gashapon" ) ))
	end,
	loc_vars = function(self, info_queue, tag)
	end,
	apply = function(self, tag, context)
		if context.type == 'shop_start' and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ADC.PLUM, function()
				local booster = SMODS.add_card( { set = 'Booster', area = G.play })
				booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
				booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
				booster.T.w = G.CARD_W * 1.27
				booster.T.h = G.CARD_H * 1.27
				booster.cost = 0
				booster.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = booster } })
				booster:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}
