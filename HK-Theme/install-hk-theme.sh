#!/bin/bash
set -e

echo "Installing HK-Theme..."

# --- Fonts ---
echo "Installing MesloLGS Nerd Fonts system-wide..."
sudo mkdir -p /usr/share/fonts/truetype/meslo
sudo cp fonts/*.ttf /usr/share/fonts/truetype/meslo/
sudo fc-cache -f -v

# --- Konsole ---
mkdir -p ~/.local/share/konsole
cp -r HK-Theme/konsole/* ~/.local/share/konsole/

# --- Plasma layout ---
mkdir -p ~/.config/plasma
cp HK-Theme/plasma/layout.conf ~/.config/plasma/

# --- Starship ---
mkdir -p ~/.config
cp HK-Theme/starship/starship.toml ~/.config/

# --- Color schemes ---
mkdir -p ~/.local/share/kxmlgui5/konsole
cp -r HK-Theme/color-schemes/* ~/.local/share/kxmlgui5/konsole/

# --- Wallpapers ---
mkdir -p ~/.local/share/wallpapers
cp HK-Theme/wallpapers/* ~/.local/share/wallpapers/

# --- Fastfetch ---
mkdir -p ~/.config/fastfetch
cp -r HK-Theme/fastfetch/* ~/.config/fastfetch/

echo "HK-Theme installed successfully!"
