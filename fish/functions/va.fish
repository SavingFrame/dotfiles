function va
    if test -e .venv/bin/activate.fish
        source .venv/bin/activate.fish
    else if test -e ../.venv/bin/activate
        source ../.venv/bin/activate.fish
    else
        echo 'no .venv found in this or parent directory'
        return 1
    end
end
