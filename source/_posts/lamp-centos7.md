---
title: lamp服务器搭建-centos7+Apache2.4+MariaDB+php5.6+phpmyadmin
date: 2016-10-22 23:43:54
tags: [LAMP]
categories: Linux
---

centos7 下yum搭建服务器以及数据库的流程。

<!--more-->

# 安装httpd

直接yum源安装就可以，centos7的yum源是Apache2.4

  `yum install httpd`

## apache常用指令

```
systemctl start httpd      #启动apache
systemctl stop httpd       #停止apache
systemctl restart httpd    #重启apache
systemctl enable httpd     #设置apache开机启动
```

# 配置两个扩展yum源

    yum install epel-release
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

因为centos7默认的yum源php是5.4的，有点跟不上时代的脚步啊。。。所以使用扩展yum源进行安装。

<!--more-->

# php相关模块


    yum --enablerepo=remi-php56 install php php-cli php-pear php-pdo php-mysqlnd php-gd php-mbstring php-mcrypt php-xml

# phpmyadmin

    yum --enablerepo=remi-php56 install phpmyadmin

这里指定php的版本是必须的，有很多教程就是这里出了问题。。。

## phpmyadmin配置：

```
    #打开phpmyadmin的配置文件
    vim /etc/httpd/conf.d/phpMyAdmin.conf

    将Allow from 127.0.0.1
    Allow from ::1
    改为： Require all granted
    systemctl restart httpd  #重启apache
```

# 安装MariaDB
CentOS 7.0中，已经使用MariaDB替代了MySQL数据库
## 安装MariaDB

    yum install mariadb mariadb-server #询问是否要安装，输入Y即可自动安装,直到安装完成

## 常用MariaDB指令

```  
systemctl start mariadb.service #启动MariaDB
systemctl stop mariadb.service #停止MariaDB
systemctl restart mariadb.service #重启MariaDB
systemctl enable mariadb.service #设置开机启动
cp /usr/share/mysql/my-huge.cnf /etc/my.cnf #拷贝配置文件（注意：如果/etc目录下面默认有一个my.cnf，直接覆盖即可）
```

## 为root账户设置密码

```
mysql_secure_installation
#回车，根据提示输入Y
#输入2次密码，回车
#根据提示一路输入Y
#最后出现：Thanks for using MySQL!
#MySql密码设置完成，重新启动 MySQL：
systemctl restart mariadb.service #重启MariaDB
```

## 新建数据库账户


## 进入数据库

mysql -u root -p

> show databases

最后开启相应的端口就可以外网访问了，关于firewalld的相关操作请参考[*CentOS7使用firewalld管理防火墙与端口*](http://blog.cumtpn.com/2016/10/22/firewalld-centos7/)

# 每天进步一点点!!!

## **impossible is I'm possible!!!**
