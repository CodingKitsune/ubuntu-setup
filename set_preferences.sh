#! /bin/bash

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize';
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM';
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20;
gsettings set org.gnome.nautilus.preferences show-create-link true;
gsettings set org.gnome.nautilus.preferences show-delete-permanently true;
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view';
gsettings set org.gnome.nautilus.preferences default-sort-order 'mtime';
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing';
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600;
gsettings set org.gnome.desktop.session idle-delay 0;
gsettings set org.gnome.desktop.media-handling autorun-never true;
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark';
gsettings set org.gnome.desktop.interface gtk-theme 'Sweet';
gsettings set org.gnome.desktop.wm.preferences theme 'Sweet';
gsettings set org.gnome.desktop.interface clock-show-weekday true;
gsettings set org.gnome.desktop.calendar show-weekdate true;
gsettings set org.gnome.mutter dynamic-workspaces false;
gsettings set org.gnome.mutter workspaces-only-on-primary false;
gsettings set org.gnome.system.location enabled false;
gsettings set org.gnome.desktop.privacy report-technical-problems false;
gsettings set org.gnome.desktop.interface enable-hot-corners true;
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'code.desktop', 'chromium_chromium.desktop']";
gsettings set org.gnome.desktop.background picture-uri "file:////home/${DEFAULTUSER}/Pictures/Wallpapers/wallpaper.jpg";
gsettings set org.gnome.desktop.screensaver picture-uri "file:////home/${DEFAULTUSER}/Pictures/Wallpapers/wallpaper.jpg";
gsettings set org.gnome.desktop.interface text-scaling-factor 0.90000000000000002;
gsettings set org.gnome.desktop.interface monospace-font-name 'Space Mono 13';
gsettings set org.gnome.desktop.interface font-name 'Lexend Deca 11';
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Lexend Deca Bold 11';
gsettings set org.gnome.shell enabled-extensions "['ubuntu-appindicators@ubuntu.com', 'TaskBar@c0ldplasma', 'gsconnect@andyholmes.github.io', 'volume-mixer@evermiss.net', 'windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']";

papirus-folders -C teal --theme Papirus-Dark;

update-alternatives --set x-www-browser /usr/bin/chromium-browser;
