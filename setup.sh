#!/bin/sh
apt-get --assume-yes install sudo git picom xinit pavucontrol network-manager-gnome kdeconnect alacritty zip unzip curl blueman light vim vifm rofi kde-spectacle mpv cmake libxcb-xfixes0-dev wget gpg apt-transport-https
apt-get --assume-yes --no-install-recommends install sddm
apt-get --assume-yes build-dep awesome

mkdir /usr/share/xsessions/
cp awesome.desktop /usr/share/xsessions/awesome.desktop

cp -r .config /home/matt/.config
cp -r chili /usr/share/sddm/themes/chili



curl -fsSL https://ppa.ablaze.one/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'
apt-get --assume-yes update
apt-get --assume-yes install floorp
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt-get --assume-yes update
apt-get --assume-yes install code

apt-get install
git clone https://github.com/awesomewm/awesome

cd awesome
make package
cd build
apt install ./*.deb
cd /home/matt
rm -r awesome

/sbin/reboot