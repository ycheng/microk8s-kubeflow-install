#! /bin/bash

set -x
set -e

sudo snap install microk8s --classic

sudo microk8s.status --wait-ready
sudo microk8s.kubectl config view --raw | sudo tee -a $HOME/.kube/config
sudo -E chown -R `id -nu`.`id -ng` $HOME/.kube

sudo microk8s.enable dns storage dashboard
sudo microk8s.status --wait-ready
sudo snap alias microk8s.kubectl kubectl

sudo usermod -a -G microk8s `id -nu`

echo You are added to group microk8s, so please logout and login so it works.
echo Done
