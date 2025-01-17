# Needs to be built on an entitled RHEL 9 system
FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036

USER 0

RUN dnf update -y && dnf install -y git wget nmstate tar ansible-core

RUN wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-install-linux.tar.gz \
 && tar zxvf openshift-install-rhel9-amd64.tar.gz \
 && wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz \
 && tar zxvf openshift-client-linux.tar.gz \
 && rm openshift-client-linux.tar.gz openshift-install-linux.tar.gz \
 && chmod a+x oc kubectl openshift-install \
 && mv oc kubectl openshift-install /usr/local/bin/
