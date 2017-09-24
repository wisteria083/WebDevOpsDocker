AmazonLinux Docker image上にWeb開発環境を構築します。

# Warning!!

EC2 instance microで実行する場合はswapが無い場合が多いので事前に作っておいた方が吉

```
$ sudo su -
$ uname -a
$ dd if=/dev/zero of=/swapfile1 bs=1M count=512
$ ll /swapfile1
$ chmod 600 /swapfile1
$ mkswap /swapfile1
$ swapon -s
$ swapon /swapfile1
$ swapon -s
$ free
$ grep Swap /proc/meminfo
```
 
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
$ sudo docker run -itd -p 80:80 -p 81:81 -p 3000:3000 -p 8080:8080 -p 8081:8081  --name="webdevops" webdevops/aml:1.0 /bin/bash
```

# docker commit
```
$ sudo docker commit webdevops webdevops/aml:1.0_`date '+%Y%m%d%H%M%S'`
```

# open your DevOps

### Cloud9 IDE
http://{yourhost}:8081/ide.html

### phpMyAdmin
http://{yourhost}/c9/workspaces/phpMyAdmin

### html5-site-template
http://{yourhost}/c9/workspaces/example/html5-site-template

### FuelPHP
http://{yourhost}/c9/workspaces/example/fuelphp

### WordPress
http://{yourhost}/c9/workspaces/example/wordpress

# installs

### use image
FROM amazonlinux

### Java
* JDK1.8.0
* tomcat 8

### .Net Core
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
* Node.js 6.9.3(default)

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

* Ruby on Rails Blog(rails new blog -m)
```
/var/www/html/c9/workspaces/example/ruby_on_rails_blog
```

* aws-serverless-express(https://github.com/awslabs/aws-serverless-express.git)
```
/var/www/html/c9/workspaces/example/aws-serverless-express/example
```

if you run on local
```
node /var/www/html/c9/workspaces/example/aws-serverless-express/example/app.local.js
```

/aws-serverless-express set up
```
npm run config --account-id <aws account id> --bucket-name <s3 packet name> --function-name <function name> --region <region>
npm run setup
```

MySQL change default root password 
```
$ mysql -u root -p
Enter password {Dockerfile return MySQL password}

# SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');
```
