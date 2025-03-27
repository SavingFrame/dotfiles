set -Ux PAGER less
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux SHELL /usr/bin/fish
alias ls='grc --colour=auto ls --color=always'
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/gem/ruby/3.3.0/bin
alias ss sesh-sessions

if status is-interactive
    starship init fish | source
end
