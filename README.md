AmazonLinux Docker image上にWeb開発環境を構築します。

# install docker
```
$ sudo yum install -y docker
$ sudo service docker start
```

# docker build
```
$ sudo docker build --build-arg c9User=`cat /dev/urandom | base64 | fold -w 16 | head -n 1` --build-arg c9Password=`cat /dev/urandom | base64 | fold -w 16 | head -n 1` -t="webdevops/aml:1.0" https://github.com/wisteria083/WebDevOpsDocker.git 
```

# docker run
```
$ sudo docker run -it -p 80:80 -p 8080:8080 -p 8081:8081 webdevops/aml:1.0 /bin/bash 
```

# open your DevOps

### Cloud9 IDE
http://{yourhost}:8081/ide.html

### phpMyAdmin
http://{yourhost}/phpmyadmin

# installs

### OS
Aamzon Linux

### Java
* JDK1.8.0
* tomcat 8

### Python
* Python 3.6.0
* pip 9.0(or later)

### Apache
* Apache2.4.x

### nginx
* nginx(amazon linux default repository)

### PHP
* PHP7.0
* composer

### MySQL
* MySQL 5.7(5.7.6 or later)

### NVM & Node.js
* NVM 0.33.2
* Node.js 4.3.2(default)
* bower
* Apex

### IDE
* Cloud9(from git)

### Utils
* phpMyAdmin(from git)

### frameworks

#### html5-site-template
```
git clone https://github.com/dcneiner/html5-site-template.git  /var/www/html/c9/workspaces/exsample/html5-site-template
```

#### FuelPHP
```
git clone https://github.com/fuel/fuel.git /var/www/html/c9/workspaces/exsample/fuelphp
```

#### WordPress
```
git clone https://github.com/WordPress/WordPress.git /var/www/html/c9/workspaces/exsample/wordpress
```

#### express
```
cd /var/www/html/c9/workspaces/exsample/express
npm install express --save
npm install express
```






