---
title: Markdown Syntax Tutorial
date: 2016/10/15 22:22:01
tags: [MarkDown,github]
categories: 杂项
---

## MarkDown语法简明

# Title
This is first paragraph!

This is second paragraph!

1\.段落的前后必须有一个空行，否则换行符会被替换为空格  
2\.行内要换行的话，必须在上一行的最后空上至少两个空格  
或者加入`<br/>`<br/>实现换行.

3\. Markdown 中的多数区块都需要在两个空行之间。

<!--more-->
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题


 ## 我在左侧加了空格


一级标题的另一种写法H1
====================

二级标题H2
---------


>引用的内容（blockquote）  
>引用内容  
>引用的嵌套
>>内部的quote  
>>内部的引用

## 有序列表

1.第一条  
2.第二条  
4.第三条  

## 无序列表

* 第一条  
+ 第二条  
- 第三条

## 嵌套的列表

1. 第一条  
  + 第一例  
  + 第二例
2. 第二条  
  1. 第二例
  2. 第二例
  3. 第三例
4. 第三条  


## 代码

	#include<iostream>
	#using namespce std;
	int main()
	{
		cout<<"Hello world"<<end;
		return 0;
	}

通过前面的Table来写代码块

`#include<iostream>`  
`#using namespce std;`  
`int main()`  
`{`  
`	cout<<"Hello world"<<end;`  
`	return 0;`  
`}`  

另一种形式

##分割线

两种形式

------

* * * * * *

都必须单独占一个段落，每个分割符为一个区块，前后必须空行，中间无所谓

## 超链接

[text](url)

* 行内式

网页链接：

I like [Google](www.google.com)

This is my [homepage](www.cumtpn.com)

文件连接：

[icon](./calcu.png)




包含Title的连接

[google](www.google.com "Google")

*  参考式

[Google][Link1]

[Baidu][Link2]

[GitHub][Link3]

[Link1]:www.google.com "Google"  
[Link2]:www.baidu.com "baidu"
[Link3]:www.github.com "GitHub"

* 自动链接

www.google.com

<www.google.com>

http://www.google.com

<http://www.google.com>

name@gmail.com

<name@gmail.com>


## 图片

![icon](./calcu.png)

嵌入Html

<img src="/img/calcu.png" alt="This is a calcular" title="calcular" width="100" length="100"/>



## 强调

*斜体强调*

**粗体强调**

\**粗体强调**

## 字符转义

例如  

\#标题

\**粗体强调**


##删除线

~删除线删除这些文字~

##多行代码


```C
#include<iostream>
using namespace std;
int main()  
{     
	cout<<"Hello world!"<<endl;  
	return 0;   
}
```


## TaskList
- [ ] Eat
- [x] Code
  - [x] HTML
  - [x] CSS
  - [x] JavaScript
- [ ] Sleep


## Graphy



|    name    | age |
| ---------- | --- |
| LearnShare |  12 |
| Mike       |  32 |
