---
title: ESP分区格式化，修复Windows&Linux引导
layout: post
date: 2017-05-14 17:32:55
comments: true
tags: [Grub Linux Windows]
categories: Linux
keywords: Grub2 Linux Windows 修复Windows&Linux引导
description:
---

ESP分区存放的UEFI引导程序，ESP分区被格式化意味着无法进入系统
<!--more-->
# 系统环境

Windows10 64
Linuxmint 64

双系统

Windows UEFI引导
Linux Grub2引导

sda1是我的Esp分区。被我格式化过

    sudo mkfs.vfat /dev/sda1

Linux的boot是单独分区的，设备符为：/dev/sda5


# 修复Linux Grub2

进入U盘进入live Linux

## 方式一

从新安装grub2,

挂载esp分区：

```
sudo mkdir /mnt/esp
sudo mount /dev/sda1 /mnt/esp
```
挂载boot分区：

```
sudo mkdir /mnt/boot
sudo mount /dev/sda5 /mnt/boot
```

**Note:** 这里为什么要挂载boot分区？

因为esp分区

grub-install的--boot-directory选项默认的是镜像安装位置为/boot/grub

```
      --boot-directory=DIR   install GRUB images under the directory DIR/grub
                             instead of the boot/grub directory
```

为了追求与默认一致，其实也是为了以后更新方便，我们现在要在Live Linux下挂载你的boot分区，然后将Grub的镜像安装到硬盘上的Linux系统的/boot中。其实完全可以将Grub镜像安装到Esp分区中，我们在做U盘Grub时就是将镜像直接放到了Esp分区。

Esp分区只存放UEFI可以认识的efi程序，以及efi程序的字体文件等。

安装grub2:

```
sudo grub-install --target x86_64-efi --efi-directory /mnt/esp --boot-directory=/mnt/boot
```

成功执行结果

```
Installing for x86_64-efi platform.
Installation finished. No error reported.
```
错误信息类似于grub-install: error: /usr/lib/grub/x86_64-efi/modinfo.sh doesn't exist. Please specify --target or --directory. 这样的话，就需要安装grub-pc或grub-efi之后再试。

    sudo apt-get install grub-efi -y

**note:**

```
--efi-directory=DIR    use DIR as the EFI System Partition root
```

生成grub.cfg

```
sudo grub-mkconfig -o /mnt/boot/grub/grub.cfg
```

这时候我们看一下esp分区中的内容：

```
.
└── EFI
    └── ubuntu
        └── grubx64.efi

```

发现里面就只有一个grubx64.efi的文件。这个文件其实就是一个UEFI程序。在UEFI中可以识别这个程序，这个程序又引导CPU进入grub。那么这个程序是怎么找到Grub镜像的位置的呢？（有待查阅，这是不是意味着grub必须从新安装？方法2不可行？）

看看boot分区多了什么东西：

```
grub
├── fonts
│   └── unicode.pf2
├── grub.cfg
├── grubenv
├── locale
│   ├── en_AU.mo
│   ├── en_CA.mo
│   ├── en_GB.mo
│   └── en@quot.mo
└── x86_64-efi
    ├── acpi.mod
    ├── adler32.mod
    ├── affs.mod
    ├── afs.mod
    ├── ahci.mod
    :
    :
    :
    └── zfs.mod

```


重启系统，在UEFI界面应该已经可以看到了grub的启动项。

启动着实进入了grub，也进入了Linux，但是进入的是emergency mode.

这让我百思不得其解，为什么无法进入图形界面？？？Google也没有找到答案，关键是系统没有提示有什么出错的地方。。。

Emergency下df -h发现有些不对的地方：
```
jachin@jachin-Inspiron-5548 ~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G     0  3.9G   0% /dev
tmpfs           790M  1.5M  789M   1% /run
/dev/sda7        19G   14G  4.2G  77% /
tmpfs           3.9G   49M  3.9G   2% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sda5       180M  129M   39M  77% /boot
cgmfs           100K     0  100K   0% /run/cgmanager/fs
tmpfs           790M   36K  790M   1% /run/user/1000

```
什么情况efi分区没挂载上。

问题解决：最后发现是/etc/fstab出了问题。

```
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda7 during installation
UUID=29fb7aca-a39d-485e-bcb2-4188ae03b085 /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sda5 during installation
UUID=d5151999-209d-4a90-95f4-e4e70ab02ac7 /boot           ext4    defaults        0       2
# /boot/efi was on /dev/sda1 during installation
UUID=B178-A3FF  /boot/efi       vfat    umask=0077      0       1
# swap was on /dev/sda6 during installation
UUID=b6f30e1d-84b0-4b23-862c-82cb12773a4f none            swap    sw              0       0

```

`blkid`发现esp分区的UUID竟然与fstab中的不一样。推测是格式化会改变分区的UUID（有待查阅资料）so，把这里的UUID改了之后问题解决。成功进入Linux。

## 方法二

直接拷贝一个grubx64.efi文件,到Esp分区中。

没有测试，不知道行不行。
# 修复Windows 引导

很简单，进入PE

执行
```
bcdboot c:\windows /s g: /f UEFI
```
c:为Windows安装的盘符，g：为Esp分区的盘符。Esp分区盘符可以在Diskgens下查看。

`/f UEFI`选项尽量加上吧，我的不加没有成功哦。

到此位置你的Windows已经可以启动了。

查看一下上面的命令都干了什么事,可以看到esp分区中只有一个目录：EFI

```
    EFI
    ├── Boot
    │   └── bootx64.efi
    ├── Microsoft
    │   ├── Boot
    │   │   ├── BCD
    │   │   ├── BCD.LOG
    │   │   ├── BCD.LOG1
    │   │   ├── BCD.LOG2
    │   │   ├── bg-BG
    │   │   │   ├── bootmgfw.efi.mui
    │   │   │   └── bootmgr.efi.mui
    │   │   ├── bootmgfw.efi
    │   │   ├── bootmgr.efi
    │   │   ├── BOOTSTAT.DAT
    │   │   ├── boot.stl
    │   │   ├── cs-CZ  语言文件
    │   │   │   ├── bootmgfw.efi.mui
    │   │   │   ├── bootmgr.efi.mui
    │   │   │   └── memtest.efi.mui
    │   │   ├── en-GB
    │   │   │   ├── bootmgfw.efi.mui
    │   │   │   └── bootmgr.efi.mui
    │   │   ├── en-US
    │   │   │   ├── bootmgfw.efi.mui
    │   │   │   ├── bootmgr.efi.mui
    │   │   │   └── memtest.efi.mui
    |   |   :
    |   |   :
    │   │   ├── zh-CN
    │   │   │   ├── bootmgfw.efi.mui
    │   │   │   ├── bootmgr.efi.mui
    │   │   │   └── memtest.efi.mui
    │   │   ├── Fonts  字体文件
    │   │   │   ├── chs_boot.ttf
    │   │   │   :
    │   │   │   :
    │   │   │   └── wgl4_boot.ttf
    │   │   ├── kd_02_10df.dll
    │   │   :
    │   │   :
    │   │   ├── kdstub.dll
    │   │   ├── memtest.efi
    │   │   ├── qps-ploc
    │   │   │   └── memtest.efi.mui
    │   │   └── Resources
    │   │       ├── bootres.dll
    │   │       ├── en-US
    │   │       │   └── bootres.dll.mui
    │   │       └── zh-CN
    │   │           └── bootres.dll.mui
    │   └── Recovery
    │       ├── BCD
    │       ├── BCD.LOG
    │       ├── BCD.LOG1
    │       └── BCD.LOG2
    └── ubuntu
        └── grubx64.efi
```
windows引导有几类文件：
efi文件memtest.efi bootmgr.efi bootmgfw.efi /Boot/bootmgfw.efi
字体文件 *.ttf
语言文件
```
zh-CN
├── bootmgfw.efi.mui
├── bootmgr.efi.mui
└── memtest.efi.mui
```
BCD文件 BCD引导修复这个是最重要的其他的那些文件都可以拷贝，这个不可以。所以前面的命令bcdboot主要任务就是修复这个BCD文件。当然还有其他的修复方式。

# Other things

现在系统都可以完美启动了，但是还有些不完没就是Grub的引导中没有Windows item。
进入Lilnux
执行   `update-grub2`

```
jachin-Inspiron-5548 boot # update-grub2
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-4.4.0-77-generic
Found initrd image: /boot/initrd.img-4.4.0-77-generic
Found linux image: /boot/vmlinuz-4.4.0-75-generic
Found initrd image: /boot/initrd.img-4.4.0-75-generic
Found Windows Boot Manager on /dev/sda1@/EFI/Microsoft/Boot/bootmgfw.efi
Adding boot menu entry for EFI firmware configuration
done
```
okay,现在Grub的menu中已经有Windows选项了，到此完美修复。
