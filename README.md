AmazonLinux Docker image上にWeb開発環境を構築します。

```
sudo yum install -y open-ssl
sudo docker build --build-arg sshPassword=`openssl rand -base64 32` --build-arg c9User=`openssl rand -base64 32` --build-arg c9Password=`openssl rand -base64 32` -t="webdevops/aml:1.0" https://github.com/wisteria083/WebDevOpsDocker.git 
```

# SSH
* OpenSSH

# LAMP
* Apache2.4.x
* PHP7.0
* MySQL 5.6 
* Python 3.6.0
* pip 9.0(or later)

# NVM & Node.js
* NVM 0.33.2
* Node.js 4.3.2(default)

# IDE
* Cloud9

# AWS
* Apex
