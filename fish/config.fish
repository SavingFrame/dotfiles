set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim
alias ls='grc --colour=auto ls --color=always'
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/gem/ruby/3.4.0/bin
fish_add_path $HOME/.spicetify
alias ss sesh-sessions

if status is-interactive
    starship init fish | source
    zoxide init fish | source
end
set -lx SHELL /usr/bin/fish
