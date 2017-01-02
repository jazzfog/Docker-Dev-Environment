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
it ip `192.168.55.55` and install Docker. It will take some time for first time since Docker needs to download base images and build custom ones)
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

##### MySQL

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

##### MongoDB

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