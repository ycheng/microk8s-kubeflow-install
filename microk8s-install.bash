#! /bin/bash

set -x
set -e

sudo snap install microk8s --classic
sudo microk8s.status --wait-ready
sudo microk8s.enable dns storage dashboard
sudo microk8s.status --wait-ready
sudo snap alias microk8s.kubectl kubectl

microk8s.kubectl config view --raw > $HOME/.kube/config

sudo usermod -a -G microk8s $USER
