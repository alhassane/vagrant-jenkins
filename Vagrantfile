# -*- mode: ruby -*-
# vi: set ft=ruby :
 
# Requierements
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure('2') do |config|
    config.vm.box = 'ubuntu/trusty64'
    config.vm.box_url = 'https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/14.04/providers/virtualbox.box'

    # Create a private network, which allows host-only access to the machine using a specific IP.
    config.vm.network :private_network, ip: 192.168.33.30

    config.vm.synced_folder ".", "/vagrant", :mount_options => ["uid=5678,gid=65534"]

    config.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--memory', '1024', '--natdnsproxy1', 'on']
    end

    # Shell provisioning
    config.vm.provision "shell" do |s|
        s.path = "provisioners/shell/jenkins.sh"
        s.privileged = true
    end

    config.vbguest.auto_update = true
end


