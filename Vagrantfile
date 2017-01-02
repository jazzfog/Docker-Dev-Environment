Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", path: "provision/init.sh"

  # php-fpm fails to start before /vagrant dir is mounted so need to restart docker container
  config.vm.provision "shell", inline: "su -c 'cd /vagrant && docker-compose stop && sleep 3 && docker-compose up -d' vagrant", run: "always"

  config.vm.network "private_network", ip: "192.168.55.55"

  config.vm.provider "virtualbox" do |v|
  
    v.name = "Web Dev Server - Docker (GitHub)"
	v.customize ["modifyvm", :id, "--memory", "2000"]
	v.cpus = 2

	# making sure host OS is used as a name server
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

  end

  #====================================================================================================================================================
  # Shared folders

  # Mounting folders with standard sharing:
  config.vm.synced_folder "./", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
  config.vm.synced_folder "./www", "/www", :mount_options => ["dmode=777","fmode=777"]

  # Mac OSX and Windows with `winnfsd` plugin (https://github.com/winnfsd/vagrant-winnfsd) can use these folders
  # Uncomment if you need
  # config.vm.synced_folder ".", "/vagrant_nfs", type: "nfs"
  # config.vm.synced_folder "./www", "/www_nfs", type: "nfs"

  #====================================================================================================================================================

end