#! /bin/bash

echo "variable \"env\" {
	default = \"$1\"
}" > ../terraform/env.tf

cd ../terraform
terraform apply -state=../terraform/$1.state
