FROM node:7-wheezy
MAINTAINER Fog

RUN \
	apt-get update && \
	apt-get install -y imagemagick && \

	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "npm", "start" ]