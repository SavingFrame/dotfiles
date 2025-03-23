if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim
alias ls='grc --colour=auto ls --color=always'
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/python@3.11/libexec/bin
alias ss sesh-sessions

starship init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
