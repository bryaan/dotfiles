################################################
# Network Performance
################################################

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast #
# alias fastping='ping -c 100 -s.2' # Linux
alias fastping='ping -c 100 -i .2' # Mac

# Show open ports.
alias ports='netstat -tulanp'

################################################
# iptables - Routing /Firewall
################################################

if [ $__BRYDOTS_ENV_PLATFORM = "linux" ]

  ## shortcut  for iptables and pass it via sudo#
  alias ipt='sudo /sbin/iptables'

  # display all rules #
  alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
  alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
  alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
  alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
  alias firewall=iptlist

end
#################################################
#  ss - Socket Statistics
#################################################

# By default only CONNECTED sockets will show
# with `-a` both CONNECTED and LISTENING will show.
abbr -a ss.tcp 'ss -A tcp'
abbr -a ss.udp 'ss -a -A udp'
abbr -a ss.unix 'ss -A unix'
abbr -a ss.tcp.listening 'ss -ltn'
abbr -a ss.udp.listening 'ss -lun'
