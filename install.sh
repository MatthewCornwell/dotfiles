#!/bin/bash
set -e

echo "== Enabling COPRs =="
sudo dnf copr enable -y solopasha/hyprland

echo "== Installing core packages =="
sudo dnf install -y \
  hyprland xdg-desktop-portal-hyprland waybar wofi \
  hyprpaper hyprlock hypridle hyprpicker hyprshot \
  kitty micro git stow \
  swww socat wl-clipboard cliphist \
  fastfetch fontawesome-fonts-all \
  xdg-desktop-portal-gtk dconf \
  akmod-nvidia \
  hyprpolkitagent

echo "== Optional: Qt helpers (may conflict, skip on failure) =="
sudo dnf install -y hyprland-qtutils || echo "Skipped hyprland-qtutils (known Qt6 conflict on some setups)"

echo "== VS Code repo + install =="
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

echo "== Cloning dotfiles =="
if [ ! -d ~/dotfiles ]; then
  git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
fi

echo "== Stowing configs =="
cd ~/dotfiles
stow hypr waybar kitty wofi micro fastfetch portals scripts

echo "== Linking bashrc =="
rm -f ~/.bashrc
ln -s ~/dotfiles/bash/bashrc ~/.bashrc

echo "== Making scripts executable =="
chmod +x ~/.local/bin/*.sh

echo "Done. Log out and back into a Hyprland session to see everything take effect."
