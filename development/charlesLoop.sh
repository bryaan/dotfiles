#!/bin/bash

# Edit this if your path is different.
# Or just export `CHARLESPATH=...` from your devrc.
DEFAULT_CHARLESPATH=$HOME/bin/charles/bin/charles

# In case CHARLESPATH is already set in one of your devrcs.
if [[ -z $CHARLESPATH ]]; then
	CHARLESPATH=$DEFAULT_CHARLESPATH
fi

# Time just before the demo runs out - time to restart charles.
CHARLES_DEMO_TIMEOUT="25m"

# Exit charles just before the demo timer runs out.
# This way we don't need to click "ok" on dialoag.
while true; do
	printf "Starting Charles\n"

	# Will block here until charles exits or 29 minutes pass.
	timeout $CHARLES_DEMO_TIMEOUT $CHARLESPATH  2> /dev/null

	# Check exit code
	# X button used = 0
	# Timeout reached = 124
	exit_status=$?

	# We should exit loop when charles is exited with X button.
	if [ $exit_status -eq 0 ]; then
		printf "Stopping Charles\n"
		exit 0
	fi
done
