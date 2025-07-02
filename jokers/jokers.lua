SMODS.Atlas({
    key = "mult_chips",
    path = "j_mult_chips.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "mult_chips",                                         --name used by the joker.
    config = { extra = { chip_mult = 2, chip_mult_mod = 1 } },  --variables used for abilities and effects.
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
			card.ability.extra.chip_mult = card.ability.extra.chip_mult + card.ability.extra.chip_mult_mod -- Increase chip multiplier by chip_mult_mod
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