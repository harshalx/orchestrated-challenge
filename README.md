# orchestrated-challenge

## Tools Used

### Packer
 Packer allows the ability to create immutable infrastructure. Both the webserver and appserver were installed and configured and then converted into AMI.This AMI is then used to create instances for bringing together the infrastructure. The following steps were taken to build the AMI

#### Webserver
* A Zip consisting of a sample HTML and JS was uploaded on S3. This sample codebase is then added to the htdocs of Apache Web Server.  This is then baked into the AMI. Ideally, the CI tools will be enhanced to run Packer and bake an image per application per build.
* The idea of immutable infra is that upgrades and installations on cloud platforms should not be done in a mutable way to reduce instances of misconfigurations and over use. Immutable infra demands that deployment or upgrade should have its own image and should spin a new instance everytime thereby ensuring repeatability and reliability.

#### Appserver
* Tomcat 8 was used as an app server of choice.
* A sample tomcat application (sample.war) file wsa uploaded on s3. 
* Packer builds an AMI out of this. 
* I would expect that the CI tools will be enhanced to deliver an image after a build. 

#### Improvements
 Since I used a simple use case of delivering an HTML and sample war file I did not use any configuration management tool. My tool of choice would be ansible. In a more complex scenario I would trigger ansible inside the provisioner block of Packer to install and configure the application.

### Terraform 
 Terraform was used to make the provisioning of infra to be cloud agnostic. It helps make provisioning as a declarative syntax and helps implementing infrastructure as code. In this instance I have used AWS as my choice of the cloud. This can be easily ported to different cloud environments with minimal efforts. 

* Terraform creates an autoscaling group (ASG) with 2 minimal and 4 max instances to ensure high availability and fault tolerance. This was once of the requirements mentioned in the challenge.
* The ASG can be scaled out horizontally to acheive split second performance. 
* an ELB is created for both Webserver and Appserver. Both the ELB are public facing at the moment. 

#### Improvements
* At the moment Apache Web Server isn't configured to route traffic to Tomcat. This is mentioned as a requirement in the challege and is easy to implement but I am not doing it due to delays already and lack of time. 
* I haven't implemented Prevayler as a DB too as I am just using a sample Tomcat off-the-shelf war file. 
* I have assumed that the networking setup at AWS is already present. The codebase can be improved to create VPC, Public and Private subnets and Internet Gateways.

### How to Run the codebase

* Install Terraform and Packer
* clone the git repo: git clone https://github.com/harshalx/orchestrated-challenge.git

## Build Images First 

* Update the AWS Access Key and AWS Scret Key in the packer/variables.json
* Run build_images.sh

## Build relevant infrastructure

* Update the AWS Access Key and AWS Scret Key in the terraform/variables.tf files.
* Update public subnets into elb_subnets variable.
* Update private subnets in instance_subnets variables. 
* Update your keypair name into keypair_name variable. 
* Update other variables appropriately. 
* Run buid_infra.sh <training/production>. Specify the right environment to create. 

## Teardown the infra

* Run teardown.sh <training/production>. Give the right env as input. Don't forget this. 




