var runes = (from-json < runes.json)

peach {|h|
    chmod 600 ~/.$h[name]
    hexon ~/.$h[name] ~/.$h[name].hex
    chmod 600 ~/.$h[name].hex
    daggeron (cat ~/.$h[name].hex) > ~/.$h[name]_int
    chmod 600 ~/.$h[name]_int
    review ~/.$h[name]_int > ~/.$h[name]_review_(date +%Y%m%d%H%M%S).json
} $runes
