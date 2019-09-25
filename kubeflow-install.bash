#! /bin/bash

set -e
set -x

export OPSYS=linux

mkdir bin
pushd bin
curl -s https://api.github.com/repos/kubeflow/kubeflow/releases/latest | grep browser_download | grep $OPSYS | cut -d '"' -f 4 | xargs curl -O -L &&  tar -zvxf kfctl_*_${OPSYS}.tar.gz
export PATH=$PATH:$PWD
popd

export KFAPP="kf-poc"
export VERSION=$(curl -s https://api.github.com/repos/kubeflow/kubeflow/releases/latest |    grep tag_name | head -1 | cut -d '"' -f 4)
export CONFIG="https://raw.githubusercontent.com/kubeflow/kubeflow/${VERSION}/bootstrap/config/kfctl_k8s_istio.yaml"
kfctl init ${KFAPP} --config=${CONFIG} -V
cd ${KFAPP}
kfctl generate all -V
kfctl apply all -V
