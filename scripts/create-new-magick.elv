var runes = (from-json < runes.json)

peach {|h|
    makesigil ~/.$h[name] > ~/.$h[name].pub
} $runes
