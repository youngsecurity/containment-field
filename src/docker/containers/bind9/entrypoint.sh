#!/bin/bash
set -e

# Adjust ownership
chown -R bind:bind /var/cache/bind

# Start BIND9
#exec /usr/sbin/named -f -u bind