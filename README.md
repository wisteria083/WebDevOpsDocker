AmazonLinux Docker image上にWeb開発環境を構築します。

# docker build
```
$ sudo yum install -y open-ssl
$ sudo docker build --build-arg c9User=`openssl rand -base64 32` --build-arg c9Password=`openssl rand -base64 32` -t="webdevops/aml:1.0" https://github.com/wisteria083/WebDevOpsDocker.git 
```

# docker run
```
$ sudo docker run -it -p 80:80 -p 8080:8080 -p 8081:8081 webdevops/aml:1.0 /bin/bash 
```

# 開発環境

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

