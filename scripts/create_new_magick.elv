use path
var runes = (from-json < runes.json)

peach {|h|
    if (path:is-regular ~/.$h[name]) {
        tar czvf ~/.runes__$h[name]_(date +%Y%m%d%H%M%S).tgz ~/.$h[name]
        mv ~/.$h[name] ~/.$h[name]_last_(date +%Y%m%d%H%M%S)
    }
    makesigil ~/.$h[name] > ~/.$h[name].key
    chown (whoami):(whoami) ~/.$h[name]
    chmod 600 ~/.$h[name]
} $runes
