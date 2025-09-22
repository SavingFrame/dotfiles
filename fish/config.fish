set -gx PAGER less
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TF_PLUGIN_CACHE_DIR $HOME/.terraform.d/plugin-cache
alias ls='grc --colour=auto ls --color=always'
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/gem/ruby/3.4.0/bin
fish_add_path $HOME/.spicetify
alias ss sesh-sessions
alias cd z

if status is-interactive
	bind ctrl-f 'ss'
    starship init fish | source
    zoxide init fish | source
end

set -lx SHELL /usr/bin/fish

if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
