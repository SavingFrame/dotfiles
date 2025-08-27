{
  pkgs,
  inputs,
  ...
}:

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
in
{
  imports = [
    ./software/hyprland
    ./software/waybar
    ./software/sherlock.nix
    ./software/themes
    ./software/tmux.nix
    ./software/swaync.nix
    ./software/satty.nix
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
    pkgs.git
    pkgs.fd
    grip-grab
    pkgs.lazygit
    pkgs.wl-clipboard
    inputs.zen-browser.packages.${pkgs.system}.default
    pkgs.telegram-desktop
    pkgs.nerd-fonts.zed-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
    pkgs.font-awesome
    pkgs.adwaita-qt6
    pkgs.sesh
    pkgs.fzf
    pkgs.opencode
    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    (import ./software/wallsetter.nix { inherit pkgs; })
    pkgs.hyprshot
    pkgs.satty
    pkgs.hyprpicker
    pkgs.zoxide
    pkgs.uv
    pkgs.devenv
    pkgs.slack
    pkgs.tmuxinator
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
    };
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Ivan";
    userEmail = "savingframe@gmail.com";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
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

  programs.fish = {
    enable = true;
    shellAliases = {
      cd = "z";
      ss = "sesh-sessions";
    };
    binds = {
      "ctrl-f".command = "ss";
    };
    interactiveShellInit = ''
      zoxide init fish | source
      starship init fish | source
      set -lx SHELL /usr/bin/fish
      direnv hook fish | source
    '';

    functions = {
      sesh-sessions = ''
        if set -q TMUX
        	sesh connect "$(
        		sesh list --icons | fzf-tmux -p 55%,60% \
        		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
        		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
        		--bind 'tab:down,btab:up' \
        		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
        		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -h -d 2 -t d -e .trash . ~)' \
        		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
        	)"
        else
        	set session (sesh list --icons | fzf --height 40% \
        	--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
        	--layout=reverse \
        	--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
        	--bind 'tab:top,btab:up' \
        	--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        	--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        	--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        	--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
        	--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        	--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
        	)
        	test -z "$session"; and return
        	sesh connect $session
        end
      '';
      extract = ''
        # Taken from: https://github.com/dideler/dotfiles/blob/master/functions/extract.fish
        function extract --description "Expand or extract bundled & compressed files"
          set --local ext (echo $argv[1] | awk -F. '{print $NF}')
          switch $ext
            case tar  # non-compressed, just bundled
              tar -xvf $argv[1]
            case gz
              if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar  # tar bundle compressed with gzip
                tar -zxvf $argv[1]
              else  # single gzip
                gunzip $argv[1]
              end
            case tgz  # same as tar.gz
              tar -zxvf $argv[1]
            case bz2  # tar compressed with bzip2
              tar -jxvf $argv[1]
            case rar
              unrar x $argv[1]
            case zip
              unzip $argv[1]
            case '*'
              echo "unknown extension"
          end
        end
      '';
    };
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
