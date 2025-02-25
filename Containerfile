# Needs to be built on an entitled RHEL 9 system
FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036

USER 0

# No more ansible-core?????
#RUN dnf update -y && dnf install -y git wget nmstate tar ansible-core

RUN dnf update -y && dnf install -y git wget nmstate tar python3-pip \
 && python3 -m pip install ansible jmespath nmstate

RUN wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-install-linux.tar.gz \
 && tar zxvf openshift-install-linux-amd64.tar.gz \
 && wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz \
 && tar zxvf openshift-client-linux.tar.gz \
 && rm openshift-client-linux.tar.gz openshift-install-linux.tar.gz \
 && chmod a+x oc kubectl openshift-install \
 && mv oc kubectl openshift-install /usr/local/bin/
