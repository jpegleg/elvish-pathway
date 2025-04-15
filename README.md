# elvish-pathway 🧙‍♂️

This repository contains scripts, dot files, and config files for [wezterm](https://wezfurlong.or) and [elvish](https://elv.sh/).

Wezterm is written in Rust and elvish is written in Go.
Wezterm is a terminal emulator, such as to run on your workstation.
Elvish is a shell, such as to use instead of BASH, that also is a unique language for scripting.


The elvish prompt here expects `uidgen` from [dwarven toolbox](https://github.com/jpegleg/dwarven-toolbox) for use in the prompt, creating a UUIDv4 for each shell session.
This can be subsituded for something else by replacing "uidgen" in `rc.elv`. But the dwarven toolbox and elvish shell are very nice together.


To bootstrap the whole setup on a debian based system, including installing wezterm and elvish and using the configurations (requires sudo):

```
$ sh pathway.sh $(whoami)
```

The functions in the elvish rc also expect dwarven-toolbox programs: `review`, and `chk`.
We also expect `kubectl` and `ls` programs. This operates much like an alias in bash,
except is a lambda function instead.

The command `k` then executes as `kubectl`, `l` as `ls -larth`, `f` as `review`, and `c` as `chk`.
See [kubectl](https://kubernetes.io/docs/tasks/tools/), [ls](https://linux.die.net/man/1/ls), and [dwarven toolbox](https://github.com/jpegleg/dwarven-toolbox)
for more information on those programs.

Here is an example of the rc.elv file, setting the prompt and creating the alias functions.

```
set edit:prompt = { styled ' λ ' yellow  }

set edit:rprompt = (constantly ^
     (styled (uidgen) blue))

fn k {|@k| e:kubectl $@k }
fn l {|@l| e:ls -larth $@l }
fn f {|@f| e:review $@f }
fn c {|@c| e:chk $@c }
```
 
## Additional Tools

The installation includes [wormsign](https://github.com/jpegleg/wormsign) and [AES256CTR](https://github.com/jpegleg/file_encryption_AES256/) tools.

Wormsign is for Dilithium file signing and verification and the AES256CTR tool is for file encryption. Both tools have interactive and automation modes.


Also see https://github.com/jpegleg/power-pathway which has much of the same functionality but using PowerShell instead of elvish.
