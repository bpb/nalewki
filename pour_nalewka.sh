#!/bin/bash

###############################################################################
# This script accepts one argument (python, go, rust, scala, or java) and
# executes another script or displays a placeholder message.
#
# Only the "python" case is currently implemented; the others are placeholders
# and will be added at a later date.
#
# Usage:
#   ./pour-nalewka.sh python
#
# Available arguments: python, go, rust, scala, java
###############################################################################

# Default: verbosity off
VERBOSE=0

# Parse options (currently only -v is supported)
while getopts "v" opt; do
	case "$opt" in
	v)
		VERBOSE=1
		;;
	*)
		echo "Usage: $0 [-v] <python|go|rust|scala|java>"
		exit 1
		;;
	esac
done

# Shift past the parsed options so $1 now contains the language argument
shift $((OPTIND - 1))

# Check if exactly one argument was provided.
if [ $# -ne 1 ]; then
	echo "Error: You must supply exactly one argument."
	echo "Usage: $0 [-v] <python|go|rust|scala|java>"
	exit 1
fi

# Store the argument in a variable for easier usage.
LANGUAGE=$1

# Use a case statement to decide which action to take.
case "$LANGUAGE" in
python)
	# Currently implemented
	echo "Pouring nalewka for Python..."
	if [ $VERBOSE -eq 1 ]; then
		# Verbose Execution
		./python-project/project_init.sh -v

	else
		# Normal execution
		./python-project/project_init.sh
	fi
	;;
go)
	# Placeholder for future implementation
	echo "Go support is not yet implemented."
	;;
rust)
	# Placeholder for future implementation
	echo "Rust support is not yet implemented."
	;;
scala)
	# Placeholder for future implementation
	echo "Scala support is not yet implemented."
	;;
java)
	# Placeholder for future implementation
	echo "Java support is not yet implemented."
	;;
*)
	# Handle unknown arguments
	echo "Error: Invalid option."
	echo "Valid arguments are: python, go, rust, scala, java."
	exit 1
	;;
esac

exit 0
