function __shell_search_key_bindings

# C-t  File Search
# C-r  Command History Search (most recent is last in list order)

# TODO colors and preview

# === sk/skim keybindings ===
bind \ct '__sk_find_file'
bind \cr '__sk_reverse_isearch'
bind \ec '__sk_cd'
bind \eC '__sk_cd_with_hidden'
bind \ev '__sk_cd_backwards'

# New keybindings
bind \cf '__sk_find_file'
bind \cr '__sk_reverse_isearch'
bind \eo '__sk_cd' # TODO not working on RHEL, some other app is using Alt+o, use xmodmap??
bind \eO '__sk_cd_with_hidden'
bind \ep '__sk_cd_backwards'




# TODO assign to key combo
# __fzf_select


# if bind -M insert >/dev/null ^/dev/null
#   bind -M insert \ct '__fzf_find_file'
#   bind -M insert \cr '__fzf_reverse_isearch'
#   bind -M insert \ec '__fzf_cd'
#   bind -M insert \eC '__fzf_cd_with_hidden'
# end

end
