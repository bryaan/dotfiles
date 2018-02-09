
# Before doing the todoos, first need to understand benefit
# of running fish in nix-shell.
# From what im using it for now, there is really zero direct interaction.
#
# https://github.com/NixOS/nix/issues/440
# TODO the pathfile overwrites the PATH that nix-shell has set
# so this doesn't work right.
# TODO Modify the fish prompt to distinguish when in nix-shell
#   TODO Show nix-env name if applicatiple?
function nix-fish
  #nix-shell --command fish $argv
  #eval (bash -c "source ~/.nix-profile/etc/profile.d/nix.sh; fish --command 'echo set -x NIX_PATH \"\$NIX_PATH\"\;; echo set -x PATH \"\$PATH\"\;; echo set -x SSL_CERT_FILE \"\$SSL_CERT_FILE\"'")
end
