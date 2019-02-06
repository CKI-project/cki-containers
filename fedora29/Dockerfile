FROM fedora:29
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
ADD dnf-transaction.txt /tmp/dnf-transaction.txt

# Install OS packages
RUN dnf -y --nodocs shell /tmp/dnf-transaction.txt && \
      dnf builddep -y kernel && \
      dnf clean all && \
      rm -fv /tmp/dnf-transaction.txt

# Install python packages
RUN pip2 install -U pip setuptools virtualenv && \
      pip3 install -U pip setuptools virtualenv

# Add CA certificate
ADD rh-ca.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

# krbV.Krb5Error: (-1765328160, 'Configuration file does not specify default realm')
RUN sed -i 's@.*default_realm.*@    default_realm = REDHAT.COM@g' /etc/krb5.conf

# Ensure that we always use UTF-8 and with American English locale
RUN locale-gen en_US.UTF-8

COPY ./default_locale /etc/default/locale
RUN chmod 0755 /etc/default/locale

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# For supporting arbitrary user IDs
ADD uid2passwd /usr/local/bin/uid2passwd
RUN chmod g=u /etc/passwd
ENTRYPOINT [ "/usr/local/bin/uid2passwd" ]
USER 1001
