#!/bin/bash -x
set -e

CPU_SHARES=$(cat /sys/fs/cgroup/cpu/cpu.shares)
export MAKE_JOBS=$(expr $CPU_SHARES / 1024)

# Install OS packages
yum -y install epel-release
yum -y shell /tmp/yum-transaction.txt
yum-builddep -y kernel
yum clean all
rm -rf /var/cache/yum
rm -fv /tmp/yum-transaction.txt

# Install git
mkdir /tmp/git
pushd /tmp/git
  wget -q https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.19.0.tar.xz
  tar xf git-2.19.0.tar.xz
  pushd git-2.19.0
    make configure
    ./configure
    make -j${MAKE_JOBS} all
    make install
  popd
popd
rm -rf /tmp/git
