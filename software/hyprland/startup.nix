{ host, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "wl-paste --type text --watch cliphist store" # Saves text
      "wl-paste --type image --watch cliphist store" # Saves images
      "killall -q waybar;sleep .5 && waybar"
      "blueman-applet"
    ];
  };
}
