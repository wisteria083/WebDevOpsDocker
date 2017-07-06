FROM amazonlinux

# ========================
# args
# ========================
ARG sshPassword="rootpassword"
ARG c9User="c9user"
ARG c9Password="c9Password"

# ========================
# packages
# ========================
RUN yum -y clean all && yum -y update
RUN yum -y install \
 sudo \
 passwd \
 gcc \
 gcc-c++ \
 make \
 wget \
 unzip \
 git \
 lm_sensors \
 rpm-build \
 yum-cron \
 nfs-utils \
 nfs-utils-lib \
 nfs-common \
 nap \
 glibc-static

# ========================
# SSH
# ========================
RUN yum -y install openssh-server openssh-clients

RUN /usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' \
 && /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
 && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
 && sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

cEXPOSE 22

# ========================
# Apache
# ========================
# install apache2.4
RUN yum install -y httpd

# add conf files
ADD httpd/*.conf  /etc/httpd/conf.d/

# change httpd.conf
RUN echo -e '<Directory "/var/www/html”>' | tee -a /etc/httpd/conf/httpd.conf \
 && echo -e 'AllowOverride All' | tee -a /etc/httpd/conf/httpd.conf \
 && echo -e '</Directory>' | tee -a /etc/httpd/conf/httpd.conf

EXPOSE 80

# ========================
# MySQL5.6
# ========================
RUN yum install -y mysql56 mysql56-server

EXPOSE 3306

# ========================
# PHP7.0
# ========================
RUN yum install -y php70 php70-mbstring

# ========================
# nvm & node,cloud9,apex
# ========================
ENV NODE_VERSION 4.3.0
ENV NVM_DIR /usr/local/nvm
ENV C9_DIR /usr/local/c9sdk

RUN mkdir $NVM_DIR
RUN mkdir $C9_DIR

# Install nvm with node and npm
RUN cd $C9_DIR && curl https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
&& source $NVM_DIR/nvm.sh \
&& nvm install $NODE_VERSION \
&& nvm alias default $NODE_VERSION \
&& nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

EXPOSE 8080

# install cloud9
RUN yum install -y which git gcc gcc-c++ openssl-devel readline-devel glibc-static
RUN python -V

RUN git clone git://github.com/c9/core.git $C9_DIR
RUN $C9_DIR/scripts/install-sdk.sh
RUN cd $C9_DIR && npm install

EXPOSE 8081

# node forever
RUN npm install forever -g

# make workspace cloud9
RUN mkdir -p /var/www/html/c9/workspaces/

# install apex
RUN curl https://raw.githubusercontent.com/apex/apex/master/install.sh | sh



# ========================
# bashrc
# ========================
RUN echo -e 'export PS1="[\[\e[1;34m\]\u\[\e[00m\]@\h:\w]\$ "' | tee -a ~/.bash_profile

# ========================
# /etc/rc.local
# ========================
RUN echo -e '#!/bin/bash' | tee -a /etc/script.sh
RUN echo -e 'alias ll="ls -la"' | tee -a /etc/script.sh
RUN echo -e 'node $C9_DIR/server.js -l 0.0.0.0 -w /var/www/html/c9/workspaces/ -p 8081 -a $c9User:$c9Password' | tee -a /etc/script.sh
RUN echo -e 'tail -f /dev/null' | tee -a /etc/script.sh

RUN chmod 777 /etc/script.sh
ENTRYPOINT ["/etc/script.sh"]


# ========================
# message
# ========================
RUN echo "ssh password is $sshPassword"

RUN echo "ic9 user is $c9User"

RUN echo "c9 password is $c9Password"

RUN echo "forever start $C9_DIR/server.js -w /var/www/html/c9/workspaces/ -p 8081 -a $c9User:$c9Password"
