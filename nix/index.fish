
# Works with shell/index.tpl to prevent running PATH modifying functions.
# TODO in current state also prevents importing *.tpl files
# But then again, question is what use they would provide in
# nix-fish env anyway
function nix-fish
  # Works with shell/index.tpl to prevent running PATH modifying functions.
  nix-shell --command 'env BRYDOTS_IS_NIXSH_ENV=1 fish $argv'
end
