return {
    descriptions = {
        Joker = {
            j_adc_mult_chips = {
                name = "Mult Chips",
                text = {
                    "This Joker gains",
                    "{X:chips,C:white}×#2#{} Chips if played",
                    "{C:attention}poker hand{} has already",
                    "been played twice this round",
                    "{C:inactive}(Currently {X:chips,C:white}×#1#{C:inactive} Chips)",
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
        }
    }
}