
# set the config for wezterm
cp wezterm.lua ~/.wezterm.lua

# set the config for elvish
mkdir ~/.config/elvish/
cp rc.elv ~/.config/elvish/rc.elv

# update cargo with rustup or install cargo with rustup if no rustup found
rustup update || curl https://sh.rustup.rs -sSf | sh -s -- -y

# git clone dwarven-toolbox from github
git clone https://github.com/jpegleg/dwarven-toolbox || rm -rf dwarven-toolbox && git clone https://github.com/jpegleg/dwarven-toolbox
cd dwarven-toolbox || exit 1

# skip zlib compression tools by default
mv no-zlib_Cargo.toml Cargo.toml

# compile and install all 80 of the dwarven-toolbox programs
cargo build --release --all
for x in $(grep ^- README.md | grep -v 84 | cut -d'-' -f2); do
    echo "Installing $x"
    sudo cp target/release/$x /usr/local/bin/ 
done
