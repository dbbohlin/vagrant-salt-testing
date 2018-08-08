# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ubuntu = "bento/ubuntu-16.04"
  centos = "centos/6"
  centos7 = "centos/7"
  net_ip = "192.168.50"
  master = "test-master"
  minionName = "test-minion"
  minionKeyName = "test-minion"

  config.vm.define "#{master}", primary: true do |master_config|
    master_config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 1
        vb.name = "#{master}"
    end
      master_config.vm.box = "#{ubuntu}"
      master_config.vm.host_name = 'saltmaster.local'
      master_config.vm.network "private_network", ip: "#{net_ip}.10"
      master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
      master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"

      master_config.vm.provision :salt do |salt|
        salt.master_config = "saltstack/etc/master"
        salt.master_key = "saltstack/keys/master_minion.pem"
        salt.master_pub = "saltstack/keys/master_minion.pub"
        salt.minion_key = "saltstack/keys/master_minion.pem"
        salt.minion_pub = "saltstack/keys/master_minion.pub"
        salt.seed_master = {
                            "#{minionName}1" => "saltstack/keys/#{minionKeyName}1.pub",
                            "#{minionName}2" => "saltstack/keys/#{minionKeyName}2.pub",
                            "#{minionName}3" => "saltstack/keys/#{minionKeyName}3.pub",
                            "#{minionName}4" => "saltstack/keys/#{minionKeyName}4.pub"
                           }
        salt.install_type = "stable"
        salt.install_master = true
        salt.no_minion = true
        salt.verbose = true
        salt.colorize = true
        salt.bootstrap_options = "-P -c /tmp"
      end
    end

    [
      ["#{minionName}1",    "#{net_ip}.11",    "1024",    centos7 ],
      ["#{minionName}2",    "#{net_ip}.12",    "1024",    centos7 ],
      ["#{minionName}3",    "#{net_ip}.13",    "1024",    centos7 ],
      ["#{minionName}4",    "#{net_ip}.14",    "1024",    centos7 ],
    ].each do |vmname,ip,mem,os|
      config.vm.define "#{vmname}" do |minion_config|
        minion_config.vm.provider "virtualbox" do |vb|
            vb.memory = "#{mem}"
            vb.cpus = 1
            vb.name = "#{vmname}"
        end
        minion_config.vm.box = "#{os}"
        minion_config.vm.hostname = "#{vmname}"
        minion_config.vm.network "private_network", ip: "#{ip}"

        minion_config.vm.provision :salt do |salt|
          salt.minion_config = "saltstack/etc/#{vmname}"
          salt.minion_key = "saltstack/keys/#{vmname}.pem"
          salt.minion_pub = "saltstack/keys/#{vmname}.pub"
          salt.install_type = "stable"
          salt.verbose = true
          salt.colorize = true
          salt.bootstrap_options = "-P -c /tmp"
        end
      end
    end
  end
#  master_config.vm.provision :shell, :inline => "salt-key -A", run: "always"