FROM php:7.1-fpm
MAINTAINER Fog

# Install programs
RUN \
	apt-get update && \
	apt-get install -y imagemagick git wget curl zlib1g-dev && \

	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions
RUN \
	docker-php-ext-install pdo_mysql && \
	docker-php-ext-install zip && \
	docker-php-ext-install sockets && \
	pecl install redis && docker-php-ext-enable redis

# Install Composer
RUN \
	wget https://getcomposer.org/installer -O composer-setup.php && \
	php composer-setup.php --install-dir=/bin --filename=composer && \
	rm composer-setup.php && \
	mkdir /var/www/.composer && \
	chown www-data /var/www/.composer -Rv

# Install Node and NPM
RUN \
	curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
	apt-get install -y nodejs

# Install Bower
RUN \
	npm install -g bower && \
	mkdir /var/www/.config && \
	mkdir /var/www/.cache && \
	mkdir /var/www/.local && \
	chown www-data /var/www/.config -Rv && \
	chown www-data /var/www/.cache -Rv && \
	chown www-data /var/www/.local -Rv

WORKDIR /www