---
title: LEDE-Mt7620a-newifiY1
date: 2017-03-16 23:56:12
tags: [Linux,openwrt,路由器,LEDE]
categories: 嵌入式
---

LEDE:
<https://downloads.lede-project.org>

LEDE Packages(mipsel_24kc):<http://openwrt-dist.sourceforge.net/packages/LEDE/base/mipsel_24kc/>

<!--more-->

---

```
root@LEDE:/tmp# opkg install libudns_0.4-1_mipsel_24kc.ipk
Installing libudns (0.4-1) to root...
Configuring libudns.
root@LEDE:/tmp# opkg install shadowsocks-libev_3.0.3-1_mipsel_24kc.ipk luci-app-shadowsocks_1.6.2-1_all.ipk
Installing shadowsocks-libev (3.0.3-1) to root...
Installing libev (4.22-1) to root...
Downloading http://downloads.lede-project.org/releases/17.01.0/packages/mipsel_24kc/packages/libev_4.22-1_mipsel_24kc.ipk
Installing libpcre (8.40-1) to root...
Downloading http://downloads.lede-project.org/releases/17.01.0/packages/mipsel_24kc/packages/libpcre_8.40-1_mipsel_24kc.ipk
Installing libsodium (1.0.11-2) to root...
Downloading http://downloads.lede-project.org/releases/17.01.0/packages/mipsel_24kc/packages/libsodium_1.0.11-2_mipsel_24kc.ipk
Installing libmbedtls (2.4.0-2) to root...
Downloading http://downloads.lede-project.org/releases/17.01.0/packages/mipsel_24kc/base/libmbedtls_2.4.0-2_mipsel_24kc.ipk
Installing luci-app-shadowsocks (1.6.2-1) to root...
Configuring libev.
Configuring libpcre.
Configuring libsodium.
Configuring libmbedtls.
Configuring shadowsocks-libev.
Configuring luci-app-shadowsocks.
```
---

```
root@LEDE:/tmp# opkg install ChinaDNS_1.3.2-4_mipsel_24kc.ipk luci-app-chinadns_1.6.0-1_all.ipk
Installing ChinaDNS (1.3.2-4) to root...
Installing luci-app-chinadns (1.6.0-1) to root...
Configuring ChinaDNS.
Configuring luci-app-chinadns.
```



---
```
root@LEDE:/tmp# opkg install dns-forwarder_1.1.1-1_mipsel_24kc.ipk luci-app-dns-forwarder_1.6.0-1_all.ipk
Installing dns-forwarder (1.1.1-1) to root...
Installing luci-app-dns-forwarder (1.6.0-1) to root...
Configuring dns-forwarder.
Configuring luci-app-dns-forwarder.
```


---
# Kcptun+Shadowsocks


open source Project：

+ openwrt kcptun https://github.com/bettermanbao/openwrt-kcptun
+ More details please refer to https://github.com/xtaci/kcptun
+ luci-app-kcptun please refer to https://github.com/kuoruan/luci-app-kcptun
+ GUI for KCPTun windows client https://github.com/dfdragon/kcptun_gclient
+ Kcptun for Android https://github.com/shadowsocks/kcptun-android

> 两端参数必须一致的有:
>  
> datashard --前向纠错  
  parityshard --前向纠错\
  nocomp --压缩\
  key --密钥\
  crypt --加密算法\
  其余为两边可独立设定的参数



---


```
nocomp;mtu=1200;parityshard=0;key=waggywn@10000 dscp=46;mode=fast;crypt=salsa20;sndwnd=1024;rcvwnd=2048
```
