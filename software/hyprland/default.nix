{ host, ... }:
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  wayland.windowManager.hyprland.settings = {
    "$modifier" = "SUPER";
    monitor = ",preferred,auto,1";
  };
  imports = [
    ./binds.nix
    ./general.nix
    ./env.nix
    ./startup.nix
    ./ui.nix
    ./rules.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];
}
