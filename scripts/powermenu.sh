#!/usr/bin/env bash


# So that when a command fails, bash exits.
set -o errexit

# This will make the script fail, when accessing an unset variable.
set -o nounset

# the return value of a pipeline is the value of the last (rightmost) command
# to exit with a non-zero status, or zero if all commands in the pipeline exit
# successfully.
set -o pipefail

# This helps in debugging your scripts. TRACE=1 ./script.sh
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi



if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./powermenu.sh

Bash script to shutdown or lock the computer.

'
    exit
fi

cd "$(dirname "$0")"

powermenu() {
	local options="Cancel\nShutdown\nRestart\nSleep\nLock"
	local selected=$(echo -e $options | dmenu)
	if [[ $selected == "Shutdown" ]]; then
		poweroff
	elif [[ $selected == "Restart" ]]; then
		reboot
	elif [[ $selected == "Sleep" ]]; then
		systemctl suspend
	elif [[ $selected == "Lock" ]]; then
		slock
	fi
}

main() {
    powermenu
}

main "$@"

