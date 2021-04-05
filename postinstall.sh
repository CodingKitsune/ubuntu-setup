#! /bin/bash

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

install_gnome_extension() {
    wget -O ./extension.zip $1;
    EXT_UUID=$(unzip -c ./extension.zip metadata.json | grep uuid | cut -d \" -f4);
    mkdir -p ~/.local/share/gnome-shell/extensions/${EXT_UUID};
    unzip -q ./extension.zip -d ~/.local/share/gnome-shell/extensions/${EXT_UUID}/;
    rm -rf ./extension.zip;
    gnome-extensions enable $EXT_UUID;
}

install_font() {
    wget -O ./font.zip $1;
    mkdir -p ./font-data;
    unzip -q ./font.zip -d ./font-data;
    mkdir -p ./font-data/static;
    mkdir -p /usr/share/fonts/truetype/$2;
    sudo cp -r ./font-data/*.ttf /usr/share/fonts/truetype/$2/;
    sudo cp -r ./font-data/static/*.ttf /usr/share/fonts/truetype/$2/;
    rm -rf ./font-data;
}


if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root"
   	exit 1
fi

echo "What is your default username?";
read DEFAULTUSER

echo 'Updating your system...';

apt-get update;
apt-get upgrade -y;
apt-get dist-upgrade -y;
apt-get autoremove -y;
apt-get autoclean -y;

echo 'System updated successfully..';

echo 'Installing setup packages...';

apt install curl -y;
apt install nano -y;
apt install linux-image-extra-virtual -y;
apt install apt-transport-https -y;
apt install ca-certificates -y;
apt install gnupg -y;
apt install lsb-release -y;
apt install build-essentials -y;
apt install git -y;
apt install dkms -y;
apt install wget -y;
apt install gdebi-core -y;
apt install flatpak -y;
apt install gnome-software-plugin-flatpak -y;

echo 'Adding public keys and repositories...';

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;

dpkg --add-architecture i386;

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list;

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list';

echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list;
apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61;

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;

add-apt-repository ppa:kritalime/ppa -y;
add-apt-repository ppa:serge-rider/dbeaver-ce -y;
add-apt-repository ppa:sicklylife/filezilla -y;
add-apt-repository ppa:obsproject/obs-studio -y;
add-apt-repository ppa:inkscape.dev/stable -y;
add-apt-repository ppa:papirus/papirus -y;

echo 'Refreshing software lists...';

apt-get update;

echo 'Auto-accepting TOS(es)';

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections;

echo 'Installing apps from repositories...';

apt install ubuntu-restricted-extras -y;
apt install gnome-tweaks -y;
apt install chrome-gnome-shell -y;
apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller -y;
apt install clementine -y;
apt install transmission -y;
apt install gparted -y;
apt install grub-customizer -y;
apt install wine winetricks -y;
apt install playonlinux -y;
apt install steam -y;
apt install docker-ce docker-ce-cli containerd.io -y;
apt install tree -y;
apt install whois -y;
apt install tmux -y;
apt install chromium-browser chromium-browser-l10n -y;
apt install zeal -y;
apt install vlc -y;
apt install vlc-plugin-access-extra -y;
apt install spotify-client -y;
apt install code -y;
apt install gimp -y;
apt install krita -y;
apt install dbeaver-ce -y;
apt install filezilla -y;
apt install firefox -y;
apt install meld -y;
apt install neofetch -y;
apt install ffmpeg -y;
apt install v4l2loopback-dkms -y;
apt install obs-studio -y;
apt install balena-etcher-electron -y;
apt install flameshot -y;
apt install wallch -y;
apt install geary -y;
apt install inkscape -y;
apt install imagemagick imagemagick-doc -y;
apt install gufw -y;
apt install guvc -y;
apt install transmission -y;
apt install net-tools -y;
apt install zsh -y;
apt install dconf-editor -y;
apt install cmake cmake-qt-gui -y;
apt install alacarte -y;
apt install papirus-icon-theme -y;
apt install papirus-folders -y;
apt install gnome-shell-extensions -y;
apt install chrome-gnome-shell -y;
apt install synapse -y;

echo 'Installing apps from snaps...';

sudo snap install --classic heroku;

echo 'Installing apps from deb(s)...';

wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb";
gdebi ~/discord.deb -n;
rm -rf ~/discord.deb;

wget -O ~/slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.14.0-amd64.deb";
gdebi ~/slack.deb -n;
rm -rf ~/slack.deb;

wget -O ~/gitkraken.deb "https://release.gitkraken.com/linux/gitkraken-amd64.deb";
gdebi ~/gitkraken.deb -n;
rm -rf ~/gitkraken.deb;

wget -O ~/franz.deb "https://github.com/meetfranz/franz/releases/download/v5.6.1/franz_5.6.1_amd64.deb";
gdebi ~/franz.deb -n;
rm -rf ~/franz.deb;

wget -O ~/teamviewer.deb "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb";
gdebi ~/teamviewer.deb -n;
rm -rf ~/teamviewer.deb;

echo 'Installing apps from scripts...';

sudo -H -u $DEFAULTUSER bash -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended';
sudo -H -u $DEFAULTUSER bash -c 'chsh -s $(which zsh)';
sudo -H -u $DEFAULTUSER bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash';

sudo -H -u $DEFAULTUSER bash -c 'nvm install node';
sudo -H -u $DEFAULTUSER bash -c 'npm install -g yarn';
sudo -H -u $DEFAULTUSER bash -c 'npm install -g create-react-app';
sudo -H -u $DEFAULTUSER bash -c 'npm install -g http-server';
sudo -H -u $DEFAULTUSER bash -c 'npm install -g yarn';
sudo -H -u $DEFAULTUSER bash -c 'npm install -g yo';

pip install --upgrade pip;
pip3 install --upgrade pip;

pip3 install virtualenv;
pip3 install ipython;

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip";
unzip awscliv2.zip;
sudo ./aws/install;
rm -rf awscliv2.zip;
rm -rf ./aws;

wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux;
chmod +x getplayer-linux;
sudo ./getplayer-linux --required --eulas-agreed;
rm -rf getplayer-linux;

echo 'Installing custom fonts...';

install_font "https://fonts.google.com/download?family=Fira%20Code" "firacode";
install_font "https://fonts.google.com/download?family=Heebo" "heebo";
install_font "https://fonts.google.com/download?family=Montserrat" "montserrat";
install_font "https://fonts.google.com/download?family=Lexend%20Deca" "lexand_deca";
install_font "https://fonts.google.com/download?family=Noto%20Sans" "noto_sans";
install_font "https://fonts.google.com/download?family=Oswald" "oswald";
install_font "https://fonts.google.com/download?family=Patrick%20Hand" "patrick_hand";
install_font "https://fonts.google.com/download?family=Patrick%20Hand%20SC" "patrick_hand_sc";
install_font "https://fonts.google.com/download?family=Roboto" "roboto";
install_font "https://fonts.google.com/download?family=Space%20Mono" "space_mono";

fc-cache -f -v;

echo 'Applying custom settings...';

echo "vm.swappiness=10" >> /etc/sysctl.conf;
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf;

wget -O Sweet.tar.xz "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE2MTQ0NTg5NTUiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjlkNTRlZGRhYzM2NWJjNmY4NmU5YjhhOTU1MGI5YTUwMWViYzUzMjQ0ZWZmMzZmOTNlYzdkNDM1OWMzNzdhMGY2NzUwYWE1OTViZGNkYjljZmU1MDEyZWRiODJmNTFmNjVkNzEwMDQzYTU4Yzg4MTJjNjRjYzc5MWYzZTNiMzU3IiwidCI6MTYxNzU4ODIzNiwic3RmcCI6bnVsbCwic3RpcCI6bnVsbH0.TbC01aAf1OcusjxdUVGgSXQY3ovORukra_RNBDl1U_4/Sweet.tar.xz";
tar xvf ./Sweet.tar.xz -C /user/share/themes;

mkdir -p "/home/${DEFAULTUSER}/Pictures/Wallpapers";
mkdir -p "/home/${DEFAULTUSER}/Pictures/Profile Pictures";

cp "./pictures/profile.jpg" "/home/${DEFAULTUSER}/Pictures/Profile Pictures/profile.jpg";
cp "./pictures/wallpaper.jpg" "/home/${DEFAULTUSER}/Pictures/Wallpapers/wallpaper.jpg";
cp "/home/${DEFAULTUSER}/Pictures/Profile Pictures/profile.jpg" "/home/${DEFAULTUSER}/.face";

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
gsettings set org.gnome.desktop.interface clock-show-weekday true;
gsettings set org.gnome.desktop.calendar show-weekdate true;
gsettings set org.gnome.mutter dynamic-workspaces false;
gsettings set org.gnome.mutter workspaces-only-on-primary false;
gsettings set org.gnome.system.location enabled false;
gsettings set org.gnome.desktop.privacy report-technical-problems false;
gsettings set org.gnome.desktop.interface enable-hot-corners true;
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'code.desktop', 'chromium_chromium.desktop']";
gsettings set org.gnome.desktop.background picture-uri "file:////usr/${DEFAULTUSER}/Pictures/Wallpapers/wallpaper.jpg";
gsettings set org.gnome.desktop.screensaver picture-uri "file:////usr/${DEFAULTUSER}/Pictures/Wallpapers/wallpaper.jpg";
gsettings set org.gnome.desktop.interface text-scaling-factor 0.90000000000000002;

gsettings set org.gnome.desktop.interface monospace-font-name 'Space Mono 13';
gsettings set org.gnome.desktop.interface font-name 'Lexend Deca 11';
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Lexend Deca Bold 11';

install_gnome_extension "https://extensions.gnome.org/extension-data/temperature%40xtranophilist.v21.shell-extension.zip";
install_gnome_extension "https://extensions.gnome.org/extension-data/AdvancedVolumeMixer%40harry.karvonen.gmail.com.v2.shell-extension.zip";
install_gnome_extension "https://extensions.gnome.org/extension-data/cpufreq%40nodefourtytwo.net.v6.shell-extension.zip";

gsettings set org.gnome.shell enabled-extensions "['ubuntu-appindicators@ubuntu.com', 'TaskBar@c0ldplasma', 'gsconnect@andyholmes.github.io', 'volume-mixer@evermiss.net', 'windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']";

papirus-folders -C teal --theme Papirus-Dark;

update-alternatives --set x-www-browser /usr/bin/chromium-browser;
mkdir -p /etc/chromium/policies/managed;
cp "./policies/chrome_extensions.json" "/etc/chromium/policies/managed/chrome_extensions.json";

yes | cp ./profile/.zshrc ~/.zshrc;

echo 'Removing some useless stuff...';
apt purge ubuntu-web-launchers -y;
apt-get autoclean -y;
apt-get autoremove -y;

echo 'Done! Please reboot your system!';
confirm "Reboot now?" && sudo reboot now;
