####################################################
# http
####################################################

# TODO lookup # CPU on system and replace 4
abbr -a axel 'axel -n 4'

# Resume downloads by default
abbr -a wget 'wget -c $argv'


# get web server headers
function header
  curl -I $argv
end

# find out if remote server supports gzip / mod_deflate or not #
function header.supports.compression
  curl -I --compress $argv
end


# TODO May need a periodic internet connectivity test.
# List times, see if there is a pattern.

# Set new ip with 'sudo ipconfig set en0 INFORM 192.168.1.24'

function ipinfo
  set -l interface en0
  echo "Interface:" $interface
  echo "MAC:" (ifconfig $interface | grep ether)
end

function spoof_mac
  set -l interface en0
  set -l random_mac (openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
  sudo ifconfig $interface ether $random_mac
  echo "Interface:" $interface
  echo "MAC:" (ifconfig $interface | grep ether)
end

function renew_ip
  set -l interface en0
  sudo ifconfig $interface down
  sudo ifconfig $interface up
  # sudo ipconfig set en0 BOOTP
  # sudo ipconfig set en0 DHCP
end

function set_hostname
  set -l name "NIMBUS"
  sudo scutil --set HostName $name
  sudo scutil --set LocalHostName $name
  sudo scutil --set ComputerName $name
  dscacheutil -flushcache
end
