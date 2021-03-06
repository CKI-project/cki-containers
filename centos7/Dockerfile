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

# krbV.Krb5Error: (-1765328160, 'Configuration file does not specify default realm')
RUN sed -i 's@.*default_realm.*@ default_realm = REDHAT.COM@g' /etc/krb5.conf

# pip3 support
RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

# Ensure that we always use UTF-8 and with American English locale
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# For supporting arbitrary user IDs
ADD uid2passwd /usr/local/bin/uid2passwd
RUN chmod g=u /etc/passwd
ENTRYPOINT [ "/usr/local/bin/uid2passwd" ]
USER 1001
