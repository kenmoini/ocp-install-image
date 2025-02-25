# OpenShift Install Image

This is a container image that has the OpenShift installer, Ansible, and other helpful binaries installed.  This allows the use outside of RHEL 9 systems.

## Build the Container

```
# Clone the repo
git clone https://github.com/kenmoini/ocp-install-image
cd ocp-install-image

# Build the container
podman build -t ocp-install -f Containerfile .

# [Optional] Build the container - FIPS installer
podman build -t ocp-install-fips -f Containerfile.fips .

# Tag/Push to an internal repo
podman tag ocp-install repo.example.com/library/ocp-install-tools:latest
podman push repo.example.com/library/ocp-install-tools:latest
```

## Use the Container

In case you're using this container for something like the [Agent Based Installer Automation](https://github.com/kenmoini/openshift-agent-install), then you could mount that inside the container and continue using the automation as expected:

```bash
# Clone base repo things if needed
git clone https://github.com/kenmoini/openshift-agent-install

# Run the container with the repo mounted
podman run --rm -it --name ocp-install \
  -v openshift-agent-install:/data \
  repo.example.com/library/ocp-install-tools:latest \
  /bin/bash

# Proceed to use as normal in the mounted /data directory
```
