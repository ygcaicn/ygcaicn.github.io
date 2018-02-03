---
title: Qt-doc-struct
layout: post
comments: true
tags: [Qt,cpp]
categories: Qt
keywords:  Qt Qt学习
date: 2017-11-09 11:09:40
timestamp:
photos:
    - ../img/4655551fdasfaf.png
---

Qt的文档写的非常棒！学习QT最重要的就是学会看官方的文档，了解文档的结构有助于快速的查询文档，解决问题。Qt官方文档的主页为<http://doc.qt.io>
![4bbdac2a-5470-4829-8a47-5cfed7253eba](../img/4bbdac2a-5470-4829-8a47-5cfed7253eba.png)

进入Qt Reference Documentation后可以看到Qt的文档还分为不同的分类，本文主要是介绍第一个分类：Class Lists

![49e21d26-e157-40b5-acb1-3e492b9cf2d8](../img/49e21d26-e157-40b5-acb1-3e492b9cf2d8.png)

Class Lists中又有不同的索引方式，方便不同情景下查询：
![c42b0ad4-92e7-4dcf-b09f-14bce8261eea](../img/c42b0ad4-92e7-4dcf-b09f-14bce8261eea.png) 


Qt的class文档大致分为3个部分，Type（数据类型），Functions（成员函数），Macros（宏）。每个部分又分为两块，前一块是一个list，简单的列举，后一块为detail，详细信息。每个类的文档都是在同一个html页面上，采用锚点相互跳转，这也是非常棒的一点！

<!--more-->

## QDir Class *类名*

![qdirdfadfclass](../img/qdirdfadfclass.png)

The QDir class provides access to directory structures and their contents. More... *简单介绍功能，可点击查看详细*


|  |  |
---|---
Header:|#include <QDir>
qmake:|QT += core

*说明header和qmake的包含操作*

---

## Public Types *公有的数据类型*

![ae7e90b2-2b94-45af-819e-cb99c0f686e3](../img/ae7e90b2-2b94-45af-819e-cb99c0f686e3.png)

```
enum	Filter { Dirs, AllDirs, Files, Drives, ..., CaseSensitive }
flags	Filters
```

> The Filters type is a typedef for QFlags<Filter>. It stores an OR combination of Filter values.


## Public Functions *公有成员函数*

![baac4270-afb5-41f3-ac10-4c8d217d2e56](../img/baac4270-afb5-41f3-ac10-4c8d217d2e56.png)
对象可以访问的函数,编程过程中主要查阅的就是这部分。

## Static Public Members  *静态成员函数*

![74c56c41-e57f-49e2-bb0b-2863471984f8](../img/74c56c41-e57f-49e2-bb0b-2863471984f8.png)

解决同一个类不同对象之间的数据共享问题。主要作用是用来访问同一个类中的静态数据成员，维护对象之间的数据共享。

访问不依赖于对象。

可以通过对象与类名进行调用，一般习惯与用类名进行访问。


```
static QDir	current()

//example：

QDir::current()

//return a QDir Object of current directory.

```
## Macros 宏
![747b2a9a-3760-4319-8dda-06b283649d8e](../img/747b2a9a-3760-4319-8dda-06b283649d8e.png)

---

## Detailed Description

该部分介绍QDir的整体概览。又分为小的章节进行介绍

### Navigation and Directory Operations

### Files and Directory Contents

### The Current Directory and Other Special Paths

![93ced37a-d761-4d88-a0d4-033002f35a25](../img/93ced37a-d761-4d88-a0d4-033002f35a25.png)
### Path Manipulation and Strings

### Examples

---
## Member Type Documentation

![559c5e7d-9573-4d55-b9b0-e4b45f100494](../img/559c5e7d-9573-4d55-b9b0-e4b45f100494.png)

具体的介绍数据类型

## Member Function Documentation
![g3364be29-656a-4a1f-8b6e-2f96a635e4d3](../img/g3364be29-656a-4a1f-8b6e-2f96a635e4d3.png)

![ee471f05-3f7e-4537-baa3-537f69c3c64f](../img/ee471f05-3f7e-4537-baa3-537f69c3c64f.png)
具体的介绍Function，包括static function。每个函数后有`See also xxx()`非常的方便。

## Macro Documentation
![c70d4c00-6840-4eb5-be99-4c18cdf4fe01](../img/c70d4c00-6840-4eb5-be99-4c18cdf4fe01.png)
具体的介绍宏


## 实例

### [QDir](http://doc.qt.io/qt-5/qdir.html#QDir)
