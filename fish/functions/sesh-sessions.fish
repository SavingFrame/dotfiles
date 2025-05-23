function sesh-sessions
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
end
