---
title: Ubuntu17 aria2c安装使用手记
layout: post
comments: true
date: 2018-01-16 12:09:42
timestamp:
tags: [Ubuntu,Linux]
categories: Linux
keywords: Jachin blog Linxu Qt Cpp Ubuntu Python 打造日常使用ubuntu Ubuntu必备软件
photos:
  - ../img/1daaf097-cf2a-4d5d-86a9-13bf3cf91ef0.png
---

>aria2 is a utility for downloading files. The supported protocols are HTTP(S), FTP, SFTP, BitTorrent, and Metalink. aria2 can download a file from multiple sources/protocols and tries to utilize your maximum download bandwidth. It supports downloading a file from HTTP(S)/FTP /SFTP and BitTorrent at the same time, while the data downloaded from HTTP(S)/FTP/SFTP is uploaded to the BitTorrent swarm. Using Metalink chunk checksums, aria2 automatically validates chunks of data while downloading a file.

<!--more-->
# 0x01.安装环境：
* Ubuntu17.10

* 参考：http://aria2c.com/usage.html

# 0x02.
```
sudo apt-get update
sudo apt-get install aria2
sudo mkdir /etc/aria2c
sudo touch /etc/aria2c/aria2.conf
sudo touch /etc/aria2c/aria2.session
chowm -R [your_name] /etc/aria2c

```
## ~/.bash_aliases
```
#aria
alias aria2='aria2c --conf-path=/etc/aria2c/aria2.conf'
```
修改完成后 `source ~/.bash_aliases`
## Downloads

打开命令行输入啊aria2,然后用浏览器打开http://aria2c.com/便可以添加任务！

# 0x03. 百度网盘插件

https://blog.icehoney.me/posts/2015-01-31-Aria2-download

# 0x04.每天进步一点点!!!

## **impossible is I'm possible!!!**
