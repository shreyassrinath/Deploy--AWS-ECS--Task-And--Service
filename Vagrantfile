# -*- mode: ruby -*-
# vi: set ft=ruby :
# See https://github.com/discourse/discourse/blob/master/docs/VAGRANT.md
#
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box= "ubuntu/trusty64"

  config.vm.network :private_network, ip: "192.168.33.35"  
  
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", "512"]
    v.customize ["modifyvm", :id, "--cpus", "1"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  config.vm.synced_folder ".", "/home/vagrant/deploytoECS",
    mount_options: ["dmode=775,fmode=664"]
  
  config.vm.provision "file", source: "config/.aws/credentials", destination: "~/.aws/credentials"
  # Install Ansible and backup hosts file
  config.vm.provision "shell",
    inline: "sudo apt-add-repository -y ppa:ansible/ansible"
  config.vm.provision "shell",
    inline: "sudo apt-get update"

  config.vm.provision "shell",
    inline: "sudo apt-get install -y ansible"
  config.vm.provision "shell",
    inline: "sudo mv /etc/ansible/hosts /etc/ansible/hosts.orig"
  config.vm.provision "shell",
    inline: "sudo cp -rf /home/vagrant/deploytoECS/hosts /etc/ansible/hosts"
  config.vm.provision "shell",
    inline: "sudo ssh-keyscan localhost >>.ssh/known_hosts"  
  config.vm.provision "shell",
    inline: "sudo apt-get -y install python-pip"
  config.vm.provision "shell",
    inline: "sudo pip install awscli boto3 boto botocore"
  
end