FROM debian:wheezy
MAINTAINER stv <stv@stanford.edu>

# System Package Managment
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install apt-transport-https

# Source Control
RUN apt-get -y install git

# Build Tools
RUN apt-get -y install build-essential

# Python Development Packages
RUN apt-get -y install python
RUN apt-get -y install python-dev
RUN apt-get -y install python-distribute
RUN apt-get -y install python-pip

# These are needed to compile libxml
RUN apt-get -y install libxml2-dev
RUN apt-get -y install libxslt1-dev

# NodeJs
ADD bin/nodejs-setup /tmp/nodejs-setup
RUN /bin/bash /tmp/nodejs-setup
RUN apt-get -y install nodejs

# Grunt stuff
RUN npm install -g grunt-init
RUN npm install -g grunt-cli

# Grab source code
RUN git clone -v https://github.com/stvstnfrd/xblock-sdk.git /root/sdk
RUN git clone -v https://github.com/Stanford-Online/grunt-init-xblock.git /root/.grunt-init/xblock

# Copy over additional files
ADD bin/xblock-make /usr/local/bin/xblock-make
ADD bin/xblock-run-sdk /usr/local/bin/xblock-run-sdk
ADD bin/xblock-install-all /usr/local/bin/xblock-install-all

# Install XBlocks here
RUN mkdir /root/xblocks

# Build source code
RUN make -C /root/sdk install

# Run websever
ENV HOME /root
WORKDIR /root
EXPOSE 80
CMD ["/usr/local/bin/xblock-run-sdk"]
