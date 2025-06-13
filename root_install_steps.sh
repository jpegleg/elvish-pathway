#!/usr/bin/env sh

curl -so - https://dl.elv.sh/linux-amd64/elvish-v0.21.0.tar.gz | sudo tar -xzvC /usr/local/bin

# from https://wezfurlong.org/wezterm/install/linux.html
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | tee /etc/apt/sources.list.d/wezterm.list
apt update
apt install wezterm -y
# cmake gcc clang for compiling things, remove if not a compiling system (and skip rustup user steps)
apt install openssl cmake gcc clang -y

# set elvish as the login shell for user specified, the user that be leveraging it
usermod --shell /usr/local/bin/elvish $1

# set wormsign directories and templates
mkdir -p /opt/wormsign/live /opt/wormsign/templates
cp scripts/update_config.sh /opt/wormsign/templates/
cp wormsign.toml__template /opt/wormsign/templates/
chown -R $1:$1 /opt/wormsign
