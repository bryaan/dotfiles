function __sk_reverse_isearch
    history -z | eval (__skcmd) --read0 -q '(commandline)' | perl -pe 'chomp if eof' | read -lz result
    and commandline -- $result
    commandline -f repaint
end
