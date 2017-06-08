# Install Ansible and backup hosts file
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
sudo mv /etc/ansible/hosts /etc/ansible/hosts.orig
sudo cp -rf /home/vagrant/deploytoECS/template/hosts /etc/ansible/hosts
sudo ssh-keyscan localhost >>.ssh/known_hosts
sudo apt-get -y install python-pip
sudo pip install awscli boto3 boto botocore