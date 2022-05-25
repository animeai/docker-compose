#!/bin/sh
# Functions
function fail {
    printf '%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}
# Variables
check=$(sqlite variables.db "SELECT * FROM sqlite_master WHERE type = 'table'";)
main_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')

# Check this has not been run before
# sqlite variables.db "select * FROM passwords WHERE name = 'test');"
if [[ "$check" == *"adguardhome"* ]]; then
 fail "adguardhome table in variables.db exists - this installer should only be run once."
fi

# Set as installed
sqlite ../variables.db "create table adguardhome (name TEXT PRIMARY KEY, value TEXT, comment TEXT);"

# Insert the defaults
sqlite variables.db "insert into adguardhome (name,value,comment) values ('MAIN_NETWORK_ADAPTER', '$main_interface', 'The network adapter to use for private IPs with macvlan');"
sqlite variables.db "insert into adguardhome (name,value,comment) values ('', '', '');"