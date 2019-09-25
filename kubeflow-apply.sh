#! /bin/bash

set -e
set -x

export PATH=$PATH:$PWD/bin
export KFAPP="kf-poc"

if ! [ -e bin/kfctl ]; then
  gzip -dc bin/kfctl_v0.6.2.gz > bin/kfctl
  chmod +x bin/kfctl
fi

cd ${KFAPP}
kfctl apply all -V
