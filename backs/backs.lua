SMODS.Atlas({
	key = "PowerKings",
	path = "b_steel_redseal_etenal_king_hearts.png",
	px = 71,
	py = 95
})

-- Power Kings Deck
SMODS.Back {
    key = "PowerKings",
    atlas = "PowerKings",
    name = "PowerKings",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = {hand_size = 50},
    apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.playing_cards) do
					v:set_base( G.P_CARDS['H_K'] )
					v:set_edition( { polychrome = true }, true, true )
					v:set_seal( 'Red', true, true )
					v:set_ability( 'm_steel', true, true )
					SMODS.Stickers['eternal']:apply(v, true)
				end

                return true
            end
        }))
    end,
}
