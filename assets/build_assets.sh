# 2x assets
mkdir -p export/2x
mogrify -resize 142x190 -path export/2x/ export/cards_*
convert "export/2x/cards_Joker - Roulette 1.png" "export/2x/cards_Joker - Roulette 2.png" +append export/2x/jokers1.png
convert "export/2x/cards_Joker - Cheat.png" "export/2x/cards_Joker - Chip Mult.png" "export/2x/cards_Joker - Gashapon.png" +append export/2x/jokers2.png
convert export/2x/jokers1.png export/2x/jokers2.png -background transparent -append 2x/jokers.png
cp "export/2x/cards_Back - Eternal Kings.png" 2x/backs.png
mogrify -resize 68x68 -path export/2x/ export/tags_*
cp "export/2x/tags_gashapon.png" 2x/tags.png

# 1x assets
mkdir -p export/1x
mogrify -resize 141x190 -path export/1x/ export/cards_*
convert "export/1x/cards_Joker - Roulette 1.png" "export/1x/cards_Joker - Roulette 2.png" +append export/1x/jokers1.png
convert "export/1x/cards_Joker - Cheat.png" "export/1x/cards_Joker - Chip Mult.png" "export/1x/cards_Joker - Gashapon.png" +append export/1x/jokers2.png
convert export/1x/jokers1.png export/1x/jokers2.png -background transparent -append 1x/jokers.png
cp "export/1x/cards_Back - Eternal Kings.png" 1x/backs.png
mogrify -resize 34x34 -path export/1x/ export/tags_*
cp "export/1x/tags_gashapon.png" 1x/tags.png