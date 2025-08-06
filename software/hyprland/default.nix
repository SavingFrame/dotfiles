{ host, ... }:
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$modifier" = "SUPER";
    monitor = ",preferred,auto,1";
  };
  imports = [
    ./binds.nix
    ./startup.nix
    ./general.nix
    ./env.nix
    ./ui.nix
    ./rules.nix
  ];
}
