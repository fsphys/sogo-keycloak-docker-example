#!/bin/sh

[ -f admin-user-exists.empty ] || bin/add-user-keycloak.sh -r master -u admin -p $ADMIN_PASSWORD

bin/standalone.sh -b 0.0.0.0
