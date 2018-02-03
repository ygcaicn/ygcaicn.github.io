---
title: Python3 实现代理IP,伪装IP
date: 2017-03-19 02:43:36
tags: [Python3,正则表达式,IP伪装,代理]
categories: python3
---

实现抓取代理服务器，建立ipPool,伪装外网ip

<!--more-->

# Proxy

```py
#!/usr/bin/python3

import urllib.request
import re
import gzip

def ungzip(data):
    try:        # try decompress
        print('compressing.....')
        data = gzip.decompress(data)
        print('dcompress done!')
    except:
        print('without compress!')
    return data

class Proxy:
    def __init__(self,url='http://www.xicidaili.com/'):
        self.ipPool=[]
        self.url=url
        self.getipPool();

    def getipPool(self):     
        #get proxy Ip address pool from http://www.xicidaili.com/
        # Base URL being accessed
        headers={
        'Connection': 'keep-alive',
        'Cache-Control': 'max-age=0',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding': 'gzip, deflate, sdch',
        'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6',
        }
        # Make a GET request and read the response
        req = urllib.request.Request(self.url,headers=headers)
        response = urllib.request.urlopen(req)
        res_bytes = ungzip(response.read())
        html_str = res_bytes.decode(encoding='utf-8')

        # the pattern(Regular expression) is depend on the response data from your url
        pattern = r'\s*<td>(((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?))</td>\s*\n\s*<td>(\d{2,5})</td>\s*\n\s*<td>(\w+)</td>\s*\n\s*<td class="country">透明</td>\s*\n\s*<td>(HTTP|HTTPS)</td>'
        regex = re.compile(pattern)
        s = regex.findall(html_str)
        #s = [('221.204.103.145', '103.', '103', '145', '9797', '山西太原', 'HTTP'), ...]
        for host in s:
            hostdict = {'host':host[0],'port':host[4],'country':host[5],'protocol':host[-1]}
            self.ipPool.append(hostdict)
        return self.ipPool


    def startProxy(self):

        self.printIpPool();
        host_num = input('Please select a host:')
        host_num = int(host_num.strip())        
        proxy = {'http':self.ipPool[host_num]['host']+':'+self.ipPool[host_num]['port']}
        #creat ProxyHandler
        proxy_support = urllib.request.ProxyHandler(proxy)
        #creat Opener
        opener = urllib.request.build_opener(proxy_support)
        #creat User Angent
        #opener.addheaders = [('User-Agent','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36')]
        #install OPener
        urllib.request.install_opener(opener)
        #start Opener
        pass

    def printIpPool(self):
        for i in range(0,len(self.ipPool)):
            print(i,":",self.ipPool[i])



if __name__ == '__main__':

    url = "http://ip.cn/"
    headers={
    'Connection': 'keep-alive',
    'Cache-Control': 'max-age=0',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate, sdch',
    'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6',
    #'Cookie': 'UM_distinctid=15ae0d3744b437-0ebcb4eece40e4-57e1b3c-100200-15ae0d3744c42b; CNZZDATA123770=cnzz_eid%3D646344926-1484393339-%26ntime%3D1489830206'
    }
    proxyhost = Proxy()
    proxyhost.startProxy()

    req = urllib.request.Request(url,headers=headers)
    response = urllib.request.urlopen(req)
    res_bytes = ungzip(response.read())

    html_str = res_bytes.decode(encoding='utf-8')
    file_html = open("proxy.html",'w',encoding = "utf-8")
    file_html.write(html_str)
    file_html.close()

    # the pattern(Regular expression) is depend on the response data from your url
    #pattern = r'((\d{1,3}\.){3}\d{1,3})'
    pattern = r'<code>(((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?))</code>'

    pattern2 = r'所在地理位置：<code>([\s\w]*)</code>'
    my_locate = re.findall(pattern2,html_str)
    my_locate = my_locate[0]
    my_ip = re.findall(pattern,html_str)
    my_ip = my_ip[0][0]
    #print(html_str)
    print('my locate:',my_locate)
    print('my ip:',my_ip)

```
# get proxy Ip address pool from http://www.xicidaili.com/

直接get得到主页以后，主要是写正则表达式，match得到我们需要的数据。

得到的html数据：

```html
</tr>
  <tr class="subtitle">
    <th class="country">国家</th>
    <th>代理IP地址</th>
    <th>端口</th>
    <th width="20%">服务器地址</th>
    <th class="country">是否匿名</th>
    <th>类型</th>
          <th width="11%">存活时间</th>
    <th width="12%">验证时间</th>
  </tr>

  <tr class="odd">
    <td class="country"><img src="http://fs.xicidaili.com/images/flag/cn.png" alt="Cn" /></td>
    <td>115.231.175.68</td>
    <td>8081</td>
    <td>浙江杭州</td>
    <td class="country">透明</td>
    <td>HTTP</td>
      <td>74天</td>
    <td>不到1分钟</td>
  </tr>

  <tr class="">
    <td class="country"><img src="http://fs.xicidaili.com/images/flag/cn.png" alt="Cn" /></td>
    <td>220.191.1.130</td>
    <td>8118</td>
    <td>浙江杭州</td>
    <td class="country">透明</td>
    <td>HTTP</td>
      <td>16小时</td>
    <td>1分钟前</td>
  </tr>

  <tr class="odd">
    <td class="country"><img src="http://fs.xicidaili.com/images/flag/cn.png" alt="Cn" /></td>
    <td>124.88.67.54</td>
    <td>80</td>
    <td>新疆乌鲁木齐</td>
    <td class="country">透明</td>
    <td>HTTP</td>
      <td>723天</td>
    <td>13分钟前</td>
  </tr>

  <tr class="">
    <td class="country"><img src="http://fs.xicidaili.com/images/flag/cn.png" alt="Cn" /></td>
    <td>58.221.59.210</td>
    <td>63000</td>
    <td>江苏南通</td>
    <td class="country">透明</td>
    <td>HTTP</td>
      <td>362天</td>
    <td>1小时前</td>
  </tr>
  ```
![Imgur](http://i.imgur.com/7h07pqS.png)

我们这里匹配出主机ip（host），port，country和protocol，利用[deerchao的正则表达式测试器](http://deerchao.net/)很设计出下面的正则表达式：


`#the pattern(Regular expression) is depend on the response data from your url`

`pattern = r'\s*<td>(((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?))</td>\s*\n\s*<td>(\d{2,5})</td>\s*\n\s*<td>(\w+)</td>\s*\n\s*<td class="country">透明</td>\s*\n\s*<td>(HTTP|HTTPS)</td>'`

最终的效果：
    运行程序，会提示我们选择一个代理服务器，程序然后会去访问[ip.cn](http://ip.cn),通过返回的数据我们解析得到外网IP，会发现这和我们选择的代理服务器信息是一致的而不是我们自己的外网地址。ip伪装成功。

![Imgur](http://i.imgur.com/XIxBJUK.png)

# 参考
正则表达式：http://deerchao.net/tutorials/regex/regex.htm
