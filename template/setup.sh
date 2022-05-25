#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}
# Variables
check=$(sqlite variables.db "SELECT * FROM sqlite_master WHERE type = 'table'";)

# Check this has not been run before
# sqlite variables.db "select * FROM passwords WHERE name = 'test');"
if [[ "$check" == *"replaceme"* ]]; then
 fail "replaceme table in variables.db exists - this installer should only be run once."
fi

# 