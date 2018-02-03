---
layout: post
title: GPT(GUID partition table)
tags: [GPT,Linux]
categories: Linux
date: 2017-05-04 13:04:44
timestamp: 20170504130444
comments: true
keywords: Machine Learning GPT分区表
description:
photos:
  - http://i.imgur.com/Q9g4RCE.png
---

GPT 磁盘分区表：


LBA -- Logical Block Adress

size of  LBA :512bytes(0.5KB)

LBA0~LBA33: GUID partition table(GPT)

LBA(end-33)~LBA(end): Backup GPT


<!--more-->


```
Disk /dev/sdb: 33021952 sectors, 15.7 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 2A7B560E-11D2-48FE-9A16-A54069811BF4
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 33021918
Partitions will be aligned on 2048-sector boundaries
Total free space is 2014 sectors (1007.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048        33021918   15.7 GiB    8300  Linux filesystem
```

# gdisk

## Command
```
Command (? for help): ?
b	back up GPT data to a file
c	change a partition's name
d	delete a partition
i	show detailed information on a partition
l	list known partition types
n	add a new partition
o	create a new empty GUID partition table (GPT)
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	sort partitions
t	change a partition's type code
v	verify disk
w	write table to disk and exit
x	extra functionality (experts only)
?	print this menu
```
## Recovery/transformation
```
Recovery/transformation command (? for help): ?
b	use backup GPT header (rebuilding main)
c	load backup partition table from disk (rebuilding main)
d	use main GPT header (rebuilding backup)
e	load main partition table from disk (rebuilding backup)
f	load MBR and build fresh GPT from it
g	convert GPT into MBR and exit
h	make hybrid MBR
i	show detailed information on a partition
l	load partition data from a backup file
m	return to main menu
o	print protective MBR data
p	print the partition table
q	quit without saving changes
t	transform BSD disklabel partition
v	verify disk
w	write table to disk and exit
x	extra functionality (experts only)
?	print this menu
```

## Expert
```
Expert command (? for help): ?
a	set attributes
c	change partition GUID
d	display the sector alignment value
e	relocate backup data structures to the end of the disk
g	change disk GUID
h	recompute CHS values in protective/hybrid MBR
i	show detailed information on a partition
l	set the sector alignment value
m	return to main menu
n	create a new protective MBR
o	print protective MBR data
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	resize partition table
t	transpose two partition table entries
u	replicate partition table on new device
v	verify disk
w	write table to disk and exit
z	zap (destroy) GPT data structures and exit
?	print this menu
```

# partition's type code

```
0700 Microsoft basic data  0c01 Microsoft reserved    2700 Windows RE          
3000 ONIE boot             3001 ONIE config           3900 Plan 9              
4100 PowerPC PReP boot     4200 Windows LDM data      4201 Windows LDM metadata
4202 Windows Storage Spac  7501 IBM GPFS              7f00 ChromeOS kernel     
7f01 ChromeOS root         7f02 ChromeOS reserved     8200 Linux swap          
8300 Linux filesystem      8301 Linux reserved        8302 Linux /home         
8303 Linux x86 root (/)    8304 Linux x86-64 root (/  8305 Linux ARM64 root (/)
8306 Linux /srv            8307 Linux ARM32 root (/)  8400 Intel Rapid Start   
8e00 Linux LVM             a500 FreeBSD disklabel     a501 FreeBSD boot        
a502 FreeBSD swap          a503 FreeBSD UFS           a504 FreeBSD ZFS         
a505 FreeBSD Vinum/RAID    a580 Midnight BSD data     a581 Midnight BSD boot   
a582 Midnight BSD swap     a583 Midnight BSD UFS      a584 Midnight BSD ZFS    
a585 Midnight BSD Vinum    a600 OpenBSD disklabel     a800 Apple UFS           
a901 NetBSD swap           a902 NetBSD FFS            a903 NetBSD LFS          
a904 NetBSD concatenated   a905 NetBSD encrypted      a906 NetBSD RAID         
ab00 Recovery HD           af00 Apple HFS/HFS+        af01 Apple RAID          
af02 Apple RAID offline    af03 Apple label           af04 AppleTV recovery    
af05 Apple Core Storage    bc00 Acronis Secure Zone   be00 Solaris boot        
bf00 Solaris root          bf01 Solaris /usr & Mac Z  bf02 Solaris swap        
bf03 Solaris backup        bf04 Solaris /var          bf05 Solaris /home       
bf06 Solaris alternate se  bf07 Solaris Reserved 1    bf08 Solaris Reserved 2  
bf09 Solaris Reserved 3    bf0a Solaris Reserved 4    bf0b Solaris Reserved 5  
c001 HP-UX data            c002 HP-UX service         ea00 Freedesktop $BOOT   
eb00 Haiku BFS             ed00 Sony system partitio  ed01 Lenovo system partit
ef00 EFI System            ef01 MBR partition scheme  ef02 BIOS boot partition
f800 Ceph OSD              f801 Ceph dm-crypt OSD     f802 Ceph journal        
f803 Ceph dm-crypt journa  f804 Ceph disk in creatio  f805 Ceph dm-crypt disk i
fb00 VMWare VMFS           fb01 VMWare reserved       fc00 VMWare kcore crash p
fd00 Linux RAID
```
# 刻录iso镜像到U盘

**必须先change a partition's type code ->EF00**再 'dd'

# Example disk's GPT

```
Disk /dev/sda: 468862128 sectors, 223.6 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): 4F2B2F55-48AC-4CC8-A745-605404C6BDF7
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 468862094
Partitions will be aligned on 2048-sector boundaries
Total free space is 13745 sectors (6.7 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            4096          204799   98.0 MiB    EF00  EFI system partition
   2          208896       229904940   109.5 GiB   0700  Basic data partition
   3       229906432       230897663   484.0 MiB   2700  
   4       230899712       426919054   93.5 GiB    0700  Basic data partition
   5       426919936       427309055   190.0 MiB   8300  
   6       427309056       428285951   477.0 MiB   8200  
   7       428285952       468860927   19.3 GiB    8300  
```

# details infomation on a partition

```
Partition GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93B (EFI System)
Partition unique GUID: 00772A36-9423-43A9-B1A1-0BE031102BFB
First sector: 4096 (at 2.0 MiB)
Last sector: 204799 (at 100.0 MiB)
Partition size: 200704 sectors (98.0 MiB)
Attribute flags: 0000000000000000
Partition name: 'EFI system partition'

```
