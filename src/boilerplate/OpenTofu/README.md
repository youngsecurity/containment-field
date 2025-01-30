# OpenTofu

## About

OpenTofu is an infrastructure as code tool that lets you define infrastructure resources in human-readable configuration files that you can version, reuse, and share. You can then use a consistent workflow to safely and efficiently provision and manage your infrastructure throughout its lifecycle.

This page describes popular OpenTofu use cases and provides related resources that you can use to create OpenTofu configurations and workflows.

## Source
https://opentofu.org/docs/intro/install/docker/

`docker pull ghcr.io/opentofu/opentofu:latest`

`docker pull ghcr.io/opentofu/opentofu:1.9.0-amd64`

## To run OpenTofu as a Docker container:

```
# Init providers plugins
docker run \
    --workdir=/srv/workspace \
    --mount type=bind,source=.,target=/srv/workspace \
    ghcr.io/opentofu/opentofu:latest \
    init

# Creating plan file
docker run \
    --workdir=/srv/workspace \
    --mount type=bind,source=.,target=/srv/workspace \
    ghcr.io/opentofu/opentofu:latest \
    plan -out=main.plan

# Applying plan file
docker run \
    --workdir=/srv/workspace \
    --mount type=bind,source=.,target=/srv/workspace \
    ghcr.io/opentofu/opentofu:latest \
    apply "/srv/workspace/main.plan"
```

## [Building your own image](https://opentofu.org/docs/intro/install/docker/#building-your-own-image)
