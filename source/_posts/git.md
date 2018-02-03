---
title: GitHub入门记 Go Git!!!
date: 2016-10-14 21:14:28
tags: [github]
categories: 建站
keywords: github入门,github,置顶文章
photos:
  - http://i.imgur.com/tudQUov.jpg
---

# git install and config

* install Linux:
```
	shell 界面输入 ``sudo  apt-get install git-core`` 回车输入密码
```
* Windows：下载
```
	[git-for-windows](https://github.com/git-for-windows/git/releases/tag/v2.6.3.windows.1)

	[github-windows](https://github-windows.s3.amazonaws.com/GitHubSetup.exe)

	安装就不用说了，上面两个的区别自己去琢磨吧！
```
* Mac：terminal : brew install git

完成上面的步骤就算安装好环境了，你离git已经很近了，下面是怎么配置。

```
	#配置全局用户名和邮箱
	#Linux: shell ，Windows: Git Bash ，Mac:terminal 命令如下：
	git config --global user.name "yourname"
	git config --global user.email "Youremail@gmail

	#查看是否配置成功：
	git config --global user.name
	git config --global user.email  
```
<!--more-->

# creat local repository connect remote

首先你要在本地创建一个仓库，也就是repository（creat a local repository）：
```
	#cd 到你要建仓库的文件夹，建的仓库会在该文件夹下生成一个和仓库同名的文件夹
	#所以你不必自己建立一个和仓库同名的文件夹
	#假如你的仓库都要放在D:/GitHub/下
	cd D:/GitHub
	git init mygit
```
就是这么简单仓库就建好了，你会发现在`D:/GitHub`下生成了一个mygit文件夹，同时文件夹内有一个`.git`隐藏文件。那么现在`D:/GitHub/mygit/`就是你的本地仓库了。如果你不想让你的代码发布到网络的话，在这里你完全可以使用git的所有功能。不过我们要做的还是想要他发布到网上，那就是GitHub了。



# 建立一个远程仓库（creat a remote repository）

在[git.hub.com](http://git.hub.com)创建一个新的仓库，一定要是空的。当然你要先登录你的帐号，如果连账号都搞不定我想你可以`Ctrl+W`了。当然了你可以[百度--](https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=github%20%E6%B3%A8%E5%86%8C&rsv_pq=91be8521000285f6&rsv_t=897aSDBktemvsQZDFO9grrqOtZxbYL0XvZH6kedqhDzayC9fY%2F73YTwP7VY&rqlang=cn&rsv_enter=1&rsv_sug3=14&rsv_sug1=4&rsv_sug7=100)。

![](/img/markdown-img-paste-20161016161851265.png)
![](/img/markdown-img-paste-20161016162035764.png)

完成以后你的远程仓库也就建好了。不过你还需要将刚才建立的本地仓库与远程的仓库建立连接。那么你就需要你的远程仓库地址

![](/img/markdown-img-paste-20161016162352701.png)
连接支持HTTPs和SSH两种协议，推荐使用ＳＳＨ连接。

我的连接是<git@github.com:ygcaicn/mygit.git>, （这用的是SSH连接地址）


# 本地仓库与远程仓库连接( connect a remote repository )
	#打开git shell
	cd D:/github/mygit
	git remote add origin git@github.com:ygcaicn/mygit.git

> # Quick setup — if you’ve done this kind of thing before
>## …or create a new repository on the command line

>		echo "# test" >> README.md
		git init
		git add README.md
		git commit -m "first commit"
		git remote add origin git@github.com:ygcaicn/test.git
		git push -u origin master

> ## …or push an existing repository from the command line

>	git remote add origin

>		git@github.com:ygcaicn/test.git
		git push -u origin master

> ## …or import code from another repository

>You can initialize this repository with code from a Subversion, Mercurial, or TFS project.

上面是建立完仓库官方给出的Quick setup.

## 上传本地仓库 Update

建立远程连接更新本地的改动到云端

	git add -A
	git commit -m "first commit"
	git push -u origin master  //由于第一次push加-u

后来的push不需要加-u参数。到此你已经可以简单的使用git了。不过git远不只这么多东西，它没这么简单。

----

# 下面介绍一些Github常用的skill
## creat remote repository clone to local

将代码仓库clone到本地，其实就是将代码复制到你的机器里，并交由Git来管理：
	git clone git@github.com:ygcaicn/mygit.git

## git常用的命令:[git-scm官方文档](https://git-scm.com/doc)

关于git-scm是什么和git的区别，[请按下`Ctrl`点击](http://blog.csdn.net/iamluole/article/details/42148091)


+ `git add`：把要提交的代码添加进来，可以认为到一个缓冲中**[重要]** [官方文档](https://git-scm.com/docs/git-add)

提交文件test.c：

	git add test.c

提交目录test ：

	git add test

添加删除后的所有文件：

	git add .

~~或者：~~

		~~git add -A~~

添加所有文件（和上面的区别我也不知道）

	#一定要是大A强调一下，Shell下的所有操作都是区分大小写的
	#不过Windows下还有区别，因为~~万恶的Windows~~是不区分文件的大小写的
	git add -A

上面的add添加操作相当于把文件写入到了一个仓库的缓存区，但是还没有真正的写入到仓库的磁盘中

+ `git commit`本地提交commit：add完成后，真正的代码提交**[重要]** [官方文档](https://git-scm.com/docs/git-commit)

    git commit -m “commit” // -m 描述信息，不能为空

本地提交就是将缓存区的文件改动写入仓库的磁盘。

+ git status: 查看上次提交后文件修改的列表

		git status

+ git diff：查看文件修改的内容，-号代表删除部分，+号代表添加部分

		git diff TestB.java // 查看TestB.java修改的内容

+ checkout：撤销未提交的修改（未执行add操作）

		git checkout TestB.java // 撤销TestB.java的修改

+ reset：取消add状态

    git reset HEAD TestB.java // 取消TestB.java的add状态

+ log：查看提交记录（内容包含提交id,提交人，提交日期，描述信息）

		git log // 所有记录
		git log xxxxx(id) -1 // 查看当前id的记录，-1表示一行记录
		git log xxxxx(id) -1 -p // 查看当前id提交记录的修改


		+ `.gitignore`文件:

		git会检查是否存在该文件，存在就读取该文件内容，将配置文件或者目录排除在版本之外，文件和目录可以使用“\*”通配符。可以手动创建在文件。

-------

		```
			#Compiled Object files
			*.slo
			*.lo
			*.o
			*.obj

			# Precompiled Headers
			*.gch
			*.pch

			# Compiled Dynamic libraries
			*.so
			*.dylib
			*.dll

			# Fortran module files
			*.mod

			# Compiled Static libraries
			*.lai
			*.la
			*.a
			*.lib

			# Executables
			*.exe
			*.out
			*.app

			#Editplus
			*.bak
			TestA.c // 排除该文件
		  testDir // 排除该目录
		```

-------------------




## git 分支

分支：可以在现有代码上拉出一个分支，使得代码可以在主干与分支同时开发，并且代码之间互相不会影响。常见使用环境，就是每次版本发布，已发布的可以拉出一个分支，剩下的功能继续在主干开发，如果发布版本有问题，只用修改分支，最终将代码合并到主干。

+ 分支命令：

```
    git branch -a // 查看所有分支，master主干，分支前有*号，表示当前处于那个分支
    git branch release1.0 // 创建release1.0分支，
    git checkout release1.0 // 切换到release1.0分支，主要与文件修改撤销的区别
    git checkout master // 1： 切换到主干
    git merge release1.0 // 2： 将release1.0的修改合并到master，如果有冲突解决冲突
    git branch -D release1.0 // 删除release1.0分支
```


## 远程版本库

+ 比如有远程版本库(仓库)，[https://github.com/FreeSunny/RefreashTabView.git](https://github.com/FreeSunny/RefreashTabView.git)

		git clone https://github.com/FreeSunny/RefreashTabView.git // 下载到本地

### 远程库命令：

+ pussh：将代码修改和提交同步到远程库 **[重要]**

		#origin 指定远程版本库的 Git 地址，master 指定同步到哪一个分支
		git push origin master

+ fetch：远程库的修改同步到本地, 不会将代码合并到任何分支，会存放到一个origin/master分支上

		#注释同
		git fetch origin master

+ diff：查看远程库修改内容

		#注意有一个斜线，就是fetch同步后放置的位
		git diff origin/master

+ merge：将origin/master分支修改的内容合并到主分支

		#注意斜线
		git merge origin/master

+ pull：fetch + merge，拉取并且合并**[重要]**

		#没有斜线  
		git pull origin master

## Git常用速查 [gitbub网址](https://github.com/)

知易行难，say easy than do， 下面就来一个小小的实例，**必须要有git账号**，这个步骤就不用say了吧！

### 创建远程库

     a. 点击+号下的New repository 创建一个远程库，命名为GitOperate,

     b. 版本库类型可以public或者private，程序员都有开源的心，那就public。

     c. 还可以勾选Initialize this repository with a README，

     d. 接下来可以选择添加.gitignore文件，.gitignore文件有很多类型可以选，
        比如 Android，Android项目下的bin这些文件一般都不需要提交。
        选择遵循的协议。eg：Apache License 2.0, 这个可以自己去查查每种的意思

     e. 点击create，远程版本库就创建完成了，远程版本库的地址为
        https://github.com/FreeSunny/GitOperate.git。
        之后跳转到README.md,该文件主要是对项目的描述。

### 远程库克隆到本地

     a. 本地创建一个GitOperate文件夹

     b. 远程库地址为https://github.com/FreeSunny/GitOperate.git，
        cd进入GitOperate，输入 *git clone https://github.com/FreeSunny/GitOperate.git*

     c. 完成后可以在GitOperater文件下的GitOperate文件夹下看到README.md文件（两层文件夹了）

     d. 将第二个目录下的所有文件全部复制到上一层目录中，这样就只有第一层目录添加到版本控制中。
        操作命令为(cp -r GitOperate/ .)

### 提交代码

    git add .// 将提交的代码添加进来，这里指README.md

    git commit -m “add readme” // 本地提交

    git push origin master //  同步到远程库

# Ref

<htpp://iissnan.com/progit/>

[1]: https://github.com/git-for-windows/git/releases/tag/v2.6.3.windows.1
