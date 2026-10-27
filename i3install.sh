#!/bin/bash
set -e

USERNAME=lamiae

xbps-install -Suy
xbps-install -Sy xorg xrandr terminus-font dbus elogind polkit NetworkManager \
  network-manager-applet doas nano i3 i3status i3lock dmenu picom rofi dunst \
  polybar pcmanfm thunar feh sakura xterm htop neofetch firefox geany chromium \
  pulseaudio pavucontrol volumeicon sddm

ln -sf /etc/sv/dbus /var/service/
ln -sf /etc/sv/elogind /var/service/
ln -sf /etc/sv/polkitd /var/service/
ln -sf /etc/sv/NetworkManager /var/service/
ln -sf /etc/sv/sddm /var/service/

ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime

usermod -aG audio,video,network "$USERNAME"

mkdir -p /home/$USERNAME/.config/i3
cp /etc/i3/config /home/$USERNAME/.config/i3/config

sed -i '/^bindsym \$mod+d exec/d' /home/$USERNAME/.config/i3/config
cat << 'EOF' >> /home/$USERNAME/.config/i3/config

exec --no-startup-id picom
exec --no-startup-id feh --bg-scale /home/lamiae/Downloads/MyDarlingCatPicture.jpg
exec --no-startup-id setxkbmap -layout us -option caps:swapescape
exec --no-startup-id volumeicon

bindsym $mod+d exec rofi -show drun
bindsym $mod+Shift+t exec sakura
bindsym $mod+Shift+w exec firefox
bindsym $mod+Shift+d exec geany
bindsym $mod+Shift+f exec thunar
EOF

chown -R "$USERNAME:$USERNAME" /home/$USERNAME/.config

echo "INSTALLATION COMPLETE. Reboot when ready."
