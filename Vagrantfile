# -*- mode: ruby -*-
# vi: set ft=ruby :
 
# Load settings
personalization = File.expand_path("../provisioners/parameters", __FILE__)
load personalization
 
# Requierements
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure('2') do |config|
    # Setup box
    config.vm.box = $box_name
    config.vm.box_url = $box_url

    # Set Hostname
    config.vm.host_name = $vm_hostname

    # Set the default project share
    config.vm.synced_folder ".",  $vm_group, id: "vagrant-root", :nfs => true
    config.vm.synced_folder "./", $vm_www_point, create: false, type: "nfs"

    config.vm.network "forwarded_port", guest: 9000, host: 9000
 
    # Configure Virtualbox
    config.vm.provider "virtualbox" do |v|
      v.gui = $vm_gui
      v.name = $vm_name
      #v.name = (0...8).map { (65 + rand(26)).chr }.join
      v.customize ["modifyvm", :id, "--groups",          $vm_group,
                                    "--cpuexecutioncap", $vm_cpu_cap,
                                    "--memory",          $vm_memory,
                                    "--cpus",            $vm_cpus]
    end

    # Create a private network, which allows host-only access to the machine using a specific IP.
    config.vm.network :private_network, ip: $vm_ip

    # Shell provisioning
    config.vm.provision "shell" do |s|
        s.path = "provisioners/shell/bootstrap.sh"
        s.args = ["ubuntu"]
        s.privileged = true
    end

    #config.vbguest.auto_update = true
end


