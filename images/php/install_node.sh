#!/usr/bin/env bash

#----------------------------------------------------------------------------------------------------------

# NodeJs version to install
NODE_VER='6.4.0'

# Where to download dist
NODE_DIST='https://nodejs.org/dist/v'$NODE_VER'/node-v'$NODE_VER'-linux-x64.tar.xz'

# Folder within archive
NODE_DIST_FOLDER='node-v'$NODE_VER'-linux-x64';

# Where to install node dist
NODE_FOLDER='/node'

NODE_ARCHIVE='node.tar.xz'

NODE_PATH_FILE='/etc/profile.d/10-node.sh'

#----------------------------------------------------------------------------------------------------------

# Download distributive archive
wget $NODE_DIST -O /$NODE_ARCHIVE

# Unpack arcive, the folder within archive will be placed in the root
tar xfJ /$NODE_ARCHIVE -C /

# Rename that unpacked folder to shorter name
mv /$NODE_DIST_FOLDER $NODE_FOLDER

# Remove unneeded archive file
rm /$NODE_ARCHIVE

# Add node to PATH (for some reason does not work after 'sudo su')
#touch $NODE_PATH_FILE
#echo '#!/usr/bin/env bash' > $NODE_PATH_FILE
#echo 'export PATH='$PATH':'$NODE_FOLDER'/bin' >> $NODE_PATH_FILE

# Warning, this will work for Ubuntu, but didn't work for debian container for some reason
# so had to add ENV right in Dockerfile
# Add node to PATH (brutal: duplicating of PATH, need to find better way)
echo 'PATH="'$PATH':/node/bin"' >> /etc/environment

# Specify production flag for node
echo 'NODE_ENV="production"' >> /etc/environment

# Just for current session, will help install npm modules, like Bower
PATH=$PATH:'/node/bin/'

#----------------------------------------------------------------------------------------------------------