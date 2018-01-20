###################################
# asdf
###################################

# TODO ~/.tool-versions move to version control.

{% if os.linux %}

  set -x ASDF_HOME $HOME/.asdf
  set -x ASDF_INSTALL_DIR $ASDF_HOME/installs

{% endif %}

{% if os.mac %}

  set -x ASDF_HOME /usr/local/opt/asdf
  # export ASDF_BIN=$ASDF_HOME/bin/asdf
  set -x ASDF_INSTALL_DIR $ASDF_HOME/installs

{% endif %}

# Only if asdf is installed...
if test -d $ASDF_HOME

  # Load asdf.
  source $ASDF_HOME/asdf.fish

  # Completions are installed automatically by brew.
  {% if os.linux %}
    source $ASDF_HOME/completions/asdf.fish
  {% endif %}

  # Disabled bc: it is added by the script above on macos.
  # This is why we dont need to add $GOROOT/bin to PATH!!
  # go, godoc, gofmt are all located here.
  # they are linked to the current active version.
  # append_path /usr/local/opt/asdf/shims
end


###################################
# golang
###################################

{% if os.mac %}

# # TODO this fun does not work. bc asdf adds mutiple golang varsion to this file..
# # TODO Use .tool-versions instead.
# function get_asdf_global_golang_path
#
#   # T O D O Check that the ASDF env vars are set.
#   # bc may happen that command gets used before asdf vars are readyy.
#
#   set -l file ~/.tool-versions
#
#   # sed '3q;d' file - select line 3 of file
#   # perl exp - select #.# or #.#.#
#   set -l go_version (sed '3q;d' $file | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
#
#   echo $ASDF_INSTALL_DIR/golang/$go_version
# end
#
# # Parent dir of where go binaries are at.
# set -x GOROOT (get_asdf_global_golang_path)/go

# Location of my private go packages.
# Make it a colon seperated list of local project paths.
# Most of the time we will be using a local version anyway.
# This is more for when you want to use the binary system wide.
# export GOPATH_LOCAL=

# Location for any 3rd party forked go repos.
# This does not need to be associated with golang version.
# I guess its compiled on `go get` with whatever version is on path.
# set -x GOPATH_PUBLIC $HOME/go

# The GOPATH environment variable lists places to look for Go code.
# First path is where files are installed on `go get`.
# export GOPATH=$GOPATH_LOCAL:$GOPATH_PUBLIC
# set -x GOPATH '' #$GOPATH_PUBLIC

# # Use golang installed with brew.
# # brew install go --cross-compile-common
# GOPATH_PUBLIC=$HOME/golang
# export GOROOT=/usr/local/opt/go/libexec

# Add each one's bin directory to PATH.
# append_path $GOPATH_LOCAL/bin
# append_path $GOPATH_PUBLIC/bin
# append_path $GOROOT/bin

{% endif %}


# When asdf is managing golang a GOROOT is not neccessary!
# linux - almost verfied
# mac - not sure yet
# set -x GOROOT ''

# Where public go packages go.
set -x GOPATH "$HOME/go"

# # Add each one's bin directory to PATH.
set -x PATH "$GOPATH/bin" $PATH
# set -x PATH "$GOROOT/bin" $PATH
