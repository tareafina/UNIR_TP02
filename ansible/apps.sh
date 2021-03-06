#!/bin/bash
## Parametros esperados  POSICIONALES 
## 1 -  IP 
## 2 -  nodename
## 3 -  tipo de nodo
#
echo -e "[all]\n$1\n" > /tmp/playbooks/hosts
cd  /tmp/playbooks/
export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -u jdobla -i hosts $3.yaml --extra-vars="node=$2 stage=azure"