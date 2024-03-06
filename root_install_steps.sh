#!/usr/bin/env sh

# from https://elv.sh/get/
curl -o elvish-v0.20.1.tar.gz https://dl.elv.sh/linux-amd64/elvish-v0.20.1.tar.gz
tar -xzvf elvish-v0.20.1.tar.gz
cp elvish-v0.20.1 /usr/local/bin/elvish
rm elvish-v0.20.1.tar.gz elvish-v0.20.1

# from https://wezfurlong.org/wezterm/install/linux.html
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | tee /etc/apt/sources.list.d/wezterm.list
apt update
apt install wezterm -y
# cmake gcc clang for compiling things, remove if not a compiling system (and skip rustup user steps)
apt install openssl cmake gcc clang -y

# set elvish as the login shell for user specified, the user that be leveraging it
usermod --shell /usr/local/bin/elvish $1
