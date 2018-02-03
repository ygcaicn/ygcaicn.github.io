---
title: CentOS下载及版本选择--Linux版本，下载
date: 2017-01-15 23:02:06
tags: Linux
categories: Linux
keywords: Linux版本,Linux下载
---

CentOS 是一个企业级的 Linux 发行版本，它源于 Red Hat 1 免费公开的源代码。
CentOS 完全遵守 Red Hat 的再发行政策，并且以功能上的兼容性为目标。CentOS 对组件的修改主要是去除上游供应商的商标及美工。


<!--more-->

# 镜像目录结构：

```
0_README.txt                                       22-May-2016 13:52    2210
CentOS-6.8-x86_64-LiveCD.iso                       22-May-2016 22:18    702M
CentOS-6.8-x86_64-LiveCD.torrent                   25-May-2016 18:01     28K
CentOS-6.8-x86_64-LiveDVD.iso                      22-May-2016 21:38      2G
CentOS-6.8-x86_64-LiveDVD.torrent                  25-May-2016 18:01     76K
CentOS-6.8-x86_64-bin-DVD1.iso                     23-May-2016 07:53      4G
CentOS-6.8-x86_64-bin-DVD1to2.torrent              25-May-2016 18:01    229K
CentOS-6.8-x86_64-bin-DVD2.iso                     23-May-2016 07:53      2G
CentOS-6.8-x86_64-minimal.iso                      24-May-2016 00:37    447M
CentOS-6.8-x86_64-minimal.torrent                  25-May-2016 18:01     18K
CentOS-6.8-x86_64-netinstall.iso                   22-May-2016 14:07    228M
CentOS-6.8-x86_64-netinstall.torrent               25-May-2016 18:01    9799
README.txt                                         22-May-2016 13:52    2210
md5sum.txt                                         24-May-2016 00:41     388
md5sum.txt.asc                                     25-May-2016 17:57    1271
sha1sum.txt                                        24-May-2016 00:41     436
sha1sum.txt.asc                                    25-May-2016 17:57    1319
sha256sum.txt                                      24-May-2016 00:41     580
sha256sum.txt.asc                                  25-May-2016 17:58    1463
```

# README.txt有说明

```
What images are in this directory

CentOS-6.8-x86_64-netinstall.iso
  This is the network install and rescue image.
  This image is designed to be burned onto a CD. You then boot your computer off the CD.

CentOS-6.8-x86_64-minimal.iso
  The aim of this image is to install a very basic CentOS 6.8 system, with the minimum of packages needed to have a functional system.
  Please burn this image onto a CD and boot your computer off it. A preselected set of packages will be installed on your system. Everything else needs to be installed using yum.
  Please read http://wiki.centos.org/Manuals/ReleaseNotes/CentOSMinimalCD6.8 for more details about this image.
  The set of packages installed by this image is identical to the one installed when choosing the group named "Minimal" from the full DVD image.

CentOS-6.8-x86_64-bin-DVD1.iso
CentOS-6.8-x86_64-bin-DVD2.iso
  These two dvd images contain the entire base distribution.
  Please burn DVD1 onto a DVD and boot your computer off it.
  A basic install will not need DVD2.
  After the installation is complete, please run "yum update" in order to update your system.

CentOS-6.8-x86_64-LiveCD.iso
  This is a CD live image of CentOS 6.8 designed to be burned onto a CD. You then boot your computer using that CD.
  Please read http://wiki.centos.org/Manuals/ReleaseNotes/CentOSLiveCD6.8 for more details about this image.
  The disk can also be used to install CentOS 6.8 onto your computer but without offering any package selection options at install time.

CentOS-6.8-x86_64-LiveDVD.iso
  This is a DVD live image of CentOS 6.8 designed to be burned onto a DVD. You then boot your computer using that DVD.
  Please read http://wiki.centos.org/Manuals/ReleaseNotes/CentOSLiveDVD6.8 for more details about this image.
  The disk can also be used to install CentOS 6.8 onto your computer but without offering any package selection options at install time.

 Remember that in order to be able to partition your disk you will need to run the GUI installer which in turns needs enough RAM. The same is true for the network setup step.
 The release notes ( http://wiki.centos.org/Manuals/ReleaseNotes/CentOS6.8 ) provide more details about these aspects.
```

# LiveDVD-LiveCD-DVD

```
CentOS-6.8-x86_64-LiveCD.iso

CentOS-6.8-x86_64-LiveDVD.iso
```

这两个live版不许要安装到硬盘，可以直接从介质启动系统。
LiveCD版——相比LiveDVD是个精简的光盘CentOS系统。体积更小，便于维护使用。

```
CentOS-6.8-x86_64-bin-DVD1.iso

CentOS-6.8-x86_64-bin-DVD2.iso
```

这两个镜像是系统安装的镜像，需要安装到硬盘才能使用。DVD1用与基础安装，DVD2为附加RPM包，安装系统时只需要用到DVD1。
另外这两个镜像可以作为本地yum源使用。

```
CentOS-6.8-x86_64-minimal.iso
```

最小化安装镜像，very basic CentOS 6.8 system。

```
CentOS-6.8-x86_64-netinstall.iso
```

网络安装镜像，需要联网才能进行安装。


## 参考文档：https://wiki.centos.org/zh/Manuals/ReleaseNotes/CentOS6.8


#Linux下载开源镜像站：

## 1.企业贡献：

　　搜狐开源镜像站：http://mirrors.sohu.com/

　　网易开源镜像站：http://mirrors.163.com/


## 2.大学教学：

　　北京理工大学：

　　http://mirror.bit.edu.cn (IPv4 only)

　　http://mirror.bit6.edu.cn (IPv6 only)

　　北京交通大学：

　　http://mirror.bjtu.edu.cn (IPv4 only)

　　http://mirror6.bjtu.edu.cn (IPv6 only)

　　http://debian.bjtu.edu.cn (IPv4+IPv6)

　　兰州大学：http://mirror.lzu.edu.cn/

　　厦门大学：http://mirrors.xmu.edu.cn/

　　上海交通大学：

　　http://ftp.sjtu.edu.cn/ (IPv4 only)

　　http://ftp6.sjtu.edu.cn (IPv6 only)

　　清华大学：

　　http://mirrors.tuna.tsinghua.edu.cn/ (IPv4+IPv6)

　　http://mirrors.6.tuna.tsinghua.edu.cn/ (IPv6 only)

　　http://mirrors.4.tuna.tsinghua.edu.cn/ (IPv4 only)

　　天津大学：http://mirror.tju.edu.cn/

　　中国科学技术大学：

　　http://mirrors.ustc.edu.cn/ (IPv4+IPv6)

　　http://mirrors4.ustc.edu.cn/

　　http://mirrors6.ustc.edu.cn/

　　西南大学：http://linux.swu.edu.cn/swudownload/Distributions/

　　东北大学：

　　http://mirror.neu.edu.cn/ (IPv4 only)

　　http://mirror.neu6.edu.cn/ (IPv6 only)


　　电子科技大学：

　　http://ubuntu.uestc.edu.cn/

　　青岛大学：http://mirror.qdu.edu.cn/
