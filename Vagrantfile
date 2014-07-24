# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #THE BOX:
  # NOTE: precise is approaching EOL.
  # http://wiki.ubuntu.com/1204_HWE_EOL
  # long story short, use trusty
  # config.vm.box = "ubuntu/precise32"
  config.vm.box = "ubuntu/trusty32"

  #HOSTNAME:
  config.vm.hostname = "vagrant.dev"

  #IP ADDRESS:
  config.vm.network "private_network", ip: "192.168.50.99"

  #Note: manually add this to host machine's /etc/hosts:
  #192.168.50.99   vagrant.dev

  #override
  config.vm.provider :virtualbox do |vb|
          vb.customize [ "modifyvm", :id, "--memory", 1024]
  end

  forward_port = ->(guest, host = guest) do
    config.vm.network :forwarded_port,
      guest: guest,
      host: host,
      auto_correct: true
  end

  #apache/mysql
  forward_port[1080]      # mailcatcher
  forward_port[3306,3308]      # mysql
  forward_port[80, 9014]  # nginx/apache

  #file permissions
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=666"]
  config.vm.synced_folder "~/Code", "/Code", :mount_options => ["dmode=777","fmode=666"]
  #config.vm.synced_folder "~/viviosoft", "/viviosoft", :mount_options => ["dmode=777","fmode=666"]


  #PROVISIONING:
  # 1.puppet:
#  config.vm.provision :puppet do |puppet|
#    puppet.manifests_path = "manifests"
#    puppet.manifest_file = "default.pp"
#  end

  # 2.bash
  config.vm.provision :shell, :path => "bootstrap.sh"
  # config.vm.provision :shell, :path => "project.sh"

end
