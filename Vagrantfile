# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-17.04"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.synced_folder "./site", "/var/www/sites/drupal7.dev/www"
  config.vm.provision "shell",
    inline: "/vagrant_data/provisioner.sh"
end
