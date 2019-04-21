function __sk_cd_backwards -d 'cd backwards'
  pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__skcmd) | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end
