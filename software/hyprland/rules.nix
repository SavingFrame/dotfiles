{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float, class:zen, title:Picture-in-Picture"
        "pin, class:zen, title:Picture-in-Picture"
        "persistentsize, class:zen, title:Picture-in-Picture"
        "noinitialfocus, class:zen, title:Picture-in-Picture"
        "content video, class:zen, title:Picture-in-Picture"
        "move 81% 81%, class:zen, title:Picture-in-Picture"
        "opacity override 1.0 override 1.0 override 1.0,class:zen,title:Picture-in-Picture"
        "opacity override 1.0 override 1.0 override 1.0,class:zen,title:.+Twitch.+"
      ];
      layerrule = [
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];
    };
  };
}
