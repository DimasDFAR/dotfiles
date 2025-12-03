#!/bin/bash
set -e
echo "Applying HK-Theme with Stow..."

# 1️⃣ Install fonts system-wide
echo "Installing MesloLGS Nerd Fonts system-wide..."
sudo mkdir -p /usr/share/fonts/truetype/meslo
sudo cp ~/dotfiles/fonts/*.ttf /usr/share/fonts/truetype/meslo/
sudo fc-cache -fv

# 2️⃣ Apply dotfiles with Stow
echo "Applying configuration folders with Stow..."
stow -v -t $HOME HK-Theme/starship
stow -v -t $HOME HK-Theme/konsole
stow -v -t $HOME HK-Theme/color-schemes
stow -v -t $HOME HK-Theme/zsh

# 3️⃣ Copy wallpapers
echo "Copying wallpapers..."
mkdir -p ~/Pictures/Wallpapers
cp HK-Theme/wallpapers/* ~/Pictures/Wallpapers/

# 4️⃣ Apply Plasma layout (taskbar)
echo "Installing KDE Plasma layout..."
cp HK-Theme/plasma/layout.conf ~/.config/plasma-org.kde.plasma.desktop-appletsrc

# 5️⃣ Set wallpaper dynamically using qdbus
echo "Applying wallpaper..."
WALLPAPER="$HOME/dotfiles/HK-Theme/wallpapers/HollowKnight.jpg"
plasmashell --replace &
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var allDesktops = desktops();
for (i=0;i<allDesktops.length;i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
    d.writeConfig('Image', 'file://$WALLPAPER');
}"

# 6️⃣ Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
fi

echo "HK-Theme applied successfully! You may need to restart Plasma to see full changes."
