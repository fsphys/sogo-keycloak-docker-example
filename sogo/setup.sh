#!/bin/sh

sogo_conf=/etc/sogo/sogo.conf

# Changes placeholders in /etc/sogo/sogo.conf to actual credentials
# usage: replace_token <token> <replacement>
replace_token() {
    if grep "$1" "$sogo_conf"; then
        sed -i "s/$1/$2/" "$sogo_conf"
    fi
}

replace_token DB_USER "$DB_USER"
replace_token DB_PASS "$DB_PASSWORD"
replace_token BIND_PASS "$LDAP_BIND_PASSWORD"
replace_token HOST_NAME "$HOST_NAME"

chown sogo:sogo "$sogo_conf"

su sogo -c "sogod -WONoDetach YES -WOPort 0.0.0.0:20000"
