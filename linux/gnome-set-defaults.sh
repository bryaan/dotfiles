#!/usr/bin/env sh


# === General Preferences ===
gsettings set org.gnome.desktop.wm.preferences num-workspaces "6"
gsettings set org.gnome.desktop.wm.preferences audible-bell false # disable bell
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "<Shift><Super>l"
# todo set lock screen also

# === gnome shell ===
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>a']"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>Space']" # "['<Super>s']"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['']" # "['<Super>n']"

# === Mouse ===
# gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "'<Super>'"
# gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"

# === Cut Copy Paste ===
#gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ cut "['<Super>x']"
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ copy "['<Super>c']"
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ paste "['<Super>v']"


# === Workspaces ===
#** Changes Workspace shown on Monitor
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Down']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

#** Moves Window to another worksapce
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Shift><Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Shift><Super>Down']"

#** Tile windows right/left
gsettings set org.gnome.mutter.keybindings toggle-tiled-left  "['<Shift><Super>Left']" #"['<Super>Left']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Shift><Super>Right']"
# gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>h','<Super>Left']"
# gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>l','<Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-center "[]"

#** Moves window to another monitor
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "['']"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "['']"


# === Windows ===
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4']" # , '<Super>w'
gsettings set org.gnome.desktop.wm.keybindings minimize "[]"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>m']"
# gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>m']"
# gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Shift><Super>m']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Alt>Escape']"
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward "['<Shift><Control><Alt>Escape']"


# === Custom Shortcuts ===
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "terminator"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>Return"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "file-manager"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "nautilus"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>e"

# add custom keybings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"




# === unsorted ===
gsettings set org.gnome.desktop.wm.keybindings raise-or-lower "['']"

gsettings set org.gnome.desktop.wm.keybindings set-spew-mark "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11 "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12 "['']"
gsettings set org.gnome.desktop.wm.keybindings toggle-shaded "['']"
gsettings set org.gnome.desktop.wm.keybindings lower "['']"
gsettings set org.gnome.desktop.wm.keybindings raise "['']"















##
