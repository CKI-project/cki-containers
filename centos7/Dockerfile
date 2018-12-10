FROM centos:7
LABEL io.k8s.description="CentOS 7 container for building kernels" \
      io.k8s.display-name="cki-centos7" \
      io.openshift.tags="cki-centos7"

# Install packages and other software
ADD yum-transaction.txt /tmp/yum-transaction.txt
ADD install-software.sh /tmp/install-software.sh
RUN /tmp/install-software.sh

# Clean up
RUN rm -fv /tmp/install-software.sh

# Install the basics for python packages
RUN pip install -U pip setuptools virtualenv

# Add CA certificate
ADD rh-ca.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

# For supporting arbitrary user IDs
ENV NSS_WRAPPER_PASSWD=/tmp/passwd NSS_WRAPPER_GROUP=/etc/group

RUN touch ${NSS_WRAPPER_PASSWD} && chgrp 0 ${NSS_WRAPPER_PASSWD} && chmod g+rw ${NSS_WRAPPER_PASSWD}

ADD passwd.template /passwd.template
ADD nss_wrapper /nss_wrapper

RUN adduser --gid 0 cki

USER cki

ENTRYPOINT ["/nss_wrapper"]
