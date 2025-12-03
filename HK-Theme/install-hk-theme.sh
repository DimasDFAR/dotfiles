#!/usr/bin/env bash
set -e

# Absolute paths
THEME_DIR="/home/dimsum/dotfiles/HK-Theme"
FONT_DIR="/home/dimsum/dotfiles/fonts"
WALLPAPER="$THEME_DIR/wallpapers/HollowKnight.jpg"

echo "Installing MesloLGL Nerd Fonts system-wide..."
sudo mkdir -p /usr/share/fonts/truetype/meslo
sudo cp "$FONT_DIR"/*.ttf /usr/share/fonts/truetype/meslo/
sudo fc-cache -f -v

echo "Copying theme configs..."

# Fastfetch
mkdir -p "$HOME/.config/fastfetch"
cp -r "$THEME_DIR/fastfetch/"* "$HOME/.config/fastfetch/"

# Starship
mkdir -p "$HOME/.config/starship"
cp -r "$THEME_DIR/starship/"* "$HOME/.config/starship/"

# Konsole
mkdir -p "$HOME/.local/share/konsole"
cp -r "$THEME_DIR/konsole/"* "$HOME/.local/share/konsole/"

# Color schemes
mkdir -p "$HOME/.local/share/color-schemes"
cp -r "$THEME_DIR/color-schemes/"* "$HOME/.local/share/color-schemes/"

# Plasma panel/layout
cp "$THEME_DIR/plasma/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/"

# Apply wallpaper dynamically via qdbus
echo "Applying wallpaper dynamically..."
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
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

echo "HK-Theme installed and applied successfully!"
