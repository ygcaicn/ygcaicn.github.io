---
title: 关于win10version1703 多引导（grub引导）的问题
layout: post
date: 2017-06-1 08:32:55
comments: true
tags: [Grub2,Linux,Windows]
categories: Linux
keywords: Grub2 Linux Windows
description:
photos:
  - http://imgur.com/6pbOMcK.png
---

# 关于win10调包grub引导的过程


2017.05.31日中午更新了win10 1703推送的更新，一切由此变的不开心。。。

往常一直正常的grub引导出问题了，bios启动项中ubuntu这个item还在，不过不幸运的是即使你选择这项引导进行开机进入的依然是windows。这就让人很生气。

好在我还有移动硬盘的linux，当然你用live盘也是可以的。进去移动硬盘linux后按照上篇文章讲的方法修复了grub。再次进入bios选择ubuntu启动，没什么问题一下就进入了grub熟悉的界面。成功进入了内置硬盘的linuxmint。
<!--more-->

本来以为故事到此就结束了呢，骂也骂过了，问题也修复了，万万万万没有想到的是我从win关机之后首先发现了第一个小问题：bios的启动项顺序发生了变化，以往我都是将grub放到第一启动项的，现在变成win是第一项。
然后接着来了一个大问题：第二项的ubuntu选项（也就是grub引导程序grubx64.efi）选择从该项启动以后又直接进入了win。到这时候我就已经有了不好的预感。同样从硬盘进入linux看看什么情况，先修复了grub

via.一下操作均在live linux下操作

## 安装修复grub

```
jachin-Inspiron-5548 ubuntu # sudo grub-install --target x86_64-efi --efi-directory /mnt/esp --boot-directory=/mnt/boot
Installing for x86_64-efi platform.
Installation finished. No error reported.
```

## grubx64.efi文件

    jachin-Inspiron-5548 ubuntu # ll -h grubx64.efi
    -rwx------ 1 root root 118K May 31 09:45 grubx64.efi*

同样修复万以后grub一切正常，重复上次的操作，进入win，关机win，选择grub启动项。和上次结果一样又进了win。。再进入移动硬盘的linux

## 重启win后grubx64.efi文件
    jachin-Inspiron-5548 ubuntu # ll -h grubx64.efi
    -rwx------ 1 root root  74K May 31 09:45 grubx64.efi*

发现了猫腻，万恶的Mxx公司竟然修改了grubx64.efi文件。。。

总结一下就是：

1. win会调包（sda1@efi）/EFI/ubuntu/grubx64.efi文件
2. win会自动调整启动项的顺序，把自己条boot1
3. linux下win的分区不能挂载，之前是开着快速启动也可以挂载的，现在不行了。这个关掉快速启动可以解决，没办法果断关掉。


# 尝试的一些方法

## 修改grubx64.efi的文件名（失败）


```
cp grubx64.efi mgrubx64.efi 

jachin-Inspiron-5548 ubuntu # ll -h
total 240K
drwxr-xr-x 2 root root 2.0K May 31 10:18 ./
drwxr-xr-x 5 root root 2.0K May 28 00:45 ../
-rwxr-xr-x 1 root root 118K May 31 10:09 grubx64.efi*
-rwxr-xr-x 1 root root 118K May 31 10:18 mgrubx64.efi*
```

启动过win之后：

```
jachin-Inspiron-5548 ubuntu # ll -h
total 78K
drwxr-xr-x 2 root root 2.0K May 31 10:18 ./
drwxr-xr-x 5 root root 2.0K May 28 00:45 ../
-rwxr-xr-x 1 root root 74K May 31 10:09 grubx64.efi*
-rwxr-xr-x 1 root root 0K May 31 10:18 mgrubx64.efi*
```

可以看到（sda1@efi）/EFI/ubuntu/grubx64.efi文件被调包，（sda1@efi）/EFI/ubuntu/mgrubx64.efi这个更是直接被清空。

## 修改grubx64.efi所在的文件夹

这样可以正常进入grub，但是bios中的启动项要手动添加。并且启动win后添加的启动项被删除了，文件倒是没有被修改，可以通过再次添加进入grub程序。

## 双Esp分区
   
将以前的esp分区划分成两个esp分区，一个专门用来存放windows的efi程序，另一个专门存放grub的efi程序（grubx64.efi）

先将esp分区中的win引导程序备份出来（不过后来证明我用cp备份的引导并不能正常进入win）
拆分分区主要就是用了gdisk工具，格式化为vfat 使用了mkfs.vfat程序，选择一个esp作为linux的引导分区，然后安装grub，还要注意修改内置硬盘系统的/etc/fstab文件中的esp分区挂载的uuid，这个尤其重要，不修改的话也是无法正常进入系统的。ps.这些操作都是在移动硬盘的linux系统中进行的。

这时候重启进入bios中发现自动识别出了sda2也就是我的第二块efi分区中的grub引导，第一块的win引导没有识别。我就手动添加了一下发现启动出了问题，不能正常进入win。没办法逢山开路进winPE，bcdboot修复win引导。这时候需要注意的是你要指定win引导安装在哪个esp分区。到此的话已经win和linux都可以启动了，并且grub引导不会被win调包。

这种解决方法相对完美，但是没有解决win将自身调整为boot1的问题。

## 需要注意的问题：

1. 拆分分区时第二个esp分区的分区号可能会排到最后，也就是数值最大。这个你可以手动调整分区号，不过开机进入内置硬盘的win后分区号按照扇区的顺序自动调整。
2. 备份win的引导我是没成功，如果又winPE的话可以不备份直接删除格式化，badboot重建win引导。
3. 不要考虑在win下无损调整vfat文件系统的分区。
4. fstab文件一定要修改的，要不然进不去系统。

# 参考

[ESP分区格式化，修复Windows&Linux引导](http://blog.cumtpn.com/Linux/Esp-grub-uefi-windows.html)











