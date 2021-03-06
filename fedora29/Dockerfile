FROM fedora:29
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
ADD dnf-transaction.txt /tmp/dnf-transaction.txt

# Install OS packages
RUN dnf -y --nodocs shell /tmp/dnf-transaction.txt && \
      dnf builddep -y kernel && \
      dnf clean all && \
      rm -fv /tmp/dnf-transaction.txt

# Install python packages
RUN pip2 install -U pip setuptools virtualenv
RUN dnf -y reinstall python3-pip
RUN pip3 install -U pip setuptools virtualenv

# Add CA certificate
ADD rh-ca.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

# krbV.Krb5Error: (-1765328160, 'Configuration file does not specify default realm')
RUN sed -i 's@.*default_realm.*@    default_realm = REDHAT.COM@g' /etc/krb5.conf

# Ensure that we always use UTF-8 and with American English locale
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8 || true

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# For supporting arbitrary user IDs
ADD uid2passwd /usr/local/bin/uid2passwd
RUN chmod g=u /etc/passwd
ENTRYPOINT [ "/usr/local/bin/uid2passwd" ]
USER 1001
