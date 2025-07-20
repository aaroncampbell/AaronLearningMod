return {
    descriptions = {
        Joker = {
            j_adc_mult_chips = {
                name = "Mult Chips",
                text = {
                    "This Joker's multiplier scales",
                    "by {X:chips,C:white}×#2#{} if played",
                    "{C:attention}poker hand{} has already",
                    "been played twice this round",
                    "{C:inactive}(Currently {X:chips,C:white}×#1#{C:inactive} Chips)",
                },
            },
            j_adc_cheat = {
                name = "Cheat",
                text = {
                    "This Joker gives",
                    "{X:blue,C:white}+#1#{} Joker"
                },
            },
            j_adc_roulette = {
                name = "Roulette",
                text = {
                    "Bets (lose) $1 per card played.",
                    "Earn {C:money}$#1#{} per dollar bet",
                    "for each scored {C:attention}#2#{}.",
                    "Spins to change rank every round"
                },
            }
        }
    },
    misc = {

            -- do note that when using messages such as:
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.


        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
            adc_roulette_bet="Bet $1!",
        }
    }
}