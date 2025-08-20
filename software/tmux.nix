{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    prefix = "C-Space";
    shell = "/etc/profiles/per-user/nixy/bin/fish";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.kanagawa
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -as terminal-features ',xterm-ghostty:RGB'
      set -as terminal-features ",xterm-256color:RGB"

      set -g default-terminal 'tmux-256color'
      # undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # support colors for undercurl
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind-key C-k send-keys -R \; clear-history
      set -g detach-on-destroy off  # don't exit from tmux when closing a session
      bind-key -n C-f  run-shell "sesh connect \"$(
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
      )\""
      # resize
      bind-key -r -T prefix       C-Up              resize-pane -U 10
      bind-key -r -T prefix       C-Down            resize-pane -D 10
      bind-key -r -T prefix       C-Left            resize-pane -L 10
      bind-key -r -T prefix       C-Right           resize-pane -R 10
      # shift right left
      bind -n S-Right next-window
      bind -n S-Left previous-window
      # theme
      set -g @kanagawa-theme 'wave'
      set -g @kanagawa-plugins "cpu-usage ram-usage git"
      set -g @dracula-battery-hide-on-desktop true
      set -g @kanagawa-show-powerline true
      set -g @kanagawa-show-edge-icons true
      set -g @kanagawa-border-contrast false
      set -g @kanagawa-ignore-window-colors true
    '';
  };

  # home.packages = [
  #   # Open tmux for current project.
  #   (pkgs.writeShellApplication {
  #     name = "pux";
  #     runtimeInputs = [ pkgs.tmux ];
  #     text = ''
  #       PRJ="''$(zoxide query -i)"
  #       echo "Launching tmux for ''$PRJ"
  #       set -x
  #       cd "''$PRJ" && \
  #         exec tmux -S "''$PRJ".tmux attach
  #     '';
  #   })
  # ];
}
