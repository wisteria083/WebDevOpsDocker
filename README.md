AmazonLinux Docker image上にWeb開発環境を構築します。

```
sudo docker build https://github.com/wisteria083/WebDevOpsDocker.git --build-arg sshPassword=`openssl rand -base64 32` --build-arg c9User=`openssl rand -base64 32` --build-arg c9Password=`openssl rand -base64 32` -t="devops/aws:1.0" .
```

# SSH
* OpenSSH

# LAMP
* Apache2.4.x
* PHP7.0
* MySQL 5.6 
* Redis 3.x

# NVM & Node.js
* NVM 0.33.2
* Node.js

# IDE
* Cloud9

# AWS
* Apex
