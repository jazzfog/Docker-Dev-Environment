FROM php:7.1-fpm
MAINTAINER Fog

# Remove image cmd
# docker stop vagrant_php_1 && docker rm vagrant_php_1 && docker rmi fog/php

COPY ./install_node.sh /

RUN \
	apt-get update && \
	apt-get install -y imagemagick git wget zlib1g-dev && \

	docker-php-ext-install pdo_mysql && \
	docker-php-ext-install zip && \
	pecl install redis && docker-php-ext-enable redis && \

	######################################################
	# Install Composer

	wget https://getcomposer.org/installer -O composer-setup.php && \
	php composer-setup.php --install-dir=/bin --filename=composer && \
	rm composer-setup.php && \
	mkdir /var/www/.composer && \
	chown www-data /var/www/.composer -Rv && \

	######################################################
	# Install Node and NPM

	. /install_node.sh && \
	mkdir /var/www/.npm && \
	chown www-data /var/www/.npm -Rv && \

	######################################################
	# Install Bower

	npm install -g bower && \
	mkdir /var/www/.config && \
	mkdir /var/www/.cache && \
	mkdir /var/www/.local && \
	chown www-data /var/www/.config -Rv && \
	chown www-data /var/www/.cache -Rv && \
	chown www-data /var/www/.local -Rv && \

	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NODE_BIN_PATH "/node/bin"

ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$NODE_BIN_PATH"

RUN echo $PATH