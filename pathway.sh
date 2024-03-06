#!/usr/bin/env sh

# from https://elv.sh/get/
curl -o elvish-v0.20.1.tar.gz https://dl.elv.sh/linux-amd64/elvish-v0.20.1.tar.gz
tar -xzvf elvish-v0.20.1.tar.gz
sudo cp elvish-v0.20.1 /usr/local/bin/elvish
rm elvish-v0.20.1.tar.gz elvish-v0.20.1

# from https://wezfurlong.org/wezterm/install/linux.html
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm -Y

# set the config for wezterm
cp wezterm.lua ~/.wezterm.lua

# set the config for elvish
mkdir ~/.config/elvish/
cp rc.elv ~/.config/elvish/rc.elv

# set elvish as the login shell for user specified (self)
sudo usermod --shell /usr/local/bin/elvish $1

###########  This section below is the dwarven-toolbox compiling and installing:

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
