# TODO rename home-admin.tpl or move to ./shell/home/


# TODO So dont put password here, pull password from system keyring.

# Linux
# secret-tool store --label='Password for mydrive' drive mydrive
# secret-tool lookup drive mydrive

# Mac
# security add-generic-password -a ${USER} -s playground -w `pwgen`
# security delete-generic-password -a ${USER} -s playground
# security find-generic-password -a ${USER} -s playground -w

function ubqt.reboot
  # curl -u ???
end

function linksys.reboot
  curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'
end


# TODO this

# function classified.wake
#   wakeonlan classified
# end

## replace mac with your actual server mac address #
# alias wakeupnas01='/usr/bin/wakeonlan 00:11:22:33:44:FC'


alias tv='tvremote'


# TODO Chromecast commands