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

# open Cloud9 IDE
http://{userhost}:8081

# middlewares

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

### PHP
* PHP7.0

### MySQL
* MySQL 5.6 

### NVM & Node.js
* NVM 0.33.2
* Node.js 4.3.2(default)
* Apex

### IDE
* Cloud9

