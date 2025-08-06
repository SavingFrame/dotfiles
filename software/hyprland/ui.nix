{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      general = {
        "$modifier" = "SUPER";
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = "30,20,40,20";
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        "col.active_border" = "rgba(4a5a4aee) rgba(2a3a2aee) 45deg";
        "col.inactive_border" = "rgba(2a2a2aaa)";
      };
      decoration = {
        rounding = 6;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          ignore_opacity = true;
          popups = true;
          new_optimizations = true;
          noise = 0.0200;
          contrast = 1;
          brightness = 0.8172;
          vibrancy = 0.1696;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 4;
          color = "rgba(000000b3)";
          ignore_window = true;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
    };
  };
}
