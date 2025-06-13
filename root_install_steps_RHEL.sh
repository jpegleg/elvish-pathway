#!/usr/bin/env sh

curl -so - https://dl.elv.sh/linux-amd64/elvish-v0.21.0.tar.gz | sudo tar -xzvC /usr/local/bin

sudo dnf install -y https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.fedora39.x86_64.rpm
sudo dnf install -y pkgconf gcc perl-FindBin perl-IPC-Cmd openssl-devel

# set elvish as the login shell for user specified, the user that be leveraging it
sudo usermod --shell /usr/local/bin/elvish $1

# set wormsign directories and templates
sudo mkdir -p /opt/wormsign/live /opt/wormsign/templates
sudo cp scripts/update_config.sh /opt/wormsign/templates/
sudo cp wormsign.toml__template /opt/wormsign/templates/
sudo chown -R $1:$1 /opt/wormsign
