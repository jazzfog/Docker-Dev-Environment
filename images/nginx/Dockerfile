FROM nginx
MAINTAINER Fog

# Comment out "sendfile on;"
# Dev only, VirualBox issue workaround
# More info: https://www.vagrantup.com/docs/synced-folders/virtualbox.html
RUN sed -i -- 's/sendfile/#sendfile/g' /etc/nginx/nginx.conf