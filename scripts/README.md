# The pathway elvish script example collection

These scripts use the [dwarven-toolbox](https://github.com/jpegleg/dwarven-toolbox/) tools along with the parallel execution lambdas.

The dwarven-toolkit tools do some of the low level byte operations, while the elvish and CLI does the parallel processing and composability.

This scripts also use [wormsign](https://github.com/jpegleg/wormsign) and [AES256CTR](https://github.com/jpegleg/file_encryption_AES256/) tools.

The scripts are intended to be examples that are customized based on your needs. They are demos or references.

## Examples

In the example scripts here, we we generate a lot of ED25519 keypairs, and transform them.
We create and transform them at the same time, assuming the name is in `runes.json`:

```
[
  {"name": "starlight"},
  {"name": "treeforce"},
  {"name": "rainwater"},
  {"name": "growthsun"},
  {"name": "coldmoons"},
  {"name": "earthflow"},
  {"name": "lightsnap"},
  {"name": "starsdark"},
  {"name": "treeburns"},
  {"name": "dryearths"},
  {"name": "darkcling"},
  {"name": "warmmoons"},
  {"name": "skypentas"},
  {"name": "darksigns"},

  {"name": "goat"}
]
```

These are names of the same lenth and also "goat" for our demo. Each item in this JSON structure will be processed at the same time, down to the nanosecond.
We'll create a random 64 bit value in our users home directory as a hidden file with the name: `~/.$h[name]` which will result in `~/.goat` if goat is a name we set.

The script `create_new_magick.elv` generates an ED25519 keypair and writes it as binary to `~/.$h[name]` for each name in the JSON.

Each name is processed as a thread, each thread running at the same time for each name. This all via `peach` in elvish.

The next script `society_of_growth.elv` creates additional formats and reports of each `~/.$h[name]`.

Some of the other scripts in the collection utilize these `~/.$h[name]` generated files for various demonstrations.

#### Example demonstration

```
$ elvish create_new_magick.elv # generate demo files
...
$ elvish society_of_growth.elv # generate more demo files
...
$ cp immortal.elv ~ && cd && elvish immortal.elv # encrypt some demo files
```

#### Example files.json

```
[
  {"name": "star_party", "uid": "ef00912e-0532-41a1-9213-c6fae43c37c6", "data": "Data from first file", "signer": "/home/tigerax/.starlight"},
  {"name": "hero_party", "uid": "e3ab1f06-999a-4a57-b08c-6b05be701ac3", "data": "File data 2", "signer": "/home/tigerax/.starlight"}
]
```

### Lord FIM

One of the great tools in the `scripts` collection is `lord_fim.elv` which is a syscheck aka file integrity monitoring (FIM) tool. This script can be used to gather statistics on a provided set of files and compare the statics against the last run, sending the data to the system logs for audit purposes. 

### Usul and Wormsign

The script `usul.elv` is for automated Dilithium5 signature creation using `wormsign -ats` to create bulk Dilithium5 signatures for each file specified in `worm.json`, throwing away the private keys and saving the public key for verification.

The script calls a bash script in `/opt/wormsign/template/update_config.sh` which is used to leverage `&&` control flow while generating the files.
It calls `wormsign-confgen` to create a `wormsign.toml` for each file, signs, and verifies. There is a directory created for each target within `/opt/wormsign/live` that uses sha256sum to create the directory name, which is also used for some file names.

```
#!/usr/bin/env elvish

var sessionid = (uidgen)
var worm = (which wormsign)

echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - We found $worm and will use it.
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - SHA256 checksum of wormsign: (sha256sum $worm)
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - reading targets from ./worm.json

var wormtargets = (from-json < worm.json)

echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - checking on $@wormtargets

peach {|h|
  var y = (echo $h[target] | sha256sum | cut -c1-32)
  mkdir -p /opt/wormsign/live/$y
  /bin/bash /opt/wormsign/templates/update_config.sh $h[target] /opt/wormsign/live/$y/$y.pub /opt/wormsign/live/$y/$y.sig /opt/wormsign/live/$y/$y.key /opt/wormsign/live/$y
  var logstamp = (date +%Y-%m-%dT%H:%M:%SZ)
  echo $logstamp - $sessionid - $h[target] - signed
} $wormtargets
```
