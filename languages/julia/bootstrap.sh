DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -sf $DIR/config/juno_startup.jl $HOME/.julia/config/
ln -sf $DIR/config/startup_ijulia.jl $HOME/.julia/config/
ln -sf $DIR/config/startup.jl $HOME/.julia/config/

