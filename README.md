# elvish-pathway 🧙‍♂️

This repository contains scripts, dot files, and config files for [mezterm](https://wezfurlong.or) and [elvish](https://elv.sh/).

Mezterm is written in Rust and elvish is written in Go.
Mezterm is a terminal emulator, such as to run on your workstation.
Elvish is a shell, such as to use instead of BASH, that also is a unique language for scripting.


The elvish prompt here expects `uidgen` from [dwarven toolbox](https://github.com/jpegleg/dwarven-toolbox) for use in the prompt, creating a UUIDv4 for each shell session.
This can be subsituded for something else by replacing "uidgen" in `rc.elv`. But the dwarven toolbox and elvish shell are very nice together.


To bootstrap the whole setup on a debian based system, including installing mezterm and elvish and using the configurations (requires sudo):

```
$ sh pathway.sh $(whoami)
```
