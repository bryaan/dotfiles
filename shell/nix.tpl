
# Bring nix-env and its packages into env.

{% if os.mac %}
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  bass source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ^/dev/null
end
{% endif %}

{% if os.linux %}
if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
  # If ~.nix-profile/sbin doesn't exist this will echo a warning.
  # To avoid seeing that we pipe its output to null.
  bass source $HOME/.nix-profile/etc/profile.d/nix.sh ^/dev/null
end
{% endif %}


abbr -a  ns 'nix-shell --command fish'

