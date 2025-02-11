# Improvements or Considerations

## Security

Running BIND9 as root (BIND9_USER=root) could pose a security risk, depending on the environment. It's generally recommended to run network services as non-root users to limit potential damage in the event of a security breach.

## Backup Strategy

Ensure proper backup mechanisms are in place for the critical DNS configuration and zone files (located in /etc/bind, /var/cache/bind, and /var/lib/bind).

## Volume Creation

Before running docker-compose up, ensure that the external volumes (ns1_config, ns1_cache, and ns1_records) and the macvlan255 network have been pre-created, as Docker will not create them automatically.
