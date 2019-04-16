#! /bin/bash

# Update apt and get dependencies
DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y \
    unzip \
    curl \
    vim \
    apt-transport-https \
    ca-certificates \
    software-properties-common


# Download Nomad
NOMAD_VERSION=0.8.7
CONSUL_VERSION=1.4.3

cd /tmp/

cp /vagrant/binaries/nomad.zip nomad.zip
cp /vagrant/binaries/consul.zip consul.zip
cp /vagrant/binaries/vault.zip vault.zip

echo "Installing Consul..."
unzip /tmp/consul.zip
sudo install consul /usr/bin/consul

echo "Installing Vault..."
unzip /tmp/vault.zip
sudo install vault /usr/bin/vault

echo "Installing Nomad..."
unzip nomad.zip
sudo install nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

nomad -autocomplete-install



echo "Installing Docker..."
sudo dpkg -i /vagrant/binaries/containerd.io_1.2.4-1_amd64.deb
sudo dpkg -i /vagrant/binaries/docker-ce-cli_18.09.3~3-0~ubuntu-xenial_amd64.deb
sudo dpkg -i /vagrant/binaries/docker-ce_18.09.3~3-0~ubuntu-xenial_amd64.deb

# Restart docker to make sure we get the latest version of the daemon if there is an upgrade
sudo service docker restart

# Make sure we can actually use docker as the vagrant user
sudo usermod -aG docker vagrant



echo "Installing dotnet core..."

sudo dpkg -i /vagrant/binaries/packages-microsoft-prod.deb

sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install aspnetcore-runtime-2.2 -y



echo "Installing SSL stuff..."
for bin in cfssl cfssl-certinfo cfssljson
do
    sudo install /vagrant/binaries/${bin} /usr/local/bin/${bin}
done
