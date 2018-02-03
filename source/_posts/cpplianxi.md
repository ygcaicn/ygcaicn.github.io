---
title: C++练习笔记（持续更新）
date: 2016-10-24 19:28:32
tags: [Cpp]
categories: Cpp
keywords: Cpp程序练习
---

# 前言

由于近一年来学习嵌入式大多接触的都是纯C语言，直到看到学校搞了一个程序设计大赛，才发现自己的C++的基础遗忘了好多。
不过这也是正常的，毕竟三天不练手生，学习其他知识的同时不要忘记基础！！将练习记录写在博客中一来方便以后查阅，而来和大家一起学习！

查了查以前囤下的C++API手册发现是C++98的，这有点让我不开心了，于是上网搜寻了一番，发现没有找到好的本地手册，oschina的手册做的不能再垃圾，连个search都没有。去一些[cpp的权威网站](http://www.cplusplus.com/)当然是英文的，但是发现不怎么活跃。这怎么能满足我这种完美主义的程序爱好者呢。。。最后搜寻了一番终于找到了满意的手册，不过美中不足的是不能本地化。不过这也没什么这说明网站更新活跃嘛！下面附上链接，欢迎各位`Ctrl+D`:

[Cpp编程手册](http://zh.cppreference.com/w/%E9%A6%96%E9%A1%B5)

[cplusplus reference](http://www.cplusplus.com/reference/)

<!--more-->

*本文程序大多基于C++11特性，除非特别声明！！*

# 输入不定量数据，求和

```C++
int main()
{
int sum = 0, val = 0;
cout << "输入一组数据，以Ctrl+Z结束,Enter 计算" << endl;
while (cin >> val)
sum += val;
cout << "sum=" <<sum<< endl;
system("pause");
  return 0;
}
```

# 将字符串的小写转换为大写，统计字符串等

string 引用

```C++
#include "stdafx.h"
#include "cctype"
using namespace std;
int main()
{
string str;
getline(cin, str);
for (auto &c : str)
{
//if(c>='a'&&c<='z')
if(islower(c))
{
c = c - 'a' + 'A';
}
}
cout << str<<endl;
system("pause");
  return 0;
}
```

# A+B probles的一道Acm题

    Description
    Calculate a + b
    Input
    The input will consist of a series of pairs of integers a and b,separated by a space, one pair of integers per line.
    Output
    For each pair of input integers a and b you should output the sum of a and b in one line,and with one line of output for each line in input.
    Sample Input
    1 2
    3 4

    Sample Output
    3
    7


```c++
#include "stdafx.h"
#include <vector>
using namespace std;
int main()
{
int a, b;
vector<int> slove;
int tmp;

while (cin >> a&&cin >> b)
{
tmp= (a + b);
slove.push_back(tmp);
}
for(auto i:slove)
cout << (int)i << endl;
system("pause");
  return 0;
}
```

~~无奈这么写上传之后直接编译不通过。。。看来acm的系统是不支持C++11特性的。。~~明天再写C++98的吧。。

看来是我太不了解OJ了，回头好好学习一下OJ的基本输入和输出。下面附上正确的程序：

```cpp
#include<iostream>
using namespace std;
int main()
{
	int a, b;
	while (cin >> a >> b)
	{
		cout << a + b << endl;
	}
	return 0;
}
```

# char * 数组的遍历操作
> 输入字符串若满足：首字母大写，后面全为小写返回1，否则返回0。如Hello满足条件

```c++
int fun(char *str)
{
	if ((*str)>'A' && (*str)<'Z')
	{
		while (*(++str))
		{
			if ((*str)<'a' || (*str)>'z')
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}
```


> 将输入的字符串中的字符全部变为ASCII码表中的下一个字符.

```cpp
void fun(char *str)
{
	int i = 0;
		while (*(str+i))
		{
			(*(str + i))++;
			i++;
		}
}
```

> 寻找两个字符串第一个不同的位置,下标从0开始，如果全部相同返回-1

```cpp
int fun(char *str1, char *str2)
{
	size_t length = strlen(str1);
	size_t length2 = strlen(str2);
	length = length < length2 ? length:length2;
	int i;
	for (i = 0; i < length; i++)
	{
		char c1 = str1[i], c2 = str2[i];

		if (c1 > 'a'&&c1 < 'z')
			c1 = c1 - ('a' - 'A');
		if (c2 >= 'a'&&c2 <= 'z')
			c2 = c2 - ('a' - 'A');
		if (c1!=c2)
			break;
	}
  if (i == length)
      return -1;
	return i;
}
```


# 检索出字符串中出现最多的字符，并返回该字符

> ASCII共定义了256个代码(从0-255)，从0-32位为控制字符(33个)(ASCII control characters)，从33-127位为可打印字符(95个)(ASCII printable characters)。从0-127是标准的ASCII编码，从128-255是扩展的ASCII编码。

```cpp
#include "stdafx.h"
#include<iostream>
#include <string>
using namespace std;

//检索出字符串中出现最多的字符，并返回该字符
char fun(char *str)
{
	char *tstr = str;
	int tmp[100] = {0};
	while (*tstr)
	{
		//相对首个可打印字符位置
		tmp[int(*tstr)-32]++;
		tstr++;
	}
	//去除大小写差异
	for (int i = 'A'-32;i<='Z'-32; i++)
	{
		tmp[i] += tmp[i + 'a' - 'A'];
	//	tmp[i + 'a' - 'A']=tmp[i];
	}
	//找到最大的
	char maxstr = 0;
	int maxnum = 0;
	for (int i = 0; i < 100; i++)
	{
		if (tmp[i] > maxnum)
		{
			maxnum = tmp[i];
			maxstr = i;
		}		
	}
	//判断是否只出现大写或只出现小写
	//大小写同时出现返回大写
	if (tmp[maxstr] > tmp[maxstr + 'a' - 'A'])
		maxstr += 32;
	else
	maxstr += 32+'a' - 'A';
	return maxstr;
}
int main()
{
	char str[100];
	cin >> str;
	cout << "次数最多的是：" << fun(str) << endl;
	system("pause");
	return 0;
}
```

同样的要求，一位大神给出的程序，让我看到了差距：

```cpp
char fun(char *str)
{
	char o = 'a' - 'A';
	char c = '\0';
	//存储ASCII256个字符的的出现次数
	int data[256];
	memset(data, 0, 256 * sizeof(int));
	size_t length = strlen(str);
	//遍历字符串
	for (int i = 0; i<length; i++)
	{
		c = str[i];
		data[c]++;
		if (c >= 'A' && c <= 'Z' && data[c + o] > 0)
		{
			data[c + o]++;
		}
		if (c >= 'a' && c <= 'z' && data[c - o] > 0)
		{
			data[c - o]++;
		}
	}

	//找出最大的
	char result = '\0';
	int maxNumber = 0;
	for (int i = 0; i<256; i++)
	{
		int number = data[i];
		if (number > maxNumber)
		{
			result = i;
			maxNumber = number;
		}
	}
	return result;
}
```



# getline获取一行输入，以回车符触发getline结束，且不保存最后的回车符

空行结束输入，（注意与文件尾EOF结束的区别）

```C++
#include "stdafx.h"
#include <iostream>
#include <vector>
using namespace std;
int main()
{
     string str;
     vector <string> vec;
while (getline(cin,str)&&!str.empty())
{
     vec.push_back(str);
}
for (auto i : vec)
{
     cout << i<< endl;
}
system("pause");
return 0;
}
```

# vector列表初始化，元素引用

```C++
#include "stdafx.h"
#include <iostream>
#include <vector>
using namespace std;
int main()
{
	//构造函数初始化
	//vector <int> vec(10,1);
	//列表初始化
	vector <int> vec = {1,2,3,4,5,6,7,8,9};

	for (auto &i : vec)
	{
		i = i*i;
		cout << i<< '\t';
	}
	system("pause");
	return 0;
}
```

# [vector常用操作](http://zh.cppreference.com/w/cpp/container/vector)

```cpp
vec.empty()  //如果vec不含有任何元素返回真，否则返回假
vec.size()  //返回元素的个数
vec.push_back()  //添加元素
vex.pop_back()   //删除元素
//……更多参见[cppreference](http://zh.cppreference.com/w/cpp/container/vector)
```

# 迭代器

迭代器类似于指针类型，提供了我们间接访问对象的方法。我们利用指针可以访问各种数据类型的内容，采用的是 * 符进行

# 每天进步一点点!!!

## **impossible is I'm possible!!!**
