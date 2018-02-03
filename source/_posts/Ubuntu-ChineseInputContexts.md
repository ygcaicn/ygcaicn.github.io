---
title: Ubuntu17.10-ChineseInputContexts
layout: post
comments: true
tags: [Qt,Linux,wps]
categories: Linux
keywords:  Ubuntu中文输入法 Ubuntu下Qtcreator无法输入中文 Ubantu下wps无法输入中文 Ubuntu下Atom 无法输入中文 Ubuntu17 Ubuntu17.04 Ubuntu17.10
date: 2017-11-11 10:32:29
timestamp:
photos:
    - ../img/4d3ae893-f910-4c23-8749-ef7bf963ef56.png
---

unbuntu下一些常用的软件无法输入中文，这使人很不爽，经过一段时间的努力基本解决了系统中文输入以及常用软件输入中文的问题！
环境为Ubuntu17.10 （17.04同样适用）。
常用软件包括：

- Atom
- Wps
- QtCreator

<!--more-->

## 系统中文输入

看图，不多说：

![7c1e95b2-17a3-4322-ab84-8c09619e237e](../img/7c1e95b2-17a3-4322-ab84-8c09619e237e.png)

![8f506da4-b2d3-4a23-84e3-53472b5f0320](../img/8f506da4-b2d3-4a23-84e3-53472b5f0320.png)

![8a39b319-f52c-4f2d-a61a-de2f62dead49](../img/8a39b319-f52c-4f2d-a61a-de2f62dead49.png)

![ddb58d66-7572-4a6f-8d9f-0d20b28ccdf8](../img/ddb58d66-7572-4a6f-8d9f-0d20b28ccdf8.png)



效果图：
![4d3ae893-f910-4c23-8749-ef7bf963ef56](../img/4d3ae893-f910-4c23-8749-ef7bf963ef56.png)

## Qt QtCreator

```
    sudo apt-get install fcitx-libs-qt fcitx-libs-qt5

    cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so  ~/qtcreator-4.4.0/lib/Qt/plugins/platforminputcontexts/
```
以上操作其实就是安装fcitx-libs-qt和fcitx-libs-qt5的库，然后将动态链接拷贝到qtcreator的插件目录中，至于为什么是这个目录需要你自己去发现，不过我们可以看到在该目录中已经存在ibux的动态链接库，我们只是把fcitx的加进去而已。

![b7a25a45-c60d-44ba-bcaa-2ead2ca1bd4e](../img/b7a25a45-c60d-44ba-bcaa-2ead2ca1bd4e.png)

当然你也可以不拷贝直接将libfcitxplatforminputcontextplugin.so所在的目录加入到环境变量中应该也是可以的（我没有测试）：

```
sudo vim /etx/bash.bashrc
```
在文件最后添加一行：
```
export $PATH = $PATH:/usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/
```

到此重启qtcreator已经可以输入中文了。就是这么简单！
效果图：
![370933ff-bb56-47de-8c4c-aca83576cf79](../img/fa8ee2df-6668-469f-b965-55174c5275e3.png )


## Wps


google搜到的解决办法,(亲测在Ubuntu17.04&17.10中无效)

> wps文字不能输入中文解决  

```
$ vim /usr/bin/wps      
```
修改wps启动文件：

```
#!/bin/bash
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE="fcitx"
gOpt=
#gOptExt=-multiply
gTemplateExt=("wpt" "dot" "dotx")
```

wps writer,表格，ppt对应的启动文件分别为：

```
    /usr/bin/wps
    /usr/bin/et
    /usr/bin/wpp
```

![a419806f-81a9-4ace-8249-874e1a004b45](../img/a419806f-81a9-4ace-8249-874e1a004b45.png)

以上方式在17.04和17.10中亲测无效！！！

受到qtcreator的启示，同样将libfcitxplatforminputcontextplugin.so动态链接库拷贝到wps的目录中，wps的目录位于：

```
/opt/kingsoft/wps-office/office6
```
可以看到在office6目录下有一个这样的路径：

```
/opt/kingsoft/wps-office/office6/qt/plugins/
```
和qtcreator的很相似，只是没有platforminputcontexts这个下一级目录，由于强迫症就建立一个这个目录（其实不建也是可以的）把libfcitxplatforminputcontextplugin.so拷贝进来，然后启动wps发现完美解决。

```
sudo mkdir /opt/kingsoft/wps-office/office6/qt/plugins/platforminputcontexts

sudo cp  /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so  /opt/kingsoft/wps-office/office6/qt/plugins/platforminputcontexts/

fcitx-autostart

wps
```
效果图：
![5e598032-adc5-48ad-a1a3-8a2cd012861a](../img/5e598032-adc5-48ad-a1a3-8a2cd012861a.png)







## Atom

Atom 我没有测试上面的方法，应该也是可以的。我的解决办法是编译安装。

Atom的官方网址：[https://atom.io/](https://atom.io/)

binary包安装以后无法输入中文，后来采用编译安装问题的到解决。

编译安装参考：[http://flight-manual.atom.io/hacking-atom/sections/hacking-on-atom-core/#platform-linux](http://flight-manual.atom.io/hacking-atom/sections/hacking-on-atom-core/#platform-linux)


效果图：
![01cf646b-b789-4b42-9278-adcdec0ffed6](../img/01cf646b-b789-4b42-9278-adcdec0ffed6.png)


## 总结

以上通过安装 fcitx-libs-qt fcitx-libs-qt5，然后将动态链接库拷贝到软件的启动目录（或者特定的库目录中）完美解决了Qtcreator，wps，Atom在Ubuntu中的中文输入问题！！Enjoy your Ubuntu!
<
