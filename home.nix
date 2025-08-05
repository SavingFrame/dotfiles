{ config, pkgs, inputs, opencode, ... }:

let
grip-grab = pkgs.rustPlatform.buildRustPackage {
  pname = "grip-grab";
  version = "0.6.7";
  
  src = pkgs.fetchFromGitHub {
    owner = "alexpasmantier";
    repo = "grip-grab";
    tag = "v0.6.7";
    hash = "sha256-e7duLL4tjW+11jXUqU6sqoKTAPGkH81iDCfjtNcnd4I=";
  };
  
  cargoHash = "sha256-i/wqlM4hoDPa9dmbSU5VVCYA4UdI5fI3EPadOj+/+LE=";
};
in {
	imports = [
	];
  home.username = "nixy";
  home.homeDirectory = "/home/nixy";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';


  # Packages that should be installed to the user profile.

  home.packages = [
    pkgs.tree 
    pkgs.kitty
    pkgs.ghostty
    pkgs.git
    pkgs.fd
    grip-grab
    pkgs.lazygit
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "savingframe@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
  programs.fish.enable = true;

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.package = null;
    wayland.windowManager.hyprland.portalPackage = null;
    wayland.windowManager.hyprland.xwayland.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
      "$mod, B, exec, firefox"
      "$mod, Q, exec, killactive"
      "$mod, Return, exec, ghostty"
      ]
       ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
