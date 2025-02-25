# Needs to be built on an entitled RHEL 9 system
FROM registry.access.redhat.com/ubi9/ubi:9.5-1736404036

USER 0

# No more ansible-core?????
#RUN dnf update -y && dnf install -y git wget nmstate tar ansible-core

RUN dnf update -y && dnf install -y git wget nmstate tar jq python3-pip python3-devel nano \
 && python3 -m pip install ansible jmespath nmstate \
 && ansible-galaxy collection install community.general \
 && ansible-galaxy collection install community.crypto \
 && dnf clean all \
 && rm -rf /var/cache/yum

RUN mkdir -p /tmp/bintmp \
 && cd /tmp/bintmp \
 && wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-install-linux.tar.gz \
 && tar zxvf openshift-install-linux.tar.gz \
 && wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz \
 && tar zxvf openshift-client-linux.tar.gz \
 && chmod a+x oc kubectl openshift-install \
 && mv oc kubectl openshift-install /usr/local/bin/ \
 && cd / \
 && rmdir -rf /tmp/bintmp
