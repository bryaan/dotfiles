#!/usr/bin/env sh

# Sets the keyrepeat rate; and hold delay before beginning repeat.
xset r rate 250 50


# === General Preferences ===
gsettings set org.gnome.desktop.wm.preferences num-workspaces "6"
gsettings set org.gnome.desktop.wm.preferences audible-bell false # disable bell

# screenshot
gsettings set org.gnome.gnome-screenshot auto-save-directory 'file:///home/bryan/Desktop'
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "'Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "'<Primary>Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "'<Shift>Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "'<Primary><Shift>Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "'<Alt>Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "'<Primary><Alt>Print'"

# lock screen
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Primary><Alt>l'
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "<Super>9"
gsettings set org.gnome.desktop.lockdown disable-lock-screen false

# unset annoying default keybindings
gsettings set org.gnome.desktop.wm.keybindings raise-or-lower "['']"
gsettings set org.gnome.desktop.wm.keybindings set-spew-mark "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11 "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12 "['']"
gsettings set org.gnome.desktop.wm.keybindings toggle-shaded "['']"
gsettings set org.gnome.desktop.wm.keybindings lower "['']"
gsettings set org.gnome.desktop.wm.keybindings raise "['']"


# restrict Alt-Tab to current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Desktop
gsettings set org.gnome.shell always-show-log-out true
gsettings set org.gnome.nautilus.desktop home-icon-visible true
gsettings set org.gnome.nautilus.desktop trash-icon-visible true
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar false
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.search-providers disable-external true

# Nautilus
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'
gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'


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

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Alt>F1']"
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'


#
# security
#

gsettings set org.gnome.desktop.notifications show-in-lock-screen false
gsettings set org.gnome.desktop.privacy hide-identity true
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar false
gsettings set org.gnome.desktop.screensaver lock-delay 300
gsettings set org.gnome.desktop.screensaver show-full-name-in-top-bar false
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>BackSpace'


# === Custom Shortcuts ===
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "terminator"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>Return"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "file-manager"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "nautilus"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>e"

# add custom keybings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"


















##
