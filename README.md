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

copy Cloud9 IDE user and password

in docker build terminal
```
c9 user is {user}
c9 password is {user}
```

copy mysqld rootpassword

in docker build terminal
```

```

# docker run
```
$ sudo docker run -itd -p 80:80 -p 8080:8080 -p 8081:8081 --name="webdevops" webdevops/aml:1.0 /bin/bash
```

if more dockers
```
$ sudo docker run -itd -p 81:80 -p 8180:8080 -p 8181:8081 --name="webdevops_001" webdevops/aml:1.0 /bin/bash 
$ sudo docker run -itd -p 82:80 -p 8280:8080 -p 8281:8081 --name="webdevops_002" webdevops/aml:1.0 /bin/bash 
$ sudo docker run -itd -p 83:80 -p 8380:8080 -p 8381:8081 --name="webdevops_003" webdevops/aml:1.0 /bin/bash 
...
```

# docker commit
```
$ sudo docker commit webdevops webdevops/aml:1.0_`date '+%Y%m%d%H%M%S'`
```

if more dockers
```
$ sudo docker commit webdevops_001 webdevops/aml:1.0_001_`date '+%Y%m%d%H%M%S'`
$ sudo docker commit webdevops_002 webdevops/aml:1.0_002_`date '+%Y%m%d%H%M%S'`
$ sudo docker commit webdevops_003 webdevops/aml:1.0_003_`date '+%Y%m%d%H%M%S'`
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

### use image
FROM amazonlinux

### Java
* JDK1.8.0
* tomcat 8

### .Net
* dotnet

### Ruby (rbenv)
* rbenv
* ruby-build
* Ruby 2.4.0
* Rails 4.2.4 or later

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
* MySQL 5.7.6 or later

### NVM & Node.js
* NVM 0.33.2
* Node.js 4.3.2(default)

### IDE
* Cloud9

### Utils
* phpMyAdmin
* bower
* Apex

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



