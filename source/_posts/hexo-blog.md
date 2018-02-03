---
title: Hexo搭建个人博客及NexT主题配置与优化
date: 2016-10-14 23:04:19
tags: [hexo,github,博客]
categories: 杂项
layout: post
---
<!--more-->

# 命令行帮助
```
D:\Github\blog-hexo>hexo -help
Usage: hexo <command>

Commands:
  clean     Removed generated files and cache.
  config    Get or set configurations.
  deploy    Deploy your website.
  generate  Generate static files.
  help      Get help on a command.
  init      Create a new Hexo folder.
  list      List the information of the site
  migrate   Migrate your site from other system to Hexo.
  new       Create a new post.
  publish   Moves a draft post from _drafts to _posts folder.
  render    Render files with renderer plugins.
  server    Start the server.
  version   Display version information.

Global Options:
  --config  Specify config file instead of using _config.yml
  --cwd     Specify the CWD
  --debug   Display all verbose messages in the terminal
  --draft   Display draft posts
  --safe    Disable all plugins and scripts
  --silent  Hide output on console

For more help, you can use 'hexo help [command]' for the detailed information
or you can check the docs: http://hexo.io/docs/
```

*  ## 常用命令：

		hexo help #查看帮助
		hexo init #初始化一个目录
		hexo new "postName" #新建文章
		hexo new page "pageName" #新建页面
		hexo generate #生成网页，可以在 public 目录查看整个网站的文件
		hexo server #本地预览，'Ctrl+C'关闭
		hexo deploy #部署.deploy目录
		hexo clean #清除缓存，强烈建议每次执行命令前先清理缓存，每次部署前先删除 .deploy 文件夹

		简写：
		hexo n == hexo new
		hexo g == hexo generate
		hexo s == hexo server
		hexo d == hexo deploy

直接在命令行中操作出现一下错误：
```
D:\Github\blog-hexo>hexo d
INFO  Deploying: git
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
'git' �����ڲ����ⲿ���Ҳ���ǿ����еĳ���
�������ļ�
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: spawn git ENOENT
    at notFoundError (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:11:11)
    at verifyENOENT (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:46:16)
    at ChildProcess.cp.emit (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:33:19)
    at Process.ChildProcess._handle.onexit (internal/child_process.js:200:12)
FATAL spawn git ENOENT
Error: spawn git ENOENT
    at notFoundError (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:11:11)
    at verifyENOENT (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:46:16)
    at ChildProcess.cp.emit (D:\Github\blog-hexo\node_modules\hexo-deployer-git\node_modules\hexo-util\node_modules\cross-spawn\lib\enoent.js:33:19)
    at Process.ChildProcess._handle.onexit (internal/child_process.js:200:12)

```

原因是：git的执行目录没有加入系统环境变量。解决方案：1.将git加入环境变量Path中。2.直接在git shell中进行操作。我更习惯于方式2。



环境搭建好以后，常用到的就是增加新的博客然后提交git。以下操作均在git shell中操作

操作目录：

```shell
YGC@YGC  /d/Github
$ cd blog-hexo/

YGC@YGC  /d/Github/blog-hexo
$ pwd
/d/Github/blog-hexo

YGC@YGC  /d/Github/blog-hexo
$ ls
_config.yml  node_modules/  public/    scaffolds/  themes/
db.json      package.json   readme.md  source/     upload.bat
```


```
	hexo n "Linux基础"
	hexo clean
	hexo s -p 5500
	hexo d -g

```

* ## Error message "Filename too long"

		git config --system core.longpaths true

<!--more-->
