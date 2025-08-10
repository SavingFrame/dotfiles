{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      master = {
        new_status = "slave";
        orientation = "right";
      };
      input = {
        kb_layout = "us,ua";
        kb_options = [
          "grp:win_space_toggle"
        ];
        numlock_by_default = true;
        repeat_delay = 400;
        repeat_rate = 40;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
      };
    };
  };
}
