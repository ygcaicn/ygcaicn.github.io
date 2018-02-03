---
title: Linux下python3测试网速
layout: post
comments: true
date: 2018-01-15 20:09:42
timestamp:
tags: [Ubuntu,Linux,python3]
categories: python3
keywords: Jachin blog Linxu Qt Cpp Ubuntu Python 打造日常使用ubuntu Ubuntu必备软件 python3测试网速
---

# python3实现

python3学习中写的一个小程序，有时候还挺有用，贴出来做记录！

<!--more-->
依赖系统的net-tools工具，也就是ifconfig命令。
实现原理利用ifconfig查看网卡发送和接受的数据多少，利用re匹配出需要的数据，利用time模块计时算出
1s内发送或者接收数据的多少！

*Note* 依赖系统的net-tools工具，也就是ifconfig命令。
```
sudo apt-get install net-tools
```
python3代码：
```py
#!/usr/bin/env python3
import subprocess
import re
import time

def get_total(xdata):
    s = set([(e[0],e[2]) for e in xdata])
    d = dict(s)
    d.pop('lo')
    l=list(d.values())
    li = [int(i) for i in l]
    return sum(li)

def show(delta):
    if delta < 1024:
        n = int(delta)
        s = 'B'
    elif delta < 1024*1024:
        n = delta//1024
        s = 'KB'
    else:
        n = round(delta/(1024*1024),1)
        s = 'MB'
    return str(n)+s+'/S'

if __name__ == '__main__':
    cmd = ['ifconfig']
    rx_pat = re.compile(r'\b(\w+)\b:(.+\s+)+?RX.+?bytes\s+(\d+)')
    tx_pat = re.compile(r'\b(\w+)\b:(.+\s+)+?TX.+?bytes\s+(\d+)')
    try:
        while True:
            out_bytes = subprocess.check_output(cmd)
            out_str = out_bytes.decode('utf-8')
            rx = rx_pat.findall(out_str)
            tx = tx_pat.findall(out_str)
            rx_data1 = get_total(rx)
            tx_data1 = get_total(tx)
            time.sleep(1)
            out_bytes = subprocess.check_output(cmd)
            out_str = out_bytes.decode('utf-8')
            rx = rx_pat.findall(out_str)
            tx = tx_pat.findall(out_str)
            rx_data2 = get_total(rx)
            tx_data2 = get_total(tx)
            subprocess.call("clear")
            print("↑:"+show(tx_data2-tx_data1))
            print("↓:"+show(rx_data2-rx_data1))       

    except subprocess.CalledProcessError as e:
        out_bytes = e.output    # Output generated before error
        code = e.returncode     # Return code
```
# 其他软件包实现--iftop

```sh
sudo apt-get update
sudo apt-get install iftop
sudo iftop -n
```

# Reference
* <http://os.51cto.com/art/201404/435279.htm>

# 每天进步一点点!!!

## **impossible is I'm possible!!!**
