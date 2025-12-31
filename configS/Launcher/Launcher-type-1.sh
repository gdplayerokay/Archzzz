sudo -v
rm -rf ~/.config/hypr/
cp -r /home/notgeocube/configS/config1/.config/hypr ~/.config/hypr/
rm -rf ~/.config/rofi/
cp -r /home/notgeocube/configS/config1/.config/hypr ~/.config/rofi/
rm -rf ~/.config/waybar/
cp -r /home/notgeocube/configS/config1/.config/waybar ~/.config/waybar/

hyprctl reload
pkill hyprpaper
pkill waybar
hyprpaper & waybar & disown
exit
