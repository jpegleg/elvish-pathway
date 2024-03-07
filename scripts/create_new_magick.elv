use path
var runes = (from-json < runes.json)

peach {|h|
    if (path:is-regular ~/$h[name]) {
        tar czvf ~/.runes__$h[name]_(date +%Y%m%d%H%M%S).tgz ~/.$h[name] ~/.$h[name].pub
        mv ~/.$h[name] ~/.$h[name]_last_(date +%Y%m%d%H%M%S)
    }
    makesigil ~/.$h[name] > ~/.$h[name].pub
    chown (whoami):(whoami) ~/.$h[name] ~/.$h[name].pub
    chmod 600 ~/.$h[name]
    chmod 644 ~/.$h[name].pub
} $runes
