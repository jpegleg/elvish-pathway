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
sudo apt install mezterm

# set the config for wezterm
cp wezterm.lua ~/.wezterm.lua

# set the config for elvish
mkdir /.config/elvish/
cp rc.elv ~/.config/elvish/rc.elv

# set elvish as the login shell
sudo usermod --shell /usr/local/bin/elvish $(whomami)
