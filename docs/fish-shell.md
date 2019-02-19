fish-shell.md


# Shortcuts

Fish:
Ctrl+S => sudo insert

Ctrl-A => Home button
Ctrl-E => End Button

RightArrow or Tab: To autcomplete cmd.
Ctrl+RightArrow: To autocomplete word by word.

Note that erasing from history doesn't require bash shenanigans:

history --delete --prefix some_command
fish_config history also lets you do it by point-n-click.


#

When defining 'private' functions:
instead of namespacing them, just append a __ if they are to be used only in file
and single _ if 'protected'

When defining 'protected' env vars
prefix with __BRYDOTS_FOO_BAR



# Knowledge Base

# Test if Variable is set

set -q var (note the missing "$" - this uses the variable name) can be used to check if a variable has been set.

set -q var[1] can be used to check whether the first element of a variable has been assigned (i.e. whether it is non-empty as a list).

test -n "$var" [fn0] (or [ -n "$var" ]) can be used to check whether a variable expands to a non-empty string (and test -z is the inverse - true if it is empty).






switch (hostname)
  case "dev-ncl*"
      set -gx __BRYDOTS_ENV_GEO 'work'
  case "*Linux*"
      set -gx __BRYDOTS_ENV_GEO '???'
end




function _should_do_one_shot_setup
  [ $__BRYDOTS_DO_ONE_SHOT_SETUP = 1 ]
end

if not set -q __BRYDOTS_DO_ONE_SHOT_SETUP
  echo "Performing One Shot Setup"
  set -gx __BRYDOTS_DO_ONE_SHOT_SETUP 1
end
