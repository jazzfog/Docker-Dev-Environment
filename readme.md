# Docker-based development environment

Features

- PHP 7.1 + Nginx + Composer, Bower, NPM (for newer projects)
- PHP 5.4 + Apache (for older projects)
- Node.js 7
- MongoDB
- MySQL (MariaDB)
- Redis

You can run docker-compose on your local machine, but I recommend to run it within 
virtual machine, in this way it will not interfere with your host machine setup.

## Prerequisites
- [VirtualBox](https://www.virtualbox.org/) for virtualization
- [Vagrant](https://www.vagrantup.com/) for provisioning

...or [Docker](https://www.docker.com) on your host machine.

## Install and run

- Checkout repository or download and unpack ZIP archive
- Run `vagrant up` from project directory. Vagrant will create a virtual machine, assign 
it ip `192.168.55.55` and install Docker. This step may take some time for first time (depending on your host machine performance and network bandwidth) since Docker needs to download base images and build custom ones)
- Meanwhile you need to add test domains to your [hosts file](https://www.google.com/search?q=what%20is%20hosts%20file)

```
192.168.55.55 php7nginxHost.local
192.168.55.55 php54apacheHost.local
192.168.55.55 nodeWelcomeApp.local
```

- Open one of the URLs (you *may* need to restart your browser)
	- http://php7nginxHost.local - PHP7 and Nginx 
	- http://php54apacheHost.local - Apache + PHP 5.4 (Reverse-proxied by Nginx)
	- http://nodeWelcomeApp.local - Node.js app (Reverse-proxied by Nginx)
	
- Add more PHP projects to Nginx or Apache config folders or Node apps 
to `docker-compose.yml` file or customize Node image.

To check containers - login to virtual machine - run `vagrant ssh` from project dir, then run `docker ps`.
To see logs run `docker logs -f <container-name>`

## Notes

#### MySQL

MySQL root password will be shown in stdout during first run. Look for `GENERATED ROOT PASSWORD: .....` 
If you missed it - just re-create mysql instance: (you may need to find image and container 
names with `docker ps -a` and `docker images`)
 
```
docker stop vagrant_mariadb_1
docker rm vagrant_mariadb_1
docker rmi fog/mariadb
sudo rm -rf ~/docker-data/mariadb
docker-compose up
```

#### MongoDB

Auth is enabled

When container is ready - manually create `userAdminAnyDatabase` user using `Localhost Exception`

https://docs.mongodb.com/manual/tutorial/enable-authentication/

And then users for databases

https://docs.mongodb.com/manual/tutorial/create-users/

*TL;DR*

```
mongo

use admin

db.createUser({ user: 'admin', pwd: '<password>', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });

mongo -u admin -p <password> --authenticationDatabase admin

use <db-name>

db.createUser({
	user: "<user-name>",
	pwd: "<userPassword>",
	roles: [
	   { role: "readWrite", db: "<db-name>" }
	]
});
```

#### Shared folders speed

If you concerned about shared folders speed (honestly, you should be) use [NFS](https://en.wikipedia.org/wiki/Network_File_System) for sharing your folders.

For example (making default folder available in VM under `/vagrant_nfs`):

    config.vm.network "private_network", type: "dhcp"
    config.vm.synced_folder ".", "/vagrant_nfs", type: "nfs"
    
Someone may say that it will not work on Windows (since [Vagrant official site says so](https://www.vagrantup.com/docs/synced-folders/nfs.html)) but it is not true, it woks with with [winnfsd](https://github.com/winnfsd/vagrant-winnfsd) plugin.



