
# Bring nix-env and its packages into env.
if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
  # If ~.nix-profile/sbin doesn't exist this will echo a warning.
  # To avoid seeing that we pipe its output to null.
  bass source $HOME/.nix-profile/etc/profile.d/nix.sh ^/dev/null
end

abbr -a  ns 'nix-shell --command fish'
