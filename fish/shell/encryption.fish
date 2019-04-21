# TODO rename passwords.tpl or encryption.tpl ??


alias gpg-decrypt-clipboard='xclip -o | gpg --decrypt | xclip'


# Cryptographic Hashes
alias sha1='openssl sha1'


function fpass -d "Fuzzy-find a Lastpass entry and copy the password"
  if not lpass status -q
    lpass login $EMAIL
  end

  if not lpass status -q
    exit
  end

  lpass ls | fzf | string replace -r -a '.+\[id: (\d+)\]' '$1' | xargs lpass show -c --password
end
