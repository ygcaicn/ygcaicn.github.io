---
title: Markdown 基础语法
date: 2017-03-05 17:58:19
tags: markdown
categories: 杂项
---

JOHN GRUBER定义的[markdown语法](http://daringfireball.net/projects/markdown/syntax)。

<!--more-->

# 段落与换行

1.段落的前后必须空行：空行指的是什么内容都没有，或者只有空白符（空格或制表符）

相邻两行文本，如果中间没有空行会显示在一行中（换行符被转换成为空格）

2.如果需要在段落内加入换行（`<br/>`）  
可以在前一行的末尾加入至少两个空格，然后换行写其他的文字

3.Markdown中的多数区域都需要在两个空行之间


# 标题

## Setext格式

```
H1
====

H2
----
```

渲染效果：（不包含上下的分隔线）

---

H1
====

H2
----

---

## atx格式

* 可以使用对称的`#`包括文本：

```
## H2 ##

### H3 ###
```

~~对于有道云笔记文本和`#`之间必须有空格。~~ 标准语法就是这样的。

渲染效果：

---
## H2 ##

### H3 ###
---

* 也可以只在左边使用`#`:

```
### H3

#### H4
```
渲染效果：

---
### H3

#### H4
---
JOHN's [Heaser](http://daringfireball.net/projects/markdown/syntax#header)

```
HEADERS

Markdown supports two styles of headers, Setext and atx.

Setext-style headers are “underlined” using equal signs (for first-level headers) and dashes (for second-level headers). For example:

This is an H1
=============

This is an H2
-------------
Any number of underlining =’s or -’s will work.

Atx-style headers use 1-6 hash characters at the start of the line, corresponding to header levels 1-6. For example:

# This is an H1

## This is an H2

###### This is an H6
Optionally, you may “close” atx-style headers. This is purely cosmetic — you can use this if you think it looks better. The closing hashes don’t even need to match the number of hashes used to open the header. (The number of opening hashes determines the header level.) :

# This is an H1 #

## This is an H2 ##

### This is an H3 ######
```

各种Markdown软件的渲染结果可能会有一些差别，但是了解一下标准的语法是没坏处的。

# 引用

## 1.引用内容

在段落或者内容前使用`>`符号，就可以将这段内容标记为‘引用’的内容（`<blockquote>`）:

```
>引用内容
```

渲染效果：

---

>引用内容

---

## 2.多行引用



```
>多行引用
>可以在每一行前加`>`符号

```

渲染效果：

---

>多行引用  
>可以在每一行前加`>`符号

---

```
>如果仅在第一行使用`>`,
后面相邻的行即使省略`>`，也会变成引用内容
```

渲染效果：

---

>如果仅在第一行使用`>`,  
后面相邻的行即使省略`>`，也会变成引用内容

---

```
>如果引用的内容需要换行，  
>可以在行尾添加两个空格
>
>或者在引用内容中加一个空行
```

渲染效果：

---

>如果引用的内容需要换行，  
>可以在行尾添加两个空格
>
>或者在引用内容中加一个空行

---

## 3.嵌套引用

```
>也可以在引用中
>>使用嵌套的引用
```

渲染效果：

---

>也可以在引用中
>>使用嵌套的引用

---

## 4.其它Markdown

```
>在引用中可以使用其它任何*Markdown*语法
```

渲染效果：

---

>在引用中可以使用其它任何*Markdown*语法

---

# 列表

## 无序列表

```
* 可以使用`*`作为标记
- 也可以使用`-`
+ 或者`+`
```

渲染效果：

---

* 可以使用`*`作为标记
- 也可以使用`-`
+ 或者`+`

---

## 有序列表

```
1. 有序列表以数字和`.`开始；
2. 数字的序列并不会影响生成列表的序列；
4. 但是仍然推荐按照自然顺序（1.2.3...）编写
```

渲染效果：

---

1. 有序列表以数字和`.`开始；
2. 数字的序列并不会影响生成列表的序列；
4. 但是仍然推荐按照自然顺序（1.2.3...）编写

---

## 嵌套的列表

```
1. 第一层
    + 1-1
    + 1-2
    + 1-3
2. 无序列表和有序列表可以随意相互嵌套
    1. 2-1
    2. 2-2
    3. 2-3
```

渲染效果：

---

1. 第一层
    + 1-1
    + 1-2
    + 1-3
2. 无序列表和有序列表可以随意相互嵌套
    1. 2-1
    2. 2-2
    3. 2-3

---

## 语法和用法

1. 无序列表项的开始是：符号 空格；
2. 有序列表项的开始是：数字 `.` 空格；
3. 空格至少为一个，多个空格将被解析为一个；
4. 如果仅需要在行前显示数字和`.`:  

```
05\. 可以使用：数字\. 来取消显示为列表
```

05\. 可以使用：数字\\. 来取消显示为列表

# 代码

## 代码块

可以使用缩进来插入代码块：

    <html>
        <title></title>
    </html>

代码块前后至少有一个空行，切每行代码前至少有一个Tab或者四个空格；

## 行内代码

通过``，插入行内代码（`是Tab键上边、数字`1`键左侧的按键）；

例如`<title>Markdown</title>`

## 转换规则

代码块中的文本（包括Markdown语法）都会显示为原始内容，而特殊字符会被转换为HTML[字符实体](https://zh.wikipedia.org/wiki/XML%E4%B8%8EHTML%E5%AD%97%E7%AC%A6%E5%AE%9E%E4%BD%93%E5%BC%95%E7%94%A8%E5%88%97%E8%A1%A8)


# 分割线

1. 可以在一行中使用三个或更多的`*`,`-`或`_`来添加分隔线(<hr/>):
2. 多个字符之间可以有空格（空白符），但不能有其它字符：

```
***
------
_____

*   *   *
_ _ _
```

渲染效果：


***
------
_____

*   *   *
_ _ _


# 超链接

## 行内式

格式为：`[link text](URL  "title text")`

`[Google](http://www.google.com)`  
[Google](http://www.google.com)

`[icon](./images/icon.png)`  
[icon](./images/icon.png)

超链接的title就是鼠标放上去（不是点击）时就弹出来的提示：

`[Google](http://www.google.com "Google Title")`

注：title text使用'或者"都是可以的。

[Google](http://www.google.com "Google Title")

## 参考式

参考式链接的写法相当于行内式拆分成两部分，并通过一个识别符连链接两部分。参考式能尽量保持文章的结构简单，也方便统一管理URL

1. 链接格式

第一个方括号为链接文本，第二个方括号为 链接独有的标识符，可以是字母、数字、空格或标点符号。**标识符是不区分大小写的**

`[link text][link-sign]`

2. 链接内容

[link-sign]: URL "title"

其中URL可以使用<>包起来，title可以使用''、""、 ()包括（考虑到兼容性，建议使用引号），title部分也可以换行来写；

链接内容的定义可以放在同一个文件的任意位置；

3. 备注

可以省略标识符，直接使用link text作为标识符。

这种情况下第二个方括号可以为空或者直接省略第二个方括号。

参考格式的优点在于可以在多个不同的位置引用同一个URL。

```
[Google][google-link]  
[Baidu][baidu-link]  
[QQ][]  
[Amazon]

[google-link]: http://www.google.com "Google Title"
[baidu-link]: http://www.baidu.com "Baidu Title"
[QQ]: http://www.qq.com "QQ Title"
[Amazon]: http://www.amazon.com "amazon title"
```

渲染效果：

---

[Google][google-link]  
[Baidu][baidu-link]  
[QQ][]  
[Amazon]

[google-link]: http://www.google.com "Google Title"
[baidu-link]: http://www.baidu.com "Baidu Title"
[QQ]: http://www.qq.com "QQ Title"
[Amazon]: http://www.amazon.com "amazon title"

---

## 自动链接

使用`<>`包括的URL或者邮箱地址会被自动的转换为超链接：

```
<http://www.google.com>   
<123@email.com>
```
渲染效果：

<http://www.google.com>   
<123@email.com>

这种方式适合行内较短的链接，会使用URL作为超链接文章，邮箱地址会自动编码，以逃避抓取机器人。

# 图片

插入图片的语法和插入超链接的语法基本一致，只是在最前面多一个`!`。也分为行内式和参考式两种。

## 行内式

```
![Imgur](http://i.imgur.com/YACdsVS.jpg)
```
![Imgur](http://i.imgur.com/YACdsVS.jpg "rosse")

方括号部分是图片的替代文本，括号中的'title'部分和连接是一样的，是可选的。

## 参考式

```
![Imgur][rosse]

[rosse]: http://i.imgur.com/YACdsVS.jpg "rosse"
```
![Imgur][rosse]

[rosse]: http://i.imgur.com/YACdsVS.jpg "rosse"

## 指定图片的大小

Markdown不支持指定图片的大小，不过可以通过直接插入<img/>标签来指定相关属性：

```
<img src="http://i.imgur.com/YACdsVS.jpg" alt="rosse" title="rosse" width="50" height="30"/>
```

<img src="http://i.imgur.com/YACdsVS.jpg" alt="rosse" title="rosse" width="50" height="30"/>

注：这在有道云笔记里是不支持的！


# 强调

1. 使用`* *`或`_ _`包括的文本会被转换为<em></em>,通常表现为斜体。
2. 使用`** **`或`__ __`包括的文本会被转换为<strong></strong>,通常表现为加粗。
3. 用来包括文本的*或_内侧不能有空白，否则* _将不会被转换。
4. 如果需要在文本中成对显示*或者_，可以在符号前加入`\`即可。
5. 强调的特殊符号必须成对使用。

```
*Hello world!*  
_Hello world!_  
**Hello world!**  
__Hello world!__  
\*Hello world!\*  
\_Hello world!\_
```

*Hello world!*  
_Hello world!_  
**Hello world!**  
__Hello world!__  
\*Hello world!\*  
\_Hello world!\_  


# 字符转义

反斜线 `\`用于插入在Markdown语法中有特殊作用的字符。

这些字符包括：

```
\  
`  
_  
{}  
[]  
()  
#  
+  
-  
_  
'  
.  
!
```
# Markdown 扩展语法

Markdown标准 本身包含的功能有限，所以产生了许多第三方的扩展语法，如[Github Flavored Markdown](https://help.github.com/categories/writing-on-github/)。

# 删除线

用`~~ ~~`包括的内容将以删除线的形式展现。

```
~~删除线~~
```
~~删除线~~

# 代码块和语法高亮

## 代码块

1. 与缩进添加代码块不同，这里使用 \```  \``` 来包含多行代码。```需要单独占一行。
2. 在第一组```之后添加代码的语言，如'javascript'或者'js'，即可以将代码标记为Javascript。


    ```c++
    include<iostream>
    using namespace std;

    int main(void)
    {
        cout << "Hello world!";
        return 0;
    }
    ```


```cpp
include<iostream>
using namespace std;

int main(void)
{
    cout << "Hello world!";
}
```

    ```js
    window.addEventListener('load', function() {console.log('window loaded');});
    ```

```js
window.addEventListener('load', function() {console.log('window loaded');});
```

# 表格

## 单元格和表头

1. 使用`|`来分隔不同的单元格，使用来分隔表头和其它行。
2. 为了美观，可以使用空格对齐不同的单元格，并在左右两侧都使用 `|`来标记单元格边界。
3. 在表头下方的分隔线中加入 `:`，即可标记下方单元格内容的对齐方式。单元格内容默认为左对齐，表头内容会一直居中对齐。
4. 表格中可以插入其它Markdown内容的行内标记，比如超链接等。





```
| name      |   age     |
|---------- |-----------|
|LearnShare |   12      |
|Mike       |   20      |

```

| name      |   age     |
|---------- |-----------|
|LearnShare |   12      |
|Mike       |   20      |


| name      | age   | blog                  |
|----------:|-------|-----------------------|
| LearnShare| 12    |[Learn](http://www.blog.cumtpn.com)|
| Mike      | 20    | ![Imgur](http://i.imgur.com/YACdsVS.jpg "rosse")

# Task list

```
- [ ] Eat
- [x] Code
    - [x] HTML
    - [X] CSS
    - [ ] Javascipt
- [ ]Sleep
```
- [ ] Eat
- [x] Code
    - [x] HTML
    - [x] CSS
    - [ ] Javascipt
- [ ]Sleep

# 编辑器与扩展

这部分给大家介绍一些可以用来书写、编辑Markdown的工具，包括独立客户端、编辑器/IDE插件，以及WEB的工具，排名不分先后。

也欢迎你来推荐自己喜欢的工具和插件。

* [MarkdownPad] Windows
* [Text] Windows OSX
* [MarkPad] Windows
* [MdCharm] Windows Linux
* [Mardown Edit] Windows
* [CuteMarkEd]Windows Linux
* [Haroopad] Windows OSX Linux
* [Mou] OSX
* [MacDown] OSX
* [Markdown Pro] OSX
* [ReText]Linux
* [sublime-markdown-extended]Sublime Text
* [Atom Markdown Preview]Atom
* [IDEA Markdown]IDEA
* [cmd Markdown]Windows OSX Linux web
* [StactEdit]Web
* [Dillinger]Web


[MarkdownPad]:https://markdownpad.com
[Text]:http://www.texts.io/
[MarkPad]:http://code52.org/DownmarkerWPF/
[MdCharm]:http://www.mdcharm.com/
[Mardown Edit]:http://mike-ward.net/markdownedit/
[CuteMarkEd]:https://cloose.github.io/CuteMarkEd/
[Haroopad]:http://pad.haroopress.com/
[Mou]:http://25.io/mou/
[MacDown]:http://macdown.uranusjr.com/
[Markdown Pro]:http://www.markdownpro.com/
[ReText]:http://sourceforge.net/projects/retext/
[sublime-markdown-extended]:https://github.com/jonschlinkert/sublime-markdown-extended
[Atom Markdown Preview]:https://github.com/atom/markdown-preview
[IDEA Markdown]:https://github.com/nicoulaj/idea-markdown
[cmd Markdown]:https://www.zybuluo.com/cmd/
[StactEdit]:https://stackedit.io  
[Dillinger]:http://dillinger.io
