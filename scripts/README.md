# The pathway elvish script example collection

These scripts use the [dwarven-toolbox](https://github.com/jpegleg/dwarven-toolbox/) tools along with the parallel execution lambdas in elvish to make modular, tweakable, cryptography scripts.

The dwarven-toolkit tools do some of the low level byte operations, while the elvish and CLI does the parallel processing and composability.

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
We'll create a random 64 bit value in our users home directory as a hidden file with the name: `~/.$h[name]` which will result in `~/.goat`, for each name
in the JSON.

The script `create_new_magick.elv` generates an ED25519 keypair and writes it as binary to `~/.$h[name]` for each name in the JSON.

Each name is processed as a thread, each thread running at the same time for each name. This all via `peach` in elvish.

The next script `society_of_growth.elv` creates additional formats and reports of each `~/.$h[name]`.

The other scripts in the collection utilize these `~/.$h[name]` generated files for various secrets, such as for signing or key encryption.

We'll see that the `deep_woods_locker.elv` JSON is a different file, the `files.json`. This is a different JSON structure for targets to encrypt with XChaCha20Poly1305 AEAD file encryption.

The `deep_woods_locker.elv` uses a provided ed25519 signing key, and so we can use the ones generated from `create_new_mgick.elv` for this purpose. In the example below, we had the tigerax user's .starlight key sign both data segments. Note how the files.json isn't paths to files, but rather data in JSON. This means that the input JSON "data" segment is the plaintext for each "name".

The `deep_woods_locker.elv` is a somewhat obscene semi-obfuscated data encryption system that does not expose the decryption functionality directly, outputting a ciphertext file and supporting files, including signing with the ed25519 key set for each name.

#### Example flow of operations

```
$ elvish create_new_magick.elv
...
$ elvish society_of_growth.elv
...
$ elvish deep_woods_locker.elv
```

#### Example files.json

```
[
  {"name": "star_party", "uid": "ef00912e-0532-41a1-9213-c6fae43c37c6", "data": "Data from first file", "signer": "/home/tigerax/.starlight"},
  {"name": "hero_party", "uid": "e3ab1f06-999a-4a57-b08c-6b05be701ac3", "data": "File data 2", "signer": "/home/tigerax/.starlight"}
]
```


