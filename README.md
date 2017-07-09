AmazonLinux Docker image上にWeb開発環境を構築します。

# install docker
```
$ sudo yum install -y git docker
$ sudo service docker start
```

# docker build
```
$ sudo docker build --build-arg c9User=`cat /dev/urandom | base64 | fold -w 16 | head -n 1` --build-arg c9Password=`cat /dev/urandom | base64 | fold -w 16 | head -n 1` -t="webdevops/aml:1.0" https://github.com/wisteria083/WebDevOpsDocker.git 
```

# docker run
```
$ sudo docker run -itd -p 80:80 -p 8080:8080 -p 8081:8081 --name="webdevops" webdevops/aml:1.0 /bin/bash 
```

if any dockers
```
$ sudo docker run -itd -p 81:80 -p 8180:8080 -p 8181:8081 --name="webdevops001" webdevops/aml:1.0 /bin/bash 
$ sudo docker run -itd -p 82:80 -p 8280:8080 -p 8281:8081 --name="webdevops002" webdevops/aml:1.0 /bin/bash 
$ sudo docker run -itd -p 83:80 -p 8380:8080 -p 8381:8081 --name="webdevops003" webdevops/aml:1.0 /bin/bash 
...
```

# docker commit
```
$ sudo docker commit webdevops webdevops:latest
```

if any dockers
```
$ sudo docker commit webdevops001 webdevops001:latest
$ sudo docker commit webdevops002 webdevops002:latest
$ sudo docker commit webdevops003 webdevops003:latest
...
```

# open your DevOps

### Cloud9 IDE
http://{yourhost}:8081/ide.html

### phpMyAdmin
http://{yourhost}/phpMyAdmin

### html5-site-template
http://{yourhost}/example/html5-site-template

### FuelPHP
http://{yourhost}/example/fuelphp

### WordPress
http://{yourhost}/example/wordpress

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
```
/var/www/html/c9/workspaces/phpmyadmin
```

### frameworks
* html5-site-template(https://github.com/dcneiner/html5-site-template.git)
```
/var/www/html/c9/workspaces/example/html5-site-template
```

* FuelPHP(https://github.com/fuel/fuel.git)
```
/var/www/html/c9/workspaces/example/fuelphp
```

* WordPress(https://github.com/WordPress/WordPress.git)
```
/var/www/html/c9/workspaces/example/wordpress
```



