
{% if os.linux %}

####################################################
# IpTables
####################################################

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

{% endif %}


alias gpg-decrypt-clipboard='xclip -o | gpg --decrypt | xclip'



# Cryptographic Hashes
alias sha1='openssl sha1'

