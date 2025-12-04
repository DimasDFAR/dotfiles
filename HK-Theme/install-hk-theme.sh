#!/usr/bin/env bash
set -e

# Absolute paths
THEME_DIR="~/KDE-​Game​Theme​Dotfiles/HK-Theme"
FONT_DIR="~/KDE-​Game​Theme​Dotfiles/fonts"
WALLPAPER="~/KDE-​Game​Theme​Dotfiles/HK-Theme/wallpapers/HollowKnight.jpg"

echo "Installing MesloLGL Nerd Fonts system-wide..."
sudo mkdir -p /usr/share/fonts/truetype/meslo
sudo cp ~/KDE-GameThemeDotfiles/fonts/MesloLGLNerdFontMono-Bold.ttf /usr/share/fonts/truetype/meslo/
sudo cp ~/KDE-GameThemeDotfiles/fonts/MesloLGLNerdFontMono-BoldItalic.ttf /usr/share/fonts/truetype/meslo/
sudo cp ~/KDE-GameThemeDotfiles/fonts/MesloLGLNerdFontMono-Italic.ttf /usr/share/fonts/truetype/meslo/
sudo cp ~/KDE-GameThemeDotfiles/fonts/MesloLGLNerdFontMono-Regular.ttf /usr/share/fonts/truetype/meslo/
sudo fc-cache -f -v

echo "Copying theme configs..."

# --- Zsh ---
echo "Applying Zsh configs..."
cp ~/KDE-GameThemeDotfiles/HK-Theme/.zshrc ~/.zshrc

# Color schemes
echo "Applying color schemes..."
mkdir -p ~/.local/share/color-schemes
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/color-schemes/ArcDark.colors ~/.local/share/color-schemes/ArcDark.colors
plasma-apply-colorscheme "ArcDark"

# Fastfetch
echo "Applying fastfetch configs..."
mkdir -p ~/.config/fastfetch
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

# Starship
echo "Applying starship configs..."
mkdir -p ~/.config/starship
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/starship/starship.toml ~/.config/starship/starship.toml

# Konsole
echo "Applying Konsole configs..."
mkdir -p ~/.local/share/konsole
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/konsole/HollowKnight.profile ~/.local/share/konsole/HollowKnight.profile
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/konsole/Nordic.colorscheme ~/.local/share/konsole/Nordic.colorscheme
cp -r ~/KDE-GameThemeDotfiles/HK-Theme/konsolerc ~/.config/konsolerc

# Plasma panel/layout
echo "Applying taskbar layout..."
cp "~/KDE-GameThemeDotfiles/HK-Theme/plasma/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# Apply wallpaper dynamically via qdbus
echo "Applying wallpaper dynamically..."
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var allDesktops = desktops();
for (i=0; i<allDesktops.length; i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = ['Wallpaper','org.kde.image','General'];
    d.writeConfig('Image', 'file://$WALLPAPER');
}
"


echo "Reloading Plasma to apply changes..."
kquitapp5 plasmashell || true
plasmashell &

echo "Hollow Knight theme applied! (You may need to restart for all changes to apply)"
