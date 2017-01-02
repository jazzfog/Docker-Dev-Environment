FROM ubuntu:12.04
MAINTAINER Fog

RUN \

	apt-get update && \

	apt-get install -y python-software-properties && \
	add-apt-repository -y ppa:ondrej/php5-oldstable && \
	apt-get update && \

	apt-get install -y php5-cli php5-curl mysql-client php5-mysql php5-ldap php5-common  php5-memcache php5-memcached php5-xmlrpc php5-xsl && \
	apt-get install -y apache2 imagemagick libapache2-mod-php5 && \

	service apache2 restart && \

	a2enmod php5 && \
	a2enmod rewrite && \

	service apache2 restart && \

	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY httpd-foreground.sh /

EXPOSE 80

ENTRYPOINT ["/httpd-foreground.sh"]