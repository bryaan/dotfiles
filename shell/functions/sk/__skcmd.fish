function __skcmd
    set -q SK_TMUX; or set SK_TMUX 0
    set -q SK_TMUX_HEIGHT; or set SK_TMUX_HEIGHT 40%
    if [ $SK_TMUX -eq 1 ]
        echo "sk-tmux -d$SK_TMUX_HEIGHT"
    else
        echo "sk"
    end
end
