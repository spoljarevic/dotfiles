-- Monitor identifiers
MonitorAOC  = "DP-2,1920x1080@144,0x0,1"
MonitorBenQ = "DVI-D-1,1920x1080@60,1920x0,0"
MonitorNB   = "eDP-1,1920x1080@60.02000,0x0,1.0"

-- Applications
terminal   = "foot"
menu       = "tofi-drun --drun-launch=true"
lockscreen = "hyprlock"
hyprpicker = "hyprpicker -f hex -a -r"
ScreenShot = [[timestamp=$(date +'%Y-%m-%d--%H-%M-%S') && file_path=~/Pictures/screenshots/hyprshot-$timestamp.png && grim -g "$(slurp -d)" - | tee "$file_path" | wl-copy && notify-send "Screenshot taken" "Hyprshot-$timestamp.png saved to ~/Pictures/screenshots/" && swayimg "$file_path"]]

-- Rice
fastfetch_rice = terminal .. ' -e zsh -c "fastfetch; exec zsh"'
ttyclock       = terminal .. ' -e zsh -c "tty-clock -c -C 4; exec zsh"'
cava           = terminal .. ' -e zsh -c "cava; exec zsh"'
cmatrix        = terminal .. ' -e zsh -c "cmatrix; exec zsh"'

MusicPlayer = terminal .. ' -e zsh -c "ncmpcpp; exec zsh"'

mainMod = "SUPER"
