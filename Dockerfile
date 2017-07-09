FROM amazonlinux

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
# Java8
# ========================
RUN yum -y install java-1.8.0-openjdk-devel tomcat8
RUN java -version

# ========================
# .NET Core SDK 
# http://qiita.com/creativewebjp/items/be182b394f5c56c24485
# ========================
RUN yum install -y libunwind libicu
RUN curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=809131
RUN mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet
RUN ln -s /opt/dotnet/dotnet /usr/local/bin
RUN dotnet --info

# ========================
# ruby & rails (rbenv)
# ========================

# rbenv
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel libffi-devel libxml2 libxslt libxml2-devel libxslt-devel sqlite-devel
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv

RUN cp -p /etc/profile /etc/profile.ORG
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' | tee -a /etc/profile
RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' | tee -a /etc/profile
RUN echo 'eval "$(rbenv init -)"' | tee -a /etc/profile

RUN source /etc/profile \
 && rbenv -v \
 && git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
 && rbenv install -l | grep 2.4.0 \
 && rbenv install 2.4.0 \
 && rbenv rehash \
 && rbenv global 2.4.0 \
 && ruby -v \
 && gem update --system \
 && gem install nokogiri -- --use-system-libraries \
 && gem install --no-ri --no-rdoc rails \
 && gem install bundler \
 && rbenv rehash \
 && rails -v

# ========================
# pyenv & Python3.6 & pip
# ========================
RUN yum install -y gcc gcc-c++ make git openssl-devel bzip2-devel zlib-devel readline-devel sqlite-devel
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv

RUN echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.bashrc
RUN echo 'if [ -d "${PYENV_ROOT}" ]; then' >> ~/.bashrc
RUN echo 'export PATH=${PYENV_ROOT}/bin:$PATH' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'fi' >> ~/.bashrc
 
RUN source ~/.bashrc \
 && pyenv install --list \
 && pyenv install 3.6.0 \
 && pyenv global 3.6.0 \
 && python --version \
 && curl -O https://bootstrap.pypa.io/get-pip.py \
 && python3 get-pip.py \
 && pip --version
 
# ========================
# Apache2.4
# ========================
RUN yum install -y httpd24

# change httpd.conf
RUN echo -e '<Directory "/var/www/html”>' | tee -a /etc/httpd/conf/httpd.conf \
 && echo -e 'AllowOverride All' | tee -a /etc/httpd/conf/httpd.conf \
 && echo -e '</Directory>' | tee -a /etc/httpd/conf/httpd.conf

# add conf files
RUN mkdir /etc/httpd/httpd-config
ADD httpd /etc/httpd/httpd-config/
RUN echo -e 'Include httpd-config/*.conf' | tee -a /etc/httpd/conf/httpd.conf \

EXPOSE 80

# ========================
# nginx
# ========================
RUN yum install -y nginx

# ========================
# MySQL5.7(5.7.6 or later)
# ========================
RUN yum -y install http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
RUN yum -y install mysql-community-server
RUN mysql --version

ADD mysqld/my.cnf /tmp/my.cnf
RUN cat /tmp/my.cnf >> /etc/my.cnf

RUN echo "NETWORKING=yes" >/etc/sysconfig/network
RUN service mysqld start
RUN service mysqld stop

RUN cat /var/log/mysqld.log | grep 'temporary password'

EXPOSE 3306

# ========================
# PHP7.0
# ========================
RUN yum install -y php70
RUN yum install -y php70-mysqlnd php70-mbstring php70-mcrypt php70-pdo php70-xml php70-fpm
 
RUN echo -e '[PHP]' | tee -a /etc/php.ini \
 && echo -e 'short_open_tag = On' | tee -a /etc/php.ini \
 && echo -e '[mbstring]' | tee -a /etc/php.ini \
 && echo -e 'mbstring.language = Japanese' | tee -a /etc/php.ini \
 && echo -e 'mbstring.internal_encoding = UTF-8' | tee -a /etc/php.ini \
 && echo -e 'mbstring.http_input = UTF-8' | tee -a /etc/php.ini \
 && echo -e 'mbstring.http_output = pass' | tee -a /etc/php.ini \
 && echo -e 'mbstring.encoding_translation = Off' | tee -a /etc/php.ini \
 && echo -e 'mbstring.detect_order = auto' | tee -a /etc/php.ini \
 && echo -e 'mbstring.substitute_character = nones' | tee -a /etc/php.ini

RUN php -v

# install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer

## ========================
## SSH
## ========================
#RUN yum -y install \
# openssh-server \
# openssh-clients
#
#RUN /usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' \
# && /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' \
# && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
# && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config \
# && sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
#
#EXPOSE 22

# ========================
# nvm & node
# ========================
ENV NODE_VERSION 4.3.0
ENV NVM_DIR /usr/local/nvm

RUN mkdir $NVM_DIR

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
 && source $NVM_DIR/nvm.sh \
 && nvm install $NODE_VERSION \
 && nvm alias default $NODE_VERSION \
 && nvm use default \
 && npm install bower -g \
 && bower -v
 
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

EXPOSE 8080

# ========================
# cloud9
# ========================
ENV C9_DIR /usr/local/c9sdk

RUN mkdir $C9_DIR

RUN yum install -y  \
which \
git \
gcc \
gcc-c++ \
openssl-devel \
readline-devel \
glibc-static

RUN git clone git://github.com/c9/core.git $C9_DIR
RUN $C9_DIR/scripts/install-sdk.sh
RUN cd $C9_DIR && npm install

EXPOSE 8081

# node forever
RUN npm install forever -g

# make workspace cloud9
RUN mkdir -p /var/www/html/c9/workspaces/

# ========================
# apex
# ========================
RUN curl https://raw.githubusercontent.com/apex/apex/master/install.sh | sh

# ========================
# phpMyAdmin
# ========================
RUN mkdir -p /var/www/html/c9/workspaces/phpMyAdmin
RUN git clone https://github.com/phpmyadmin/phpmyadmin.git /var/www/html/c9/workspaces/phpMyAdmin

# ========================
# frameworks
# ========================

# html5
RUN mkdir -p /var/www/html/c9/workspaces/example/html5-site-template
RUN git clone https://github.com/dcneiner/html5-site-template.git /var/www/html/c9/workspaces/example/html5-site-template

# FuelPHP
RUN mkdir -p /var/www/html/c9/workspaces/example/fuelphp
RUN git clone https://github.com/fuel/fuel.git /var/www/html/c9/workspaces/example/fuelphp
RUN cd /var/www/html/c9/workspaces/example/fuelphp && composer install

# WordPress
RUN mkdir -p /var/www/html/c9/workspaces/example/wordpress
RUN git clone https://github.com/WordPress/WordPress.git /var/www/html/c9/workspaces/example/wordpress

# ========================
# bashrc
# ========================
RUN echo -e 'export PS1="[\[\e[1;34m\]\u\[\e[00m\]@\h:\w]\$ "' | tee -a ~/.bash_profile

# ========================
# /etc/rc.local
# ========================
ARG c9User
ENV c9User $c9User

ARG c9Password
ENV c9Password $c9Password

# tail -f /dev/nullで永久に実行する
RUN echo -e '#!/bin/bash' | tee -a /etc/script.sh
RUN echo -e 'alias ll="ls -la"' | tee -a /etc/script.sh

RUN echo -e 'service sshd start' | tee -a /etc/script.sh
RUN echo -e 'service httpd start' | tee -a /etc/script.sh

RUN echo "node $C9_DIR/server.js -l 0.0.0.0 -w /var/www/html/c9/workspaces/ -p 8081 -a $c9User:$c9Password" | tee -a /etc/script.sh

RUN echo -e 'tail -f /dev/null' | tee -a /etc/script.sh

RUN chmod 777 /etc/script.sh
ENTRYPOINT ["/etc/script.sh"]

# ========================
# passwords
# ========================
RUN echo "c9 user is $c9User" >> ~/passwords
RUN echo "c9 password is $c9Password" >> ~/passwords
RUN echo "mysqld password is `cat /var/log/mysqld.log | grep 'temporary password'`"  >> ~/passwords
RUN cat ~/passwords
