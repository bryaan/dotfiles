####################################################
# System Perf
####################################################

# Replace htop with glances for now. (learning cmd name)
alias top='glances'
alias htop='glances'

# TODO check what ps -f option is on linux to copy here.
{% if os.mac %}

  function psmem
    ps aux | sort -nr -k 3 | head -1
  end
  function psmem10
    ps aux | sort -nr -k 3 | head -10
  end
  function pscpu
    ps aux | sort -nr -k 3 | head -1
  end
  function pscpu10
    ps aux | sort -nr -k 3 | head -10
  end

{% endif %}

# TODO Turn alias -> function
{% if os.linux %}

  ## pass options to free ##
  alias meminfo='free -m -l -t'

  ## get top process eating memory
  alias psmem='ps auxf | sort -nr -k 4'
  alias psmem10='ps auxf | sort -nr -k 4 | head -10'

  ## get top process eating cpu ##
  alias pscpu='ps auxf | sort -nr -k 3'
  alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

  ## Get server cpu info ##
  alias cpuinfo='lscpu'

  ## older system use /proc/cpuinfo ##
  ##alias cpuinfo='less /proc/cpuinfo' ##

  ## get GPU ram on desktop / laptop##
  alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

{% endif %}

####################################################
# Network Performance
####################################################

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast #
# alias fastping='ping -c 100 -s.2' # Linux
alias fastping='ping -c 100 -i .2' # Mac

# Show open ports.
alias ports='netstat -tulanp'



