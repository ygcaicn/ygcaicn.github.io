---
title: python基础
tags: [python]
categories: python3
date: 2017-05-04 15:25:36
timestamp: 20170504152536
comments: true
keywords: Python
description:
photos:
  - http://i.imgur.com/3GmPd7O.png
---

# Strings
>A string is a sequence of values that represent Unicode code points. All the code points in the range U+0000 - U+10FFFF can be represented in a string. Python doesn’t have a char type; instead, every code point in the string is represented as a string object with length 1. The built-in function ord() converts a code point from its string form to an integer in the range 0 - 10FFFF; chr() converts an integer in the range 0 - 10FFFF to the corresponding length 1 string object. `str.encode()` can be used to convert a str to bytes using the given text encoding, and `bytes.decode()` can be used to achieve the opposite.

<!--more-->

```py
#str->bytes  
str.encode(encoding='UTF-8')

#bytes->str  
bytes.decode(encoding='UTF-8')
```


document https://docs.python.org/

```
urllib  
     urllib.error Exception classes raised by urllib.request.
     urllib.parse Parse URLs into or assemble them from components.
     urllib.request Extensible library for opening URLs.
     urllib.response Response classes used by urllib.
     urllib.robotparser Load a robots.txt file and answer questions about fetchability of other URLs.
```


# 标准数据类型
* Python3 中有六个标准的数据类型：
* Number（数字）    123
* String（字符串）  'abc'/"abc"
* List（列表）      []
* Tuple（元组）     ()
* Sets（集合）      ({})
* Dictionary（字典）{key:value}
*


>I have a tuple of tuples from a MySQL query like this:
```
T1 = (('13', '17', '18', '21', '32'),
      ('07', '11', '13', '14', '28'),
      ('01', '05', '06', '08', '15', '16'))
```
I'd like to convert all the string elements into integers and put it back nicely to list of lists this time:
```
T2 = [[13, 17, 18, 21, 32], [7, 11, 13, 14, 28], [1, 5, 6, 8, 15, 16]]
```
I tried to achieve it with eval but didn't get any decent result yet.
```
[[int(column) for column in row] for row in T1]
```



# 一张图看Python
![Imgur](http://i.imgur.com/gAdiDlB.png)




# Python网络编程-百度语音接口实例
```py
#
  1 #!/usr/bin/python3
  2
  3 import urllib
  4 import urllib.request
  5 import urllib.parse
  6 import json
  7 import os
  8 import sys
  9 import hashlib
 10 import uuid
 11 import base64
 12
 13 class BaiduRest:
 14         def __init__(self,cu_id,api_key,api_secret):
 15                 self.toKen_url = "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=%s&client_secret=%s&"
 16                 self.getVoice_url = "http://tsn.baidu.com/text2audio"
 17                 self.upVoice_url = 'http://vop.baidu.com/server_api'
 18                 self.cu_id = cu_id
 19                 self.api_key = api_key
 20                 self.api_secret = api_secret
 21                 if not  os.path.isdir("./cache/"):
 22                         os.mkdir("./cache/")
 23                         os.mkdir("./cache/audio")
 24                 if not  os.path.isdir("./cache/audio"):
 25                         os.mkdir("./cache/audio")
 26                 try:
 27                         file_toKen = open("./cache/access_toKen",'r')
 28                         self.toKen = file_toKen.read()
 29                 except FileNotFoundError:
 30                         self.getToKen(api_key,api_secret)
 31                 pass
 32
 33
 34         def getToKen(self,api_key,api_secret):
 35                 self.toKen_url = self.toKen_url % (api_key,api_secret)
 36                 r_str = urllib.request.urlopen(self.toKen_url).read()
 37                 r_str = r_str.decode(encoding="UTF-8")
 38                 r_json = json.loads(r_str)
 39                 self.toKen = r_json["access_token"]
 40                 file_toKen = open("./cache/access_toKen","w")
 41                 file_toKen.write(self.toKen)
 42                 file_toKen.close()
 43                 pass
 44
 45         def getVoice(self,text,filename):
 46                 #POST
 47                 params = urllib.parse.urlencode({'tex':urllib.parse.quote(text),'lan':'zh','cuid':self.cu_id,'ctp':1,'tok':urllib.parse.quote(self.toKen)})
 48                 real_url = urllib.request.Request(self.getVoice_url,params.encode("utf-8"))
 49                 httpResponse = urllib.request.urlopen(real_url)
 50                 if httpResponse.getheader('Content-type') == 'audio/mp3':
 51                         #print("toKen successful!")
 52                         #os.system('date')
 53                         file_mp3 = open(filename,"wb+")
 54                         file_mp3.write(httpResponse.read())
 55                         file_mp3.close()
 56                 else:
 57                         self.getToKen(self.api_key,self.api_secret)
 39                 self.toKen = r_json["access_token"]
 40                 file_toKen = open("./cache/access_toKen","w")
 41                 file_toKen.write(self.toKen)
 42                 file_toKen.close()
 43                 pass
 44
 45         def getVoice(self,text,filename):
 46                 #POST
 47                 params = urllib.parse.urlencode({'tex':urllib.parse.quote(text),'lan':'zh','cuid':self.cu_id,'ctp':1,'tok':urllib.parse.quote(self.toKen)})
 48                 real_url = urllib.request.Request(self.getVoice_url,params.encode("utf-8"))
 49                 httpResponse = urllib.request.urlopen(real_url)
 50                 if httpResponse.getheader('Content-type') == 'audio/mp3':
 51                         #print("toKen successful!")
 52                         #os.system('date')
 53                         file_mp3 = open(filename,"wb+")
 54                         file_mp3.write(httpResponse.read())
 55                         file_mp3.close()
 56                 else:
 57                         self.getToKen(self.api_key,self.api_secret)
 54                         file_mp3.write(httpResponse.read())
 54                         file_mp3.write(httpResponse.read())
 54                         file_mp3.write(httpResponse.read())
 55                         file_mp3.close()
 56                 else:
 57                         self.getToKen(self.api_key,self.api_secret)
 58                         self.getVoice(text,filename)
 59
 60                 pass
 61         def getText(self, filename):
 62                 data = {}
 63                 data['format'] = 'wav'
 64                 data['rate'] = 16000
 65                 data['channel'] = 1
  6                 data['cuid'] = self.cu_id
 67                 data['token'] = self.toKen
 68                 wav_fp = open(filename,'rb')
 69                 voice_data = wav_fp.read()
 70                 data['len'] = len(voice_data)
 71                 data['speech'] = base64.b64encode(voice_data).decode('utf-8')
 72                 post_data = json.dumps(data)
 73                 reque = urllib.request.Request(self.upVoice_url,post_data.encode(encoding="UTF-8"))
 74                 r_data = urllib.request.urlopen(reque).read()
 75                 # 3.处理返回数据
 76                 r_json = json.loads(r_data.decode(encoding='utf-8'))
 77                 if 'result' in r_json:
 78                         return  r_json['result']
 79                 else:
 80                         print(r_json)
 81                         return r_json['err_no']
 82
 83 if __name__ == "__main__":
 84         os.system('date')
 85         api_key = "6PPBMVeF1BIWbXmNuUfEivK3"
 86         api_secret = "0c5ee6597954b09bee9083624ff3d9a4"
 87         text = sys.argv[1]
 88         tmpname_wav = hashlib.md5(text.encode(encoding="UTF-8")).hexdigest() + '.wav'
 89         tmpname_wav = './cache/audio/' + tmpname_wav
 90         if os.path.isfile(tmpname_wav):
 91                 print("exist!")
 92                 os.system("omxplayer --loop \"" + tmpname_wav + '\"')
 93         else:
 94                 mac = uuid.UUID(int = uuid.getnode()).hex[-12:]
 95                 mac = ":".join([mac[e:e+2] for e in range(0,11,2)])
 96                 baiduVoice = BaiduRest(mac,api_key,api_secret)
 97                 baiduVoice.getVoice(text,tmpname_wav)
 98                 os.system('date')
 99                 #os.system("omxplayer --loop \"" + tmpname_wav + "\"")
100                 print(baiduVoice.getText(tmpname_wav))
101
102
```

# urllib.request

## get

```
from urllib import request, parse
# Base URL being accessed
url = 'http://httpbin.org/get'
# Dictionary of query parameters (if any)
parms = {
'name1' : 'value1',
'name2' : 'value2'
}
# Encode the query string
querystring = parse.urlencode(parms)
# Make a GET request and read the response
u = request.urlopen(url+'?' + querystring)
resp_bytes = u.read()

```
## post

### post stand fomer

```
from urllib import request, parse
# Base URL being accessed
url = 'http://httpbin.org/post'
# Dictionary of query parameters (if any)
parms = {
'name1' : 'value1',
'name2' : 'value2'
}
# Encode the query string
querystring = parse.urlencode(parms)
# Make a POST request and read the response
res = request.urlopen(url, querystring.encode(encoding = 'utf-8'))
html_str = res.read()
```

### post json

```
parms = {
'name1' : 'value1',
'name2' : 'value2'
}
post_data = json.dumps(parms)
res = urllib.request.urlopen(url,post_data.encod(encoding="utf-8"))
html_str =res.read()
```


## header

```
from urllib import request, parse

# Extra headers
headers = {
'User-agent' : 'none/ofyourbusiness',
'Spam' : 'Eggs'
}
req = request.Request(url, querystring.encode('ascii'), headers=headers)
# Make a request and read the response
res = request.urlopen(req)
html_str = res.read()
```

### header example
```
    headers={
    'Connection': 'keep-alive',
    'Cache-Control': 'max-age=0',
    'Upgrade-Insecure-Requests': 1,
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate, sdch',
    'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6'
    }
```

```
Content-Type: application/x-www-form-urlencoded
Content-Type: application/json
```


## Request

```
GET / HTTP/1.1
Host: ip.cn
Connection: keep-alive
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate, sdch
Accept-Language: zh-CN,zh;q=0.8,en;q=0.6
Cookie: UM_distinctid=15ae0d3744b437-0ebcb4eece40e4-57e1b3c-100200-15ae0d3744c42b; CNZZDATA123770=cnzz_eid%3D646344926-1484393339-%26ntime%3D1489830206


```

## Response

encoding:gzip

![Imgur](http://i.imgur.com/gNVZvxJ.png)

when unzip the body,we can see:

```
HTTP/1.1 200 OK
Server: nginx/1.8.0
Date: Sat, 18 Mar 2017 10:54:28 GMT
Content-Type: text/html; charset=UTF-8
Connection: keep-alive
Vary: Accept-Encoding
X-Powered-By: PHP/5.6.30-1~dotdeb+7.1
Content-Length: 3189

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="http://s.ip-cdn.com" rel="dns-prefetch" />
<title>IP.cn - IP 地址查询 | 地理位置 | 手机归属地</title>
<meta name="robots" content="all" />
<meta name="Keywords" content="ip,ip查询,手机ip,本机ip,外网ip,ip地址查询,手机号,归属地">
<meta name="Description" content="专业本机 IP 地址查询、手机 IP 地址、地理位置查询、IP 数据库、手机号归属地查询、电话号码黄页查询，可查广告、骚扰、快递、银行、保险、房地产、中介电话。">
<link href='http://s.ip-cdn.com/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
<meta name="viewport" content="width=device-width, minimum-scale=0.5">
<meta name="format-detection" content="telephone=no">
<!--[if lt IE 8]>
<script src="http://s.ip-cdn.com/js/ie8.js"></script>
<![endif]-->
<link href='http://s.ip-cdn.com/css/main.css' rel='stylesheet' type='text/css'>
</head>
<body onLoad="document.fs.ip.focus()">
.
.
.
</body>
</html>

```

# 参考
## 入门
[Python3教程](http://www.runoob.com/python3/python3-tutorial.html)

## 进阶技巧
[python3-cookbook](https://github.com/yidao620c/python3-cookbook)
[readthedocs](http://docspy3zh.readthedocs.io/en/latest/index.html)
[python-requests](http://cn.python-requests.org/zh_CN/latest/)

httbin.org
