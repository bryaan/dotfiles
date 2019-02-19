Gnome v3 Backup

[user@oldinstall] gconftool-2 --dump / > gconf_dump.xml
[user@newinstall] gconftool-2 --load gconf_dump.xml


Backup
~/.config
~/.gnome
~/.gnome2
~/.icons
~/.themes
