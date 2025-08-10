{ host, ... }:
{
  wayland.windowManager.hyprland.settings = {

    "$modifier" = "SUPER";
    "$menu" = "sherlock";
    bind = [
      "$modifier, Return, exec, ghostty"
      "$modifier, Q, killactive,"
      "$modifier, B, exec, zen"
      "$modifier, N, exec, $fileManager"
      "$modifier Shift, E, exec, /home/archie/.config/rofi/scripts/powermenu_t4"
      "$modifier Shift, W, exec, bash /home/archie/.config/hypr/scripts/wallpaper.sh"
      "$modifier Shift, N, exec, swaync-client -t -sw"
      "$modifier Shift, Space, togglefloating,"
      "$modifier, D, exec, $menu"
      "$modifier, P, pseudo, # dwindle"
      "$modifier Shift, C, exec,pkill waybar && hyprctl dispatch exec waybar"
      ", print, exec, hyprshot -m region --raw -z | swappy -f -"
      "$modifier,Print,exec,hyprshot -m output --raw -z | swappy -f -"
      "$modifier SHIFT, f, fullscreen,"
      "$modifier, left, movefocus, l"
      "$modifier, right, movefocus, r"
      "$modifier, up, movefocus, u"
      "$modifier, down, movefocus, d"
      "$modifier, h, movefocus, l"
      "$modifier, l, movefocus, r"
      "$modifier, k, movefocus, u"
      "$modifier, j, movefocus, d"
      "$modifier SHIFT, j, movewindow, d"
      "$modifier SHIFT, k, movewindow, u"
      "$modifier SHIFT, l, movewindow, r"
      "$modifier $SHIFT, h, movewindow, l"
      "$modifier, 1, workspace, 1"
      "$modifier, 2, workspace, 2"
      "$modifier, 3, workspace, 3"
      "$modifier, 4, workspace, 4"
      "$modifier, 5, workspace, 5"
      "$modifier, 6, workspace, 6"
      "$modifier, 7, workspace, 7"
      "$modifier, 8, workspace, 8"
      "$modifier, 9, workspace, 9"
      "$modifier, 0, workspace, 10"
      "$modifier SHIFT, 1, movetoworkspace, 1"
      "$modifier SHIFT, 2, movetoworkspace, 2"
      "$modifier SHIFT, 3, movetoworkspace, 3"
      "$modifier SHIFT, 4, movetoworkspace, 4"
      "$modifier SHIFT, 5, movetoworkspace, 5"
      "$modifier SHIFT, 6, movetoworkspace, 6"
      "$modifier SHIFT, 7, movetoworkspace, 7"
      "$modifier SHIFT, 8, movetoworkspace, 8"
      "$modifier SHIFT, 9, movetoworkspace, 9"
      "$modifier SHIFT, 0, movetoworkspace, 10"
      "$modifier, S, togglespecialworkspace, magic"
      "$modifier SHIFT, S, movetoworkspace, special:magic"
      "$modifier, Y, togglesplit"
      "$modifier, mouse_down, workspace, e+1"
      "$modifier, mouse_up, workspace, e-1"
    ];

    bindm = [
      "$modifier, mouse:272, movewindow"
      "$modifier, mouse:273, resizewindow"
    ];
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, ddcutil -d 1 setvcp 10 + 5"
      ",XF86MonBrightnessDown, exec, ddcutil -d 1 setvcp 10 - 5"
    ];

    # Requires playerctl
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
