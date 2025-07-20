SMODS.Atlas({
	key = "cheat",
	path = "j_cheat.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "mult_chips",
	path = "j_mult_chips.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "roulette",
	path = "j_roulette.png",
	px = 71,
	py = 95
})

SMODS.Joker{
	key = "cheat",                                   --name used by the joker.
	config = { extra = { bonus_joker_slots = 2 } },  --variables used for abilities and effects.
	pos = { x = 0, y = 0 },                          --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
	rarity = 1,                                      --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
	cost = 1,                                        --cost to buy the joker in shops.
	blueprint_compat=false,                          --does joker work with blueprint.
	eternal_compat=true,                             --can joker be eternal.
	unlocked = true,                                 --is joker unlocked by default.
	discovered = true,                               --is joker discovered by default.
	-- effect=nil,                                      --you can specify an effect here eg. 'Mult'
	-- soul_pos=nil,                                    --pos of a soul sprite.
	atlas = 'cheat',                                 -- atlas name, single sprites are deprecated.

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.bonus_joker_slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.bonus_joker_slots
	end,

	loc_vars = function(self, info_queue, card)                              --defines variables to use in the UI. you can use #1# for example to show the chips variable
    	return { vars = { card.ability.extra.bonus_joker_slots } }
	end

}

SMODS.Joker{
	key = "mult_chips",                                         --name used by the joker.
	config = { extra = { chip_mult = 3, chip_mult_mod = 1.5 } },--variables used for abilities and effects.
	pos = { x = 0, y = 0 },                                     --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
	rarity = 1,                                                 --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
	cost = 1,                                                   --cost to buy the joker in shops.
	blueprint_compat=true,                                      --does joker work with blueprint.
	eternal_compat=true,                                        --can joker be eternal.
	unlocked = true,                                            --is joker unlocked by default.
	discovered = true,                                          --is joker discovered by default.
	-- effect=nil,                                                 --you can specify an effect here eg. 'Mult'
	-- soul_pos=nil,                                               --pos of a soul sprite.
	atlas = 'mult_chips',                                       -- atlas name, single sprites are deprecated.


	calculate = function(self, card, context)                   --define calculate functions here
    	if card.debuff then return nil end               --if joker is debuffed return nil

		if context.before and context.main_eval and not context.blueprint and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 2 then
			card.ability.extra.chip_mult = card.ability.extra.chip_mult * card.ability.extra.chip_mult_mod -- Multiply chip multiplier by chip_mult_mod
        	return {
            	message = localize('k_upgrade_ex'),
            	colour = G.C.CHIPS
        	}
    	end

    	if context.joker_main and context.cardarea == G.jokers then
        	return { -- returns total chips from joker to be used in scoring, no need to show message in joker_main phase, game does it for us.
            	chips = hand_chips * ( card.ability.extra.chip_mult - 1 ), -- This is number of chips to ADD to chips, so we multiply by mult - 1
            	colour = G.C.CHIPS
        	}
    	end
	end,

	loc_vars = function(self, info_queue, card)                              --defines variables to use in the UI. you can use #1# for example to show the chips variable
    	return { vars = { card.ability.extra.chip_mult, card.ability.extra.chip_mult_mod } }
	end

}
-- eval G.jokers.cards[1].children.center:set_sprite_pos({x = 1, y=0})

SMODS.Joker{
	key = "roulette",
	blueprint_compat=true,
	eternal_compat=true,
	unlocked = true,
	discovered = true,
	rarity = 1,
	atlas = 'roulette',
	cost = 1,
	pos = { x = 0, y = 0 }, -- For alternate colors use: { x = 1, y = 0 }
	config = { extra = { current_card='2', return_on_bet='5', animated=nil } },  --variables used for abilities and effects.

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(40)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-40)
    end,
	calculate = function(self, card, context)
    	if card.debuff then return nil end
		if context.before then

			for i = 1, #G.play.cards do
				G.E_MANAGER:add_event(Event({
					func = function()
						G.play.cards[i]:juice_up()
						SMODS.calculate_effect({message = localize( 'adc_roulette_bet' ), instant = true}, G.play.cards[i])
						return true
					end,
				}))
				ease_dollars(-1)
				delay(0.23)
			end

			-- Animate card
			card.ability.extra.animated = true

			-- Build a table of all ranks existing in the deck
			local valid_card_ranks = {}
			for _, playing_card in ipairs(G.playing_cards) do
				if not SMODS.has_no_rank(playing_card) then
					valid_card_ranks[playing_card.base.value] = playing_card
				end
			end

			-- Choose a random rank from the ones existing in the current deck
			local chosen_card = pseudorandom_element(valid_card_ranks, pseudoseed('adc_roulette'))
			card.ability.extra.current_card = chosen_card.base

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 2,
				func = function()
					card.ability.extra.animated = false
					SMODS.calculate_effect({message = card.ability.extra.current_card.value .. "!", instant = true}, card)
					return true
				end,
			}))
		end
		card.ability.extra.dollars = 0
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == card.ability.extra.current_card.id then
			card.ability.extra.dollars = #context.full_hand * card.ability.extra.return_on_bet
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
			return {
				dollars = card.ability.extra.dollars
			}
		end

	end,

	update = function(self, card, context)
		if not card.ability.extra.animated then return end
		local timer = (G.TIMERS.REAL * 10)
		local frame = math.floor(timer) % 2
		card.children.center:set_sprite_pos({x = frame, y = 0})
	end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.return_on_bet, card.ability.extra.current_card.value } }
	end

}