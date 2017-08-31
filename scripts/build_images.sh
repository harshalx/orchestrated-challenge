#! /bin/bash

#build webservre ami
#packer build -var-file=../packer/variables.json ../packer/ws_ami.json

#build app serverami
packer build -var-file=../packer/variables.json ../packer/as_ami.json


