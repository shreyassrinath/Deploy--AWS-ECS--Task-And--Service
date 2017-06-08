# Deploy AWS ECS Task and Service via Ansible

## Description

Automated deployment of ECS task and service to pre existing AWS ECS cluster using Ansible. 

### Architecture

![Alt](/resources/AWS-ECS-Deploy.jpg "Architecture Diagram")

### Definitions

#### What is Amazon EC2 Container Service?

Amazon EC2 Container Service (Amazon ECS) is a highly scalable, fast, container management service that makes it easy to run, stop, and manage Docker containers on a cluster of Amazon Elastic Compute Cloud (Amazon EC2) instances. 

#### What is Task Definition?

To prepare your application to run on Amazon ECS, you create a task definition. The task definition is a text file in JSON format that describes one or more containers that form your application. It can be thought of as a blueprint for your application.

#### What are Clusters?

When you run tasks using Amazon ECS, you place them on a cluster, which is a logical grouping of EC2 instances.

#### What is Container Agent?

The container agent runs on each instance within an Amazon ECS cluster. It sends information about the instance's current running tasks and resource utilization to Amazon ECS, and starts and stops tasks whenever it receives a request from Amazon ECS. 

#### What is a AWS ECS Service?

Amazon ECS allows you to run and maintain a specified number (the "desired count") of instances of a task definition simultaneously in an ECS cluster. This is called a service. If any of your tasks should fail or stop for any reason, the Amazon ECS service scheduler launches another instance of your task definition to replace it and maintain the desired count of tasks in the service.

#### What is [Ansible](https://github.com/ansible/ansible)?

Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your applications— automate in a language that approaches plain English, using SSH, with no agents to install on remote systems.

## Installation requirements

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html)
* Clone this repo

## Commands

Start:

`$ vagrant up`

This does the following:

* Copies AWS credentials from host to VM
* Installs [Ansible](https://www.ansible.com/)
* Backs up Ansible hosts file and updates with the one that is provided with the repo.
* Gathers SSH public keys by executing ssh-keyscan on localhost.
* Installs python-pip and necessary aws packages.

SSH into the server

`$ vagrant ssh`

### Establish SSH trust

In order to establish password less access to nodes(and host) we need to establish SSH trust. The ssh-addkey.yml playbook will be used to acheive that objective. We are using the authorized_key module here. It is a module, which will help us configure ssh password less logins on remote machines. We tell the authorized_key module, that we want to add an authorized_key to the remote vagrant user, we define where on the management node we should lookup the key file from, then we make sure it exists on the remote machine.

Check to make sure we do not have public RSA key.   
`$ ls -l .ssh/`

We will create a RSA key by the following command

`$ ssh-keygen -t rsa -b 2048`

Check to make sure we have the id_rsa.pub file present as specified in the ssh-addkey.yml playbook.

Run the ansible play book - ssh-addkey.yml with ask pass option to make sure we are deploying the key to all machines- in this case there is only one machine- localhost.

`$ ansible-playbook ssh-addkey.yml --ask-pass`

Now try the ansible ping module to ping the local server with the ask password option.

`$ ansible all -m ping`

This is should provide the following output.

```
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```
### Deploy ECS task and service to AWS ECS cluster

Cd to playbooks directory

`$ cd /deploytoECS/playbooks`

Run the ansible playbook to deploy Wordpress website to ECS task and start a service

`$ ansible-playbook deploy-ecs-task\&service.yml`

This does the following: 

* Creates a task definition using wordpress and mysql docker images 
* Creates a ECS service in pre existing cluster(update cluster name in deploy-ecs-task&service.yml file in the "set_fact" task).


## Reference
[AWS ECS](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
[ECS services](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html)