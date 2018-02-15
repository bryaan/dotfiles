oh-shit-git.md

### Change from git HTTPS to SSH

[bryan@nclhp02647 ncl-com]$ git remote -v
origin  https://github.nclmiami.ncl.com/ncl/ncl-com.git (fetch)
origin  https://github.nclmiami.ncl.com/ncl/ncl-com.git (push)
[bryan@nclhp02647 ncl-com]$ git remote set-url origin git@github.nclmiami.ncl.com:ncl/ncl-com.git
[bryan@nclhp02647 ncl-com]$ git remote -v
origin  git@github.nclmiami.ncl.com:ncl/ncl-com.git (fetch)
origin  git@github.nclmiami.ncl.com:ncl/ncl-com.git (push)
[bryan@nclhp02647 ncl-com]$ 



