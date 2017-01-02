FROM mariadb:10
MAINTAINER Fog

COPY ./my-entrypoint.sh /

ENTRYPOINT ["/my-entrypoint.sh"]
CMD ["mysqld"]