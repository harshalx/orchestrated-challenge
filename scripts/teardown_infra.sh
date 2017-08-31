#! /bin/bash

cd ../terraform
terraform destroy -state=$1.state
